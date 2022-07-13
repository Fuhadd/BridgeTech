import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<ForgotPasswordButtonPressed>(_handlePasswordReset);
  }

  FutureOr<void> _handlePasswordReset(
      ForgotPasswordButtonPressed event, Emitter<AuthState> emit) async {
    try {
      emit(PasswordResetInProgress());
      await userRepository.resetPassword(event.email);
      emit(PasswordResetSuccessful());
    } catch (error) {
      emit(PasswordResetFailed(error.toString()));
    }
  }
}
