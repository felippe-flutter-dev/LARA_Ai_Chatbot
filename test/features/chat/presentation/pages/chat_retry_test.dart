import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:lara_ai/features/chat/presentation/cubit/chat_states.dart';
import 'package:lara_ai/features/chat/presentation/cubit/lara_settings/lara_settings_cubit.dart';
import 'package:lara_ai/features/chat/presentation/pages/chat_view/chat_view_model.dart';

class MockChatCubit extends MockCubit<ChatState> implements ChatCubit {}

class MockLaraSettingsCubit extends MockCubit<LaraSettingsState>
    implements LaraSettingsCubit {}

void main() {
  late MockChatCubit mockCubit;
  late MockLaraSettingsCubit mockSettingsCubit;
  late ChatViewModel vm;

  setUp(() {
    mockCubit = MockChatCubit();
    mockSettingsCubit = MockLaraSettingsCubit();
    // Passamos ambos os mocks para o construtor do ViewModel
    vm = ChatViewModel(mockCubit, mockSettingsCubit);
  });

  group('Chat Retry Widget Tests', () {
    testWidgets(
      'deve verificar se o ViewModel foi instanciado corretamente com os mocks',
      (tester) async {
        expect(vm.cubit, mockCubit);
        expect(vm.settingsCubit, mockSettingsCubit);
      },
    );
  });
}
