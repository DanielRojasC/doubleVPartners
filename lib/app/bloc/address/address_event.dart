part of 'address_bloc.dart';

@immutable
sealed class AddressEvent {}

final class AddressInitialEvent extends AddressEvent {}

final class SaveAddressEvent extends AddressEvent {
  final AddressEntity address;

  SaveAddressEvent({required this.address});
}

final class DeleteAddressEvent extends AddressEvent {
  final AddressEntity address;
  DeleteAddressEvent({required this.address});
}

final class FetchAddressesEvent extends AddressEvent {}
