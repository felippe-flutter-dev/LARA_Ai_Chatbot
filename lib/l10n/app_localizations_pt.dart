// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get common_appName => 'LARA';

  @override
  String get common_appSlogan => 'Sua parceira de IA com senso de humor.';

  @override
  String get common_onlineStatus => 'Online';

  @override
  String get common_buttonBack => 'Voltar';

  @override
  String get common_loading => 'Carregando...';

  @override
  String get common_errorGeneric =>
      'Ocorreu um erro. Por favor, tente novamente.';

  @override
  String get common_deleteSuccessMessage => 'Excluído com sucesso!';

  @override
  String get login_welcomeTitle => 'Bem-vindo à LARA';

  @override
  String get login_welcomeSubtitle =>
      'Sua parceira de IA com senso de humor 😉';

  @override
  String get login_buttonGoogle => 'Entrar com Google';

  @override
  String get login_buttonEmail => 'Entrar com E-mail';

  @override
  String get login_footerPrefix => 'Ao continuar, você concorda com os ';

  @override
  String get login_footerTerms => 'Termos de Serviço';

  @override
  String get login_footerAnd => ' e ';

  @override
  String get login_footerPrivacy => 'Política de Privacidade';

  @override
  String get auth_loginEmailTitle => 'Login com E-mail';

  @override
  String get auth_registerTitle => 'Crie sua conta';

  @override
  String get auth_emailLabel => 'E-mail';

  @override
  String get auth_passwordLabel => 'Senha';

  @override
  String get auth_confirmPasswordLabel => 'Confirmar Senha';

  @override
  String get auth_buttonLogin => 'Entrar';

  @override
  String get auth_buttonRegister => 'Cadastrar';

  @override
  String get auth_noAccount => 'Não tem uma conta? ';

  @override
  String get auth_registerLink => 'Cadastre-se';

  @override
  String get auth_registerSuccess =>
      'Cadastro realizado com sucesso! Faça login.';

  @override
  String get bio_welcomeBack => 'Bom te ver de novo!';

  @override
  String get bio_authRequired =>
      'Autenticação necessária. Use sua biometria para desbloquear a LARA e continuar suas conversas.';

  @override
  String get bio_buttonUnlock => 'Desbloquear com Biometria';

  @override
  String get bio_notYou => 'Não é você? ';

  @override
  String get bio_switchAccount => 'Entrar com outra conta';

  @override
  String get bio_dialogEnableTitle => 'Ativar Biometria?';

  @override
  String get bio_dialogEnableMessage =>
      'Quer entrar mais rápido na próxima vez? Ative o FaceID ou Digital para proteger seus chats sem precisar de um novo link de e-mail.';

  @override
  String get bio_buttonEnableNow => 'Ativar Agora';

  @override
  String get bio_buttonMaybeLater => 'Agora Não';

  @override
  String get bio_systemTitle => 'Autentique para Conversar';

  @override
  String get bio_systemSubtitle =>
      'A LARA precisa ter certeza de que é você antes de continuarmos nosso papo.';

  @override
  String get bio_fingerprintHint => 'Toque no sensor de digital';

  @override
  String get bio_usePassword => 'Usar Senha';

  @override
  String get bio_errorAuth =>
      'Falha na autenticação biométrica. Tente novamente.';

  @override
  String get drawer_title => 'Conversas';

  @override
  String get drawer_buttonNewChat => 'Novo Chat';

  @override
  String get drawer_emptyConversations => 'Nenhuma conversa ainda';

  @override
  String get drawer_chatSubtitleDefault => 'Pode sugerir algumas di...';

  @override
  String time_days(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count dias',
      one: 'há 1 dia',
    );
    return '$_temp0';
  }

  @override
  String time_hours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count horas',
      one: 'há 1 hora',
    );
    return '$_temp0';
  }

  @override
  String time_minutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'há $count minutos',
      one: 'há 1 minuto',
    );
    return '$_temp0';
  }

  @override
  String get time_just_now => 'agora mesmo';

  @override
  String get drawer_footerVersion => 'LARA AI v1.0 • Feito com ❤️';

  @override
  String get chat_inputHint => 'Digite aqui...';

  @override
  String get chat_initialGreeting =>
      'Olá! 👋 Eu sou a LARA, sua assistente inteligente. Em que posso te ajudar (ou te fazer rir) hoje?';

  @override
  String get chat_settingsTitle => 'Configurações da LARA';

  @override
  String get chat_personalityLabel => 'Personalidade';

  @override
  String get chat_personalityNormal => 'Normal';

  @override
  String get chat_personalityConcise => 'Concisa';

  @override
  String get chat_personalitySarcastic => 'Sarcástica';

  @override
  String get chat_temperatureLabel => 'Temperatura';

  @override
  String get chat_maxTokensLabel => 'Máximo de Caracteres';

  @override
  String get chat_buttonSaveSettings => 'Salvar Configurações';

  @override
  String get chat_retryMessage => 'Erro na resposta. Tentar novamente?';

  @override
  String get made_with_love => 'Feito com ❤️ por Felippe Pinheiro';
}
