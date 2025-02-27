import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:double_v_partners/app/bloc/address/address_bloc.dart';
import 'package:double_v_partners/app/bloc/municipality/municipality_bloc.dart';
import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';
import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/utils/utils.dart';
import 'package:double_v_partners/app/utils/validators.dart';
import 'package:double_v_partners/app/widgets/forms/basic_input_widget.dart';
import 'package:double_v_partners/app/widgets/forms/department_dropdown_widget.dart';
import 'package:double_v_partners/app/widgets/forms/municipality_dropdown_widget.dart';
import 'package:double_v_partners/app/widgets/primary_button_widget.dart';

class AddressFormPage extends StatefulWidget {
  final UserEntity user;
  final List<DepartmentEntity> departments;
  final AddressEntity? addressEdit;

  const AddressFormPage({
    required this.user,
    required this.departments,
    this.addressEdit,
    super.key,
  });

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _physicalDirectionController = TextEditingController();
  final _zipCodeController = TextEditingController();

  DepartmentEntity? _selectedDepartment;
  MunicipalityEntity? _selectedMunicipality;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    if (widget.addressEdit != null) {
      _loadEditData();
    } else {
      _selectedDepartment = widget.departments.first;
      _fetchMunicipalities(_selectedDepartment!.departmentId);
    }
  }

  void _loadEditData() {
    final addressEdit = widget.addressEdit!;
    _physicalDirectionController.text = addressEdit.address;
    _zipCodeController.text = addressEdit.zipCode;
    _selectedDepartment = widget.departments.firstWhere(
      (dept) => dept.departmentId == addressEdit.municipality.departmentId,
    );
    _selectedMunicipality = addressEdit.municipality;
    _fetchMunicipalities(_selectedDepartment!.departmentId);
  }

  void _fetchMunicipalities(int departmentId) {
    context
        .read<MunicipalityBloc>()
        .add(FetchMunicipalityEvent(departmentId: departmentId));
  }

  void _onSelectDepartment(DepartmentEntity selectedDepartment) {
    setState(() {
      _selectedDepartment = selectedDepartment;
      _selectedMunicipality = null;
    });
    _fetchMunicipalities(selectedDepartment.departmentId);
  }

  void _onClickSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AddressBloc>().add(
            SaveAddressEvent(address: _createAddressEntity()),
          );
      Navigator.of(context).pop();
    }
  }

  AddressEntity _createAddressEntity() => AddressEntity(
        addressId: widget.addressEdit?.addressId ?? Utils.generateId(),
        address: _physicalDirectionController.text,
        municipality: _selectedMunicipality!,
        zipCode: _zipCodeController.text,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: lightBackground,
        leading: BackButton(
          color: primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Card(
              color: Colors.white,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Agregar direcciones", style: formTitleTextStyle()),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          BasicTextInputWidget(
                            controller: _physicalDirectionController,
                            validator: (value) => Validators.required(value),
                            hintText: "Ej: Calle 62N #8C-33",
                            inputTitle: "Dirección física",
                            padding: const EdgeInsets.only(top: 15),
                          ),
                          DepartmentDropdownWidget(
                            onSelectDepartment: _onSelectDepartment,
                            selectedDepartment: _selectedDepartment,
                            inputTitle: "Departamento",
                            padding: const EdgeInsets.only(top: 15),
                            departments: widget.departments,
                          ),
                          BlocConsumer<MunicipalityBloc, MunicipalityState>(
                            listener: (context, state) => {
                              if (state is MunicipalityFetchedState &&
                                  _selectedMunicipality == null &&
                                  state.municipalities.isNotEmpty)
                                {
                                  setState(() {
                                    _selectedMunicipality =
                                        state.municipalities.first;
                                  }),
                                },
                            },
                            builder: (context, state) {
                              if (state is MunicipalityLoadingState) {
                                return const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is MunicipalityFetchedState) {
                                return MunicipalitiesDropdownWidget(
                                  onSelectMunicipalitiy: (municipality) =>
                                      setState(() =>
                                          _selectedMunicipality = municipality),
                                  selectedMunicipality: _selectedMunicipality,
                                  inputTitle: "Municipio",
                                  padding: const EdgeInsets.only(top: 15),
                                  municipalities: state.municipalities,
                                );
                              }

                              return const SizedBox();
                            },
                          ),
                          BasicTextInputWidget(
                            controller: _zipCodeController,
                            validator: (value) => Validators.required(value),
                            inputTitle: "Código postal",
                            hintText: "Ej 190001",
                            padding: const EdgeInsets.only(top: 15),
                            inputType: TextInputType.number,
                          ),
                          PrimaryButtonWidget(
                            onClick: _onClickSave,
                            buttonText: "Finalizar",
                            padding: const EdgeInsets.only(top: 25, bottom: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
