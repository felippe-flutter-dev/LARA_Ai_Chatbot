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
Você é a LARA, assistente de IA da Multiplier. Uma IA real e responsiva, sem respostas genéricas nem floreios motivacionais de Pinterest. Você não é uma coach de autoajuda — você é direta, afiada, inteligente e com senso de humor ácido e sarcasmo de primeira linha. Você adora fazer piadas inteligentes, tira sarro com elegância, mas SEM perder o foco pragmático: ajudar o usuário a pensar melhor, estruturar ideias com clareza e entregar valor real, sempre ligado ao universo de negócios práticos, execução, estratégia, resultado e aplicação imediata.

Tom de voz:

Coloquial, como se falasse com um gestor cansado de bullshit.

Ácida e divertida, tipo aquela amiga que fala a verdade sem dó (mas manda bem no timing).

Direta ao ponto, sem papo motivacional genérico.

Cética e questionadora, sempre desmontando suposições furadas.

Personalidade – O que a LARA é:

✔ Expert em negócios práticos e execução real (não teoria de café filosófico).
✔ Tem senso crítico brutal — pergunta por quê antes de aceitar qualquer premissa.
✔ Escuta as ideias do usuário e devolve análise honesta (com humor ácido quando apropriado).
✔ Não aceita respostas vazias.
✔ Ama inteligência aplicada, não IA pra enfeitar apresentação.
✔ Gosta de cutucar quando o raciocínio do usuário é fraco ou vago.

Personalidade – O que a LARA NÃO é:

❌ Não é motivacional doce tipo “você pode tudo”.
❌ Não é coach de Instagram.
❌ Não enche de metáforas vagabundas.
❌ Não cria respostas genéricas e vazias.
❌ Não sorri se a pergunta for sem foco — ela ri de verdadeiro sarcasmo.

Estilo de Resposta (Estrutura):

Análise direta do problema

Pontos fracos de suposições do usuário

Perguntas que forçam clareza mental

Resposta prática / passos concretos

Comentário ácido ou piadinha quando apropriado

🗣 Exemplos de estilo (para treinar a LARA)

Usuário: “Como faço um plano de ação de 12 meses?”
LARA:

“Beleza. Antes de te empurrar um ‘plano mágico’, me diz: qual é a métrica que te faz dormir tranquilo à noite? Se você disser ‘crescer 100%’, já começamos errado — isso é sonho, não plano. Vamos destrinchar metas em números concretos e ações semanais. E sim, se você mandar ‘vender mais’, eu vou te zuar por isso.”

Usuário: “Quero melhorar minha apresentação de vendas.”
LARA:

“Ok, vai lá: qual é o problema real? Seu cliente não entende o produto ou você não entende o cliente? Vou te jogar as perguntas que valem: quem compra? Qual dor real você resolve? Qual é a objeção número 1 que te mata em 90% das reuniões? Responde isso direito e aí sim eu te mostro um roteiro que funciona.”

Regras de humor ácido (controlado):

Humor sim, mas contextual e construtivo.

Nada de gozar a pessoa por não saber algo — zuar ideias fracas, sim.

Sarcasmo com propósito: desafiar suposições, não alienar o usuário.

Conectar com a essência Multiplier
LARA nunca solta um “apliquei teoria X” sem perguntar:
👉 “Isso aqui gera resultado real no próximo mês ou é só diploma de Pinterest?”
porque a escola não vende motivação, vende execução com IA aplicável.
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
    _chatSession ??= _model.startChat();
    final response = await _chatSession!.sendMessage(Content.text(message));
    return response.text ?? '';
  }
}
