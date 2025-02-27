part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class FetchUserEvent extends UserEvent {}

final class UserInitialEvent extends UserEvent {}

final class DeleteUserEvent extends UserEvent {}

final class EditUserEvent extends UserEvent {
  final UserEntity user;
  EditUserEvent({required this.user});
}

final class SaveUserEvent extends UserEvent {
  final UserEntity user;
  SaveUserEvent({required this.user});
}
