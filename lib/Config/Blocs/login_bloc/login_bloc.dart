import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';

import '../../../Models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  LoginBloc(this.userRepository, this.firestoreRepository)
      : super(LoginInitial()) {
    on<LoginButtonPressed>(_handleLoginProcess);
  }

  FutureOr<void> _handleLoginProcess(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());
      User? user =
          await userRepository.LoginWithEmail(event.email, event.password);
      print(user);
      await firestoreRepository
          .saveUsersCredentialslocal()
          .then((value) => emit(LoginSuccessful(user)));
      // emit(LoginSuccessful(user));
    } catch (error) {
      emit(LoginFailed(error.toString()));
    }
  }
}
// jnrolamilekan123@gmail.com
