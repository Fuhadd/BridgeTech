part of 'userinfo_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

class UserInfoInitial extends UserInfoState {}

class UserInfoInProgress extends UserInfoState {}

class UserInfoSuccessful extends UserInfoState {
  const UserInfoSuccessful();
}

class UserInfoFailed extends UserInfoState {
  String message;

  UserInfoFailed(this.message);

  @override
  List<Object> get props => [message];
}
