import 'package:equatable/equatable.dart';
import 'package:gym_log/feature/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess  extends AuthState {
  final UserEntity user;
  AuthSuccess (this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure  extends AuthState {
  final String error;
  AuthFailure (this.error);

  @override
  List<Object?> get props => [error];
}
