part of 'userinfo_bloc.dart';

abstract class UserInfoEvent extends Equatable {
  const UserInfoEvent();

  @override
  List<Object> get props => [];
}

class UserInfoButtonPressed extends UserInfoEvent {
  String bio;
  String technical;
  String looking;
  List<String> skills;

  UserInfoButtonPressed({
    required this.skills,
    required this.bio,
    required this.technical,
    required this.looking,
  });

  @override
  List<Object> get props => [];
}
