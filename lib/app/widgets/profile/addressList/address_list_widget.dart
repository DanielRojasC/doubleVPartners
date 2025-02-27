import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/domain/entities/department_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/widgets/profile/addressList/address_list_item_widget.dart';
import 'package:flutter/material.dart';

class AddressListWidget extends StatefulWidget {
  final List<AddressEntity> addresses;
  final List<DepartmentEntity> departments;
  final Function(AddressEntity) onClickDelete, onClickEdit;

  const AddressListWidget({
    required this.addresses,
    required this.departments,
    required this.onClickDelete,
    required this.onClickEdit,
    super.key,
  });

  @override
  State<AddressListWidget> createState() => _AddressListWidgetState();
}

class _AddressListWidgetState extends State<AddressListWidget> {
  String _getDepartmentName(int departmentId) => widget.departments
      .firstWhere((department) => department.departmentId == departmentId)
      .name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 20),
                child: Text(
                  "Direcciones registradas:",
                  style: formTitleTextStyle(),
                ),
              ),
              widget.addresses.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "No se han encontrado direcciones registradas...",
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.addresses.length,
                      itemBuilder: (context, index) {
                        AddressEntity item = widget.addresses[index];

                        return AddressListItemWidget(
                          address: item,
                          department: _getDepartmentName(
                            item.municipality.departmentId,
                          ),
                          municipality: item.municipality.name,
                          onClickEdit: (address) => widget.onClickEdit(address),
                          onClickDelete: (address) =>
                              widget.onClickDelete(address),
                        );
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
