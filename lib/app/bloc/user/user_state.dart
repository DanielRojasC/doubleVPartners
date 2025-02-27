part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserFetchedState extends UserState {
  final dynamic user;
  UserFetchedState({required this.user});
}

final class UserUpdatedState extends UserState {
  final UserEntity user;

  UserUpdatedState({required this.user});
}

final class UserSavedState extends UserState {}

final class UserDeletedState extends UserState {}

final class UserErrorState extends UserState {}
