part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  String email;
  String password;
  LoginButtonPressed({required this.email, required this.password});

  @override
  List<Object> get props => [];
}
