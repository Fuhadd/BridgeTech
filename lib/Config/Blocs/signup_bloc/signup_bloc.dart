import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_hive_test/Config/Repositories/firebase_storage_repository.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  FirebaseStorageRepository firebaseStorageRepository;
  SignupBloc(this.userRepository, this.firestoreRepository,
      this.firebaseStorageRepository)
      : super(SignupInitial()) {
    on<SignupButtonPressed>(_handleUserSignup);
  }

  FutureOr<void> _handleUserSignup(
      SignupButtonPressed event, Emitter<SignupState> emit) async {
    try {
      emit(SignupInProgress());
      User? user =
          await userRepository.createUserWithEmail(event.email, event.password);

      if (user != null) {
        await firestoreRepository.saveUserCredentials(event.email,
            event.firstName, event.lastName, event.phoneNumber, DateTime.now());
        // emit(SignupSuccessful(user));
        await firebaseStorageRepository.uploadImage(event.image);
        await firestoreRepository.saveUsersCredentialslocal();
        // emit(LoginSuccessful(user));
      }
      print(1);

      emit(SignupSuccessful(user));
    } catch (error) {
      emit(SignupFailed(error.toString()));
    }
  }
}
