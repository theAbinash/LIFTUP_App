import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liftup/core/utils/logger.dart';
import 'package:liftup/feature/auth/domain/entities/user_entity.dart';
import 'package:liftup/feature/auth/domain/repositories/auth_repository.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthUserRegister>(_onUserRegister);
  }

  Future<void> _onUserRegister(AuthUserRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try{
      final user = UserEntity(
        personUserName: event.username, 
        personEmail: event.email, 
        personUserPassword: event.password
        );

      final userId = await authRepository.register(user);

      final registeredUser = UserEntity(
        id: userId,
        personUserName: event.username, 
        personEmail: event.email, 
        personUserPassword: event.password
        );
      emit(AuthSuccess(registeredUser));
    }catch (e) {
      emit(AuthFailure("Registration failed: ${e.toString()}"));
      AppLogger.error("Error: ${e.toString()}");
    }
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.email, event.password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure("Login failed: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    final user = await authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
