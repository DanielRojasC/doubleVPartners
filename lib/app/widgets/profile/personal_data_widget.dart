import 'package:double_v_partners/app/domain/entities/user_entity.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:double_v_partners/app/utils/utils.dart';
import 'package:flutter/material.dart';

class PersonalDataWidget extends StatelessWidget {
  final UserEntity? user;
  final VoidCallback onClickDelete, onClickEdit;
  const PersonalDataWidget({
    required this.user,
    required this.onClickEdit,
    required this.onClickDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth(context),
      margin: EdgeInsets.only(top: 20),
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Datos personales",
                    style: formTitleTextStyle(),
                  ),
                  Text(
                    "${user!.name} ${user!.lastName}",
                    style: titleTextStyle(18),
                  ),
                  Text(
                    "Fecha de nacimiento: ${Utils.formatDate(
                      user!.birthdate,
                    )}",
                    style: titleTextStyle(15),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onClickEdit,
                    icon: Icon(Icons.edit),
                    color: secondaryColor,
                  ),
                  IconButton(
                    onPressed: onClickDelete,
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
