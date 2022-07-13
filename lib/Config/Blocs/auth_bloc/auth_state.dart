part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class PasswordResetInProgress extends AuthState {}

class PasswordResetSuccessful extends AuthState {
  @override
  List<Object> get props => [];
}

class PasswordResetFailed extends AuthState {
  String message;

  PasswordResetFailed(this.message);
}
