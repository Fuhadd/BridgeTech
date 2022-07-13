part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {}

class SignupInProgress extends SignupState {}

class SignupSuccessful extends SignupState {
  User? user;

  SignupSuccessful(this.user);
}

class SignupFailed extends SignupState {
  String message;

  SignupFailed(this.message);

  @override
  List<Object> get props => [message];
}
