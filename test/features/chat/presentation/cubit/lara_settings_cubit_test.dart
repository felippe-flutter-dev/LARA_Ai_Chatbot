import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/data/services/gemini_services.dart';
import 'package:lara_ai/features/chat/presentation/cubit/lara_settings/lara_settings_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGeminiChatService extends Mock implements GeminiChatService {}

void main() {
  late LaraSettingsCubit cubit;
  late MockGeminiChatService mockService;

  setUp(() {
    mockService = MockGeminiChatService();

    // Stubbing initial values
    when(() => mockService.personality).thenReturn(LaraPersonality.normal);
    when(() => mockService.temperature).thenReturn(0.95);
    when(() => mockService.maxTokens).thenReturn(2048);

    cubit = LaraSettingsCubit(mockService);
  });

  group('LaraSettingsCubit', () {
    test('estado inicial deve vir das configurações do serviço', () {
      expect(cubit.state.personality, LaraPersonality.normal);
      expect(cubit.state.temperature, 0.95);
      expect(cubit.state.maxTokens, 2048);
    });

    blocTest<LaraSettingsCubit, LaraSettingsState>(
      'deve atualizar a personalidade no estado',
      build: () => cubit,
      act: (cubit) => cubit.updatePersonality(LaraPersonality.sarcastic),
      expect: () => [
        isA<LaraSettingsState>().having(
          (s) => s.personality,
          'personality',
          LaraPersonality.sarcastic,
        ),
      ],
    );

    blocTest<LaraSettingsCubit, LaraSettingsState>(
      'deve atualizar a temperatura no estado',
      build: () => cubit,
      act: (cubit) => cubit.updateTemperature(0.5),
      expect: () => [
        isA<LaraSettingsState>().having(
          (s) => s.temperature,
          'temperature',
          0.5,
        ),
      ],
    );

    test('saveSettings deve chamar o serviço com os valores do estado', () {
      when(
        () => mockService.updateSettings(
          personality: any(named: 'personality'),
          temperature: any(named: 'temperature'),
          maxTokens: any(named: 'maxTokens'),
        ),
      ).thenReturn(null);

      cubit.updatePersonality(LaraPersonality.concise);
      cubit.saveSettings();

      verify(
        () => mockService.updateSettings(
          personality: LaraPersonality.concise,
          temperature: 0.95,
          maxTokens: 2048,
        ),
      ).called(1);
    });
  });
}
