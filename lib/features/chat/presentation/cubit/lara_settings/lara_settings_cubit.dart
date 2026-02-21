import 'package:bloc/bloc.dart';
import 'package:lara_ai/core/data/services/gemini_services.dart';

class LaraSettingsState {
  final LaraPersonality personality;
  final double temperature;
  final int maxTokens;

  LaraSettingsState({
    required this.personality,
    required this.temperature,
    required this.maxTokens,
  });

  LaraSettingsState copyWith({
    LaraPersonality? personality,
    double? temperature,
    int? maxTokens,
  }) {
    return LaraSettingsState(
      personality: personality ?? this.personality,
      temperature: temperature ?? this.temperature,
      maxTokens: maxTokens ?? this.maxTokens,
    );
  }
}

class LaraSettingsCubit extends Cubit<LaraSettingsState> {
  final GeminiChatService _service;

  LaraSettingsCubit(this._service)
    : super(
        LaraSettingsState(
          personality: _service.personality,
          temperature: _service.temperature,
          maxTokens: _service.maxTokens,
        ),
      );

  void updatePersonality(LaraPersonality personality) {
    emit(state.copyWith(personality: personality));
  }

  void updateTemperature(double temperature) {
    emit(state.copyWith(temperature: temperature));
  }

  void updateMaxTokens(int maxTokens) {
    emit(state.copyWith(maxTokens: maxTokens));
  }

  void saveSettings() {
    _service.updateSettings(
      personality: state.personality,
      temperature: state.temperature,
      maxTokens: state.maxTokens,
    );
  }
}
