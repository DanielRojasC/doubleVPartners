part of 'address_bloc.dart';

@immutable
sealed class AddressState {}

final class AddressInitialState extends AddressState {}

final class AddressLoadingState extends AddressState {}

final class AddressesFetchedSucessfullyState extends AddressState {
  final List<AddressEntity> addresses;

  AddressesFetchedSucessfullyState({required this.addresses});
}

final class AddressSavedSucessfullyState extends AddressState {
  final List<AddressEntity> addresses;

  AddressSavedSucessfullyState({required this.addresses});
}

final class AddressDeletedSucessfullyState extends AddressState {}

final class AddressErrorState extends AddressState {}
