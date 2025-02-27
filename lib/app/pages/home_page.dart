import 'package:double_v_partners/app/bloc/department/department_bloc.dart';
import 'package:double_v_partners/app/bloc/user/user_bloc.dart';

import 'package:double_v_partners/app/pages/profile_page.dart';
import 'package:double_v_partners/app/pages/user_form_page.dart';
import 'package:double_v_partners/app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(FetchUserEvent());
    });
  }

  _validateDepartmentListenerStates(
    DepartmentState departmentState,
    UserState userState,
  ) {
    if (departmentState is DepartmentsFetchedState) {
      final user = (userState is UserFetchedState) ? userState.user : null;
      final departments = departmentState.departments;

      WidgetsBinding.instance
          .addPostFrameCallback((_) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => user != null
                      ? ProfilePage(user: user, departments: departments)
                      : UserFormPage(departments: departments),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, userState) => {
            if (userState is UserFetchedState)
              {
                context.read<DepartmentBloc>().add(FetchDepartmentsEvent()),
              },
          },
          builder: (context, userState) {
            if (userState is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            return BlocConsumer<DepartmentBloc, DepartmentState>(
              listener: (context, departmentState) =>
                  _validateDepartmentListenerStates(departmentState, userState),
              builder: (context, departmentState) {
                if (departmentState is DepartmentLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                return const SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}
