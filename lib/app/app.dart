import 'package:double_v_partners/app/bloc/address/address_bloc.dart';
import 'package:double_v_partners/app/bloc/department/department_bloc.dart';
import 'package:double_v_partners/app/bloc/municipality/municipality_bloc.dart';
import 'package:double_v_partners/app/bloc/user/user_bloc.dart';
import 'package:double_v_partners/app/data/repository/address_repository_impl.dart';
import 'package:double_v_partners/app/data/repository/department_repository_impl.dart';
import 'package:double_v_partners/app/data/repository/municipality_repository_impl.dart';
import 'package:double_v_partners/app/data/repository/user_repository_impl.dart';
import 'package:double_v_partners/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final departmentRepository = DepartmentRepositoryImpl();
  final municipalityRepository = MunicipalityRepositoryImpl();
  final addressRepository = AddressRepositoryImpl();
  final userRepository = UserRepositoryImpl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => DepartmentBloc(
            departmentRepository: departmentRepository,
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => MunicipalityBloc(
            municipalityRepository: municipalityRepository,
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => AddressBloc(
            addressRepository: addressRepository,
          ),
        ),
        BlocProvider(
          create: (BuildContext context) => UserBloc(
            userRepository: userRepository,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
