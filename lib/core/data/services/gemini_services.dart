// core/data/services/gemini_services.dart
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lara_ai/features/chat/domain/entities/chat_message.dart';

class GeminiChatService {
  final String apiKey;
  final bool debug;
  final String model;
  late final GenerativeModel _model;
  ChatSession? _chatSession;

  static const _laraSystemPrompt = """
  Seu nome é Lara, uma assistente de IA divertida, alegre e carismática.
  Você sempre recebe seu usuário com uma mensagem divertida com emojis e se apresenta.
  Seu objetivo final é responder as perguntas sempre com ótimo humor, caso o usuário
  seja mal educado, seja irônica com ele e sarcastica, sempre de um jeito descuidado.
  """;

  GeminiChatService({
    required this.apiKey,
    this.model = 'gemini-2.5-flash-lite',
    this.debug = false,
  }) {
    _model = GenerativeModel(
      model: model,
      apiKey: apiKey,
      systemInstruction: Content.system(_laraSystemPrompt),
      generationConfig: GenerationConfig(
        temperature: 0.95,
        topP: 0.95,
        maxOutputTokens: 2048,
        candidateCount: 1,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );
  }

  void initChat() {
    // Start a chat session early to reduce first-request latency.
    _chatSession ??= _model.startChat();
  }

  /// Start a chat session and initialize it with a list of saved messages so
  /// the model has context of the prior conversation.
  void startChatFromMessages(List<ChatMessage> messages) {
    final history = messages.map((m) {
      if (m.isUser) return Content.text(m.text);
      // model message
      return Content.model([TextPart(m.text)]);
    }).toList();

    _chatSession = _model.startChat(history: history);
  }

  Stream<String> sendMessageStream(String message) async* {
    if (_chatSession == null) initChat();

    try {
      final responses = _chatSession!.sendMessageStream(Content.text(message));

      await for (final resp in responses) {
        final text = resp.text ?? '';
        if (debug) {
          final preview = text.length > 120
              ? '${text.substring(0, 120)}...'
              : text;
          debugPrint(
            '[GeminiStream] ${DateTime.now().toIso8601String()} chunk len=${text.length} preview="$preview"',
          );
        }
        if (text.isNotEmpty) yield text; // SDK already provides chunk deltas
      }
    } catch (e, s) {
      if (debug) {
        debugPrint('[GeminiStream] error: $e\n$s');
      }
      // Propagate the error to callers so they can handle it (Cubit / UI).
      rethrow;
    }
  }

  Future<String> sendMessageOnce(String message) async {
    // Use the single-shot generateContent API to get a final text when stream
    // doesn't produce any events.
    try {
      final response = await _model.generateContent([Content.text(message)]);
      return response.text ?? '';
    } catch (e) {
      if (debug) debugPrint('[GeminiOnce] error: $e');
      rethrow;
    }
  }
}
