import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_hive_test/Config/Blocs/login_bloc/login_bloc.dart';
import 'package:urban_hive_test/Config/Repositories/firebase_storage_repository.dart';
import 'package:urban_hive_test/Config/Repositories/firestore_repository.dart';
import 'package:urban_hive_test/Config/Repositories/user_repository.dart';

part 'userinfo_event.dart';
part 'userinfo_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  FirebaseStorageRepository firebaseStorageRepository;
  UserInfoBloc(this.userRepository, this.firestoreRepository,
      this.firebaseStorageRepository)
      : super(UserInfoInitial()) {
    on<UserInfoButtonPressed>(_handleUserUserInfo);
  }

  FutureOr<void> _handleUserUserInfo(
      UserInfoButtonPressed event, Emitter<UserInfoState> emit) async {
    try {
      emit(UserInfoInProgress());

      await firestoreRepository.saveMoreUsersInfo(
          event.skills, event.bio, event.technical, event.looking);

      await firestoreRepository.saveUsersCredentialslocal();
      emit(UserInfoSuccessful());
    } catch (error) {
      emit(UserInfoFailed(error.toString()));
    }
  }
}
