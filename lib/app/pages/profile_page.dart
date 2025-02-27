import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:double_v_partners/app/bloc/address/address_bloc.dart';
import 'package:double_v_partners/app/bloc/user/user_bloc.dart';
import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/pages/address_form_page.dart';
import 'package:double_v_partners/app/pages/user_form_page.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/utils/utils.dart';
import 'package:double_v_partners/app/widgets/confirm_alert_dialog_widget.dart';
import 'package:double_v_partners/app/widgets/profile/addressList/address_list_widget.dart';
import 'package:double_v_partners/app/widgets/profile/personal_data_widget.dart';

class ProfilePage extends StatefulWidget {
  final UserEntity user;
  final List<DepartmentEntity> departments;

  const ProfilePage({
    required this.user,
    required this.departments,
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late StreamSubscription<UserState> _userSubscription;
  late UserEntity _user;
  List<AddressEntity> _addresses = [];

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _subscribeToUserDeletion();
    _fetchAddresses();
  }

  void _subscribeToUserDeletion() {
    _userSubscription = context.read<UserBloc>().stream.listen((state) {
      if (state is UserDeletedState) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Utils.showToast(context, "Usuario eliminado correctamente");
          Future.value(Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => UserFormPage(departments: widget.departments),
            ),
          ));
        });
      }
    });
  }

  Future<void> _onClickEditUser() async {
    final updatedUser = await Navigator.of(context).push<UserEntity>(
      MaterialPageRoute(
        builder: (_) => UserFormPage(
          departments: widget.departments,
          userEdit: _user,
        ),
      ),
    );
    if (updatedUser != null) {
      setState(() => _user = updatedUser);
    }
  }

  Future<void> _onClickDeleteUser() async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) => const ConfirmAlertDialogWidget(
        title: "Eliminar cuenta de usuario",
        content: "Desea eliminar toda la información del usuario?",
      ),
    );
    if (confirm == true) {
      context.read<UserBloc>().add(DeleteUserEvent());
    }
  }

  void _fetchAddresses() =>
      context.read<AddressBloc>().add(FetchAddressesEvent());

  void _onClickAddAddress() {
    Future.value(Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddressFormPage(
          user: widget.user,
          departments: widget.departments,
        ),
      ),
    ));
    _fetchAddresses();
  }

  void _onClickEditAddress(AddressEntity address) {
    Future.value(Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AddressFormPage(
          user: widget.user,
          departments: widget.departments,
          addressEdit: address,
        ),
      ),
    ));
    _fetchAddresses();
  }

  Future<void> _onClickDeleteAddress(AddressEntity address) async {
    final bool? confirm = await showDialog(
      context: context,
      builder: (context) => const ConfirmAlertDialogWidget(
        title: "Eliminar dirección",
        content: "Desea eliminar esta dirección?",
      ),
    );
    if (confirm == true) {
      context.read<AddressBloc>().add(DeleteAddressEvent(address: address));
    }
  }

  void _validateListenerStates(AddressState state) {
    if (state is AddressSavedSucessfullyState ||
        state is AddressDeletedSucessfullyState) {
      _fetchAddresses();
      Utils.showToast(
        context,
        state is AddressSavedSucessfullyState
            ? "Dirección registrada o actualizada correctamente"
            : "Dirección eliminada correctamente",
      );
    }
    if (state is AddressErrorState) {
      Utils.showToast(
        context,
        "Se ha presentado un error, inténtelo de nuevo más tarde",
      );
    }
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Perfil de usuario", style: titleTextStyle(20)),
              PersonalDataWidget(
                user: _user,
                onClickEdit: _onClickEditUser,
                onClickDelete: _onClickDeleteUser,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Divider(),
              ),
              BlocConsumer<AddressBloc, AddressState>(
                listener: (context, state) => _validateListenerStates(state),
                builder: (context, state) {
                  if (state is AddressLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is AddressesFetchedSucessfullyState) {
                    _addresses = state.addresses;
                  }

                  return AddressListWidget(
                    addresses: _addresses,
                    departments: widget.departments,
                    onClickDelete: _onClickDeleteAddress,
                    onClickEdit: _onClickEditAddress,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClickAddAddress,
        backgroundColor: primaryColor,
        child: const Icon(Icons.add_home_rounded, color: Colors.white),
      ),
    );
  }
}
