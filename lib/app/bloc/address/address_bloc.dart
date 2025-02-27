import 'package:bloc/bloc.dart';
import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/repository/address_repository.dart';
import 'package:double_v_partners/app/domain/usecase/address/delete_address_usecase.dart';
import 'package:double_v_partners/app/domain/usecase/address/fetch_addresses_usecase.dart';
import 'package:double_v_partners/app/domain/usecase/address/save_address_usecase.dart';
import 'package:meta/meta.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addressRepository;
  AddressBloc({required this.addressRepository})
      : super(AddressInitialState()) {
    on<FetchAddressesEvent>(
      (_, emit) async => await _fetchAddresses(emit),
    );
    on<SaveAddressEvent>(
      (event, emit) async => await _saveAddress(event, emit),
    );
    on<DeleteAddressEvent>(
      (event, emit) async => await _deleteAddress(event, emit),
    );
    on<AddressInitialEvent>((_, emit) => emit(AddressInitialState()));
  }

  Future<void> _saveAddress(
    SaveAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());

    try {
      final usecase = SaveAddressUsecase(addressRepository: addressRepository);

      final response = await usecase.call(event.address);

      emit(AddressSavedSucessfullyState(addresses: response));
    } catch (e) {
      emit(AddressErrorState());
    }
  }

  Future<void> _fetchAddresses(Emitter<AddressState> emit) async {
    emit(AddressLoadingState());

    try {
      final usecase =
          FetchAddressesUsecase(addressRepository: addressRepository);

      final response = await usecase.call(null);

      emit(AddressesFetchedSucessfullyState(addresses: response));
    } catch (e) {
      emit(AddressErrorState());
    }
  }

  Future<void> _deleteAddress(
    DeleteAddressEvent event,
    Emitter<AddressState> emit,
  ) async {
    emit(AddressLoadingState());

    try {
      final usecase =
          DeleteAddressUsecase(addressRepository: addressRepository);

      final response = await usecase.call(event.address);

      if (response) {
        emit(AddressDeletedSucessfullyState());
      }
    } catch (e) {
      emit(AddressErrorState());
    }
  }
}
