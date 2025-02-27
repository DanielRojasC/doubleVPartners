import 'package:double_v_partners/app/domain/entities/address_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';

class AddressListItemWidget extends StatefulWidget {
  final AddressEntity address;
  final String department, municipality;
  final Function(AddressEntity) onClickDelete, onClickEdit;
  const AddressListItemWidget({
    required this.address,
    required this.department,
    required this.municipality,
    required this.onClickDelete,
    required this.onClickEdit,
    super.key,
  });

  @override
  State<AddressListItemWidget> createState() => _AddressListItemWidgetState();
}

class _AddressListItemWidgetState extends State<AddressListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.address.address,
                    style: titleTextStyle(16),
                  ),
                  Text(
                    "${widget.department} - ${widget.municipality}",
                  ),
                  Text(
                    "Código postal: ${widget.address.zipCode}",
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => widget.onClickEdit(widget.address),
                    icon: Icon(Icons.edit),
                    color: secondaryColor,
                  ),
                  IconButton(
                    onPressed: () => widget.onClickDelete(widget.address),
                    icon: Icon(Icons.delete),
                    color: secondaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
