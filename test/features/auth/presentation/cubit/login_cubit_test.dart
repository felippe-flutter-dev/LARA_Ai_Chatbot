import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:lara_ai/features/auth/presentation/cubit/login/login_states.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

class MockUser extends Mock implements User {}

void main() {
  late LoginCubit loginCubit;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    loginCubit = LoginCubit(mockAuthService);
  });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit', () {
    final tUser = MockUser();

    blocTest<LoginCubit, LoginState>(
      'deve emitir [LoginLoading, LoginSuccess] quando o login com Google for bem-sucedido',
      build: () {
        when(
          () => mockAuthService.signInWithGoogle(),
        ).thenAnswer((_) async => tUser);
        return loginCubit;
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );

    blocTest<LoginCubit, LoginState>(
      'deve emitir [LoginLoading, LoginError] quando o login com Google falhar',
      build: () {
        when(
          () => mockAuthService.signInWithGoogle(),
        ).thenThrow(Exception('Erro no Google'));
        return loginCubit;
      },
      act: (cubit) => cubit.loginWithGoogle(),
      expect: () => [isA<LoginLoading>(), isA<LoginError>()],
    );

    blocTest<LoginCubit, LoginState>(
      'deve emitir [LoginLoading, LoginSuccess] quando o login com e-mail for bem-sucedido',
      build: () {
        when(
          () => mockAuthService.signInWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async => tUser);
        return loginCubit;
      },
      act: (cubit) => cubit.loginWithEmail('test@test.com', '123456'),
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );

    blocTest<LoginCubit, LoginState>(
      'deve emitir [LoginLoading, RegisterSuccess] quando o cadastro for bem-sucedido',
      build: () {
        when(
          () => mockAuthService.createUserWithEmailAndPassword(any(), any()),
        ).thenAnswer((_) async => tUser);
        return loginCubit;
      },
      act: (cubit) => cubit.registerWithEmail('new@test.com', '123456'),
      expect: () => [isA<LoginLoading>(), isA<RegisterSuccess>()],
    );
  });
}
