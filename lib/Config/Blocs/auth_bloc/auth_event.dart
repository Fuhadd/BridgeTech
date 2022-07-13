part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordButtonPressed extends AuthEvent {
  String email;

  ForgotPasswordButtonPressed(this.email);

  @override
  List<Object> get props => [];
}
