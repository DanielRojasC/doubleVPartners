import 'package:double_v_partners/app/domain/entities/municipality_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';

class MunicipalitiesDropdownWidget extends StatelessWidget {
  final List<MunicipalityEntity> municipalities;
  final Function(MunicipalityEntity) onSelectMunicipalitiy;
  final String inputTitle;
  final EdgeInsets padding;
  final MunicipalityEntity? selectedMunicipality;

  const MunicipalitiesDropdownWidget({
    required this.municipalities,
    required this.onSelectMunicipalitiy,
    required this.inputTitle,
    this.padding = EdgeInsets.zero,
    this.selectedMunicipality,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0, bottom: 5),
            child: Text(
              inputTitle,
              style: inputLabelTextStyle(),
            ),
          ),
          DropdownButtonFormField<MunicipalityEntity>(
            decoration: InputStyles.basicInputDecoration(
              "Select an option",
            ),
            value: selectedMunicipality ?? municipalities.first,
            items: [
              ...municipalities
                  .map(
                    (department) => DropdownMenuItem(
                      value: department,
                      child: Text(department.name),
                    ),
                  )
                  .toList(),
            ],
            onChanged: (selectedDepartment) =>
                onSelectMunicipalitiy(selectedDepartment!),
            validator: (value) =>
                value == null ? "Please select an option" : null,
          ),
        ],
      ),
    );
  }
}
