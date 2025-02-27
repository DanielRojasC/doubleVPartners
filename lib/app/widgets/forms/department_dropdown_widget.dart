import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';

class DepartmentDropdownWidget extends StatelessWidget {
  final List<DepartmentEntity> departments;
  final Function(DepartmentEntity) onSelectDepartment;
  final String inputTitle;
  final EdgeInsets padding;
  final DepartmentEntity? selectedDepartment;

  const DepartmentDropdownWidget({
    required this.departments,
    required this.onSelectDepartment,
    required this.inputTitle,
    this.padding = EdgeInsets.zero,
    this.selectedDepartment,
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
          DropdownButtonFormField<DepartmentEntity>(
            decoration: InputStyles.basicInputDecoration(
              "Select an option",
            ),
            value: selectedDepartment ?? departments.first,
            items: [
              ...departments
                  .map(
                    (department) => DropdownMenuItem(
                      value: department,
                      child: Text(department.name),
                    ),
                  )
                  .toList(),
            ],
            onChanged: (selectedDepartment) =>
                onSelectDepartment(selectedDepartment!),
            validator: (value) =>
                value == null ? "Please select an option" : null,
          ),
        ],
      ),
    );
  }
}
