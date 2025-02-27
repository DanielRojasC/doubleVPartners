import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:double_v_partners/app/bloc/user/user_bloc.dart';
import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/pages/profile_page.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/utils/utils.dart';
import 'package:double_v_partners/app/utils/validators.dart';
import 'package:double_v_partners/app/widgets/forms/basic_input_widget.dart';
import 'package:double_v_partners/app/widgets/forms/date_picker_input_widget.dart';
import 'package:double_v_partners/app/widgets/primary_button_widget.dart';

class UserFormPage extends StatefulWidget {
  final List<DepartmentEntity> departments;
  final UserEntity? userEdit;

  const UserFormPage({this.userEdit, required this.departments, super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _userFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdateController = TextEditingController();

  UserEntity? _userEdit;

  @override
  void initState() {
    super.initState();
    _userEdit = widget.userEdit;
    if (_userEdit != null) {
      _loadEditData();
    }
  }

  void _loadEditData() {
    _nameController.text = _userEdit!.name;
    _lastNameController.text = _userEdit!.lastName;
    _birthdateController.text = Utils.dateFormat.format(_userEdit!.birthdate);
  }

  void _onClickSave() {
    if (_userFormKey.currentState!.validate()) {
      final userEntity = _createUserEntity();
      final userBloc = BlocProvider.of<UserBloc>(context);

      if (_userEdit != null) {
        userBloc.add(EditUserEvent(user: userEntity));
      } else {
        userBloc.add(SaveUserEvent(user: userEntity));
      }
    }
  }

  void _resetValues() {
    _nameController.clear();
    _lastNameController.clear();
    _birthdateController.clear();
    _userEdit = null;
  }

  UserEntity _createUserEntity() => UserEntity(
        name: _nameController.text,
        lastName: _lastNameController.text,
        birthdate: Utils.dateFormat.parse(_birthdateController.text),
      );

  void _validateListenerStates(UserState state) {
    if (state is UserSavedState) {
      Future.value(Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ProfilePage(
            user: _createUserEntity(),
            departments: widget.departments,
          ),
        ),
      ));
      Utils.showToast(
        context,
        "Usuario registrado correctamente",
      );
      BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
    } else if (state is UserUpdatedState) {
      _resetValues();
      Navigator.of(context).pop(state.user);
      Utils.showToast(
        context,
        "Usuario actualizado correctamente",
      );
      BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
    } else if (state is UserErrorState) {
      Utils.showToast(
        context,
        "Se ha presentado un error, inténtelo de nuevo más tarde",
      );
      BlocProvider.of<UserBloc>(context).add(UserInitialEvent());
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: SizedBox(
          width: deviceWidth(context),
          height: deviceHeight(context),
          child: Center(
            child: BlocListener<UserBloc, UserState>(
              listener: (context, state) => _validateListenerStates(state),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoadingState) {
                    return CircularProgressIndicator();
                  }

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Crear Usuario",
                                style: formTitleTextStyle(),
                              ),
                              Form(
                                key: _userFormKey,
                                child: Column(
                                  children: [
                                    BasicTextInputWidget(
                                      controller: _nameController,
                                      validator: (value) =>
                                          Validators.required(value),
                                      inputTitle: "Nombre",
                                      padding: const EdgeInsets.only(top: 15.0),
                                      hintText: "",
                                      inputType: TextInputType.name,
                                    ),
                                    BasicTextInputWidget(
                                      controller: _lastNameController,
                                      validator: (value) =>
                                          Validators.required(value),
                                      inputTitle: "Apellido",
                                      padding: const EdgeInsets.only(top: 15.0),
                                      hintText: "",
                                      inputType: TextInputType.name,
                                    ),
                                    DatePickerInputWidget(
                                      controller: _birthdateController,
                                      validator: (value) =>
                                          Validators.required(value),
                                      inputTitle: "Fecha de nacimiento",
                                      hintText: "Ej: 25/02/2000",
                                      padding: const EdgeInsets.only(top: 15.0),
                                      initialDate: _userEdit?.birthdate,
                                    ),
                                    PrimaryButtonWidget(
                                      onClick: _onClickSave,
                                      buttonText: "Continuar",
                                      padding:
                                          EdgeInsets.only(top: 25, bottom: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
