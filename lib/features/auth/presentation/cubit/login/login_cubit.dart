import 'package:bloc/bloc.dart';
import 'package:lara_ai/core/data/services/auth_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  LoginCubit(this._authService) : super(LoginInitial());

  Future<void> loginWithGoogle() async {
    try {
      emit(LoginLoading());
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      emit(LoginLoading());
      final user = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginError("Erro ao fazer login."));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      emit(LoginLoading());
      final user = await _authService.createUserWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        emit(RegisterSuccess());
      } else {
        emit(LoginError("Erro ao cadastrar."));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(LoginLoading());
      await _authService.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<bool> checkBiometricsEnabled() async {
    return await _authService.isBiometricsEnabled();
  }

  Future<void> enableBiometrics(bool enabled) async {
    await _authService.setBiometricsEnabled(enabled);
  }
}
