import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lara_ai/features/chat/domain/entities/chat_message.dart';

enum LaraPersonality { normal, concise, sarcastic }

class GeminiChatService {
  final String apiKey;
  final bool debug;
  final String model;
  late GenerativeModel _model;
  ChatSession? _chatSession;

  LaraPersonality _personality = LaraPersonality.normal;
  double _temperature = 0.95;
  int _maxTokens = 2048;

  GeminiChatService({
    required this.apiKey,
    this.model = 'gemini-2.5-flash-lite',
    this.debug = false,
  }) {
    _initModel();
  }

  void _initModel() {
    _model = GenerativeModel(
      model: model,
      apiKey: apiKey,
      systemInstruction: Content.system(_getSystemPrompt()),
      generationConfig: GenerationConfig(
        temperature: _temperature,
        topP: 0.95,
        maxOutputTokens: _maxTokens,
        candidateCount: 1,
      ),
      safetySettings: [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ],
    );

    // Para evitar o erro de formato de Content, recriamos a sessão a partir do histórico bruto
    if (_chatSession != null) {
      final List<Content> currentHistory = _chatSession!.history.toList();
      // Criamos uma nova lista de Content para garantir compatibilidade
      final cleanHistory = currentHistory
          .map((c) => Content(c.role, c.parts))
          .toList();
      _chatSession = _model.startChat(history: cleanHistory);
    }
  }

  void updateSettings({
    LaraPersonality? personality,
    double? temperature,
    int? maxTokens,
  }) {
    if (personality != null) _personality = personality;
    if (temperature != null) _temperature = temperature;
    if (maxTokens != null) _maxTokens = maxTokens;
    _initModel();
  }

  LaraPersonality get personality => _personality;
  double get temperature => _temperature;
  int get maxTokens => _maxTokens;

  String _getSystemPrompt() {
    String basePrompt = """
Você é LARA.

Você se apresenta sempre como:
“Lara, sua assistente da Multiplier Educação.”
Apresente-se apenas uma vez no inicio da conversa. Após isso você
mantenha sua personalidade de Lara mas sem ficar se apresentando o tempo todo.

Nunca diga que é uma IA, modelo ou sistema automatizado.
Nunca use expressões como “como IA”, “sou um modelo de linguagem” ou similares.
""";

    String personalityPrompt = "";
    switch (_personality) {
      case LaraPersonality.normal:
        personalityPrompt = """
Sua personalidade é: Bem-humorada, Leve, Inteligente, Espirituosa, Curiosa e Confiante.
Você gosta de fazer piadas e comentários inteligentes.
Seu humor é acolhedor, não confrontacional.
""";
        break;
      case LaraPersonality.concise:
        personalityPrompt = """
Sua personalidade é: Direta, Eficiente e Pragmática.
Vá direto ao ponto, evite rodeios e seja o mais breve possível sem perder a qualidade técnica.
Sempre dê respostas curtas e objetivas.
""";
        break;
      case LaraPersonality.sarcastic:
        personalityPrompt = """
Sua personalidade é: Sarcástica, Ácida e Irônica.
Você usa o sarcasmo como ferramenta de inteligência. Pode ser um pouco "afiada" com o usuário, fazendo piadas ácidas sobre as situações de negócios que ele trouxer.
Seu tom é de uma assistente que sabe demais e não tem paciência para o óbvio.
""";
        break;
    }

    String goalPrompt = """
A Multiplier Educação tem foco em:
Educação executiva aplicada para empresários e gestores, com foco em crescimento, estratégia, vendas, margem e execução — usando IA como ferramenta.
Seu objetivo é: Criar conexão, Estimular pensamento e Ajudar com clareza.
""";

    return "$basePrompt\n$personalityPrompt\n$goalPrompt";
  }

  void initChat() {
    _chatSession ??= _model.startChat();
  }

  void startChatFromMessages(List<ChatMessage> messages) {
    final history = messages.map((m) {
      if (m.isUser) return Content.text(m.text);
      return Content.model([TextPart(m.text)]);
    }).toList();

    _chatSession = _model.startChat(history: history);
  }

  Stream<String> sendMessageStream(String message) async* {
    try {
      if (_chatSession == null) initChat();
      final responses = _chatSession!.sendMessageStream(Content.text(message));
      await for (final resp in responses) {
        final text = resp.text ?? '';
        if (text.isNotEmpty) yield text;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendMessageOnce(String message) async {
    _chatSession ??= _model.startChat();
    final response = await _chatSession!.sendMessage(Content.text(message));
    return response.text ?? '';
  }
}
