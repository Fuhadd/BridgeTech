part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccessful extends LoginState {
  User? user;

  LoginSuccessful(this.user);
}

class LoginFailed extends LoginState {
  String message;

  LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}
