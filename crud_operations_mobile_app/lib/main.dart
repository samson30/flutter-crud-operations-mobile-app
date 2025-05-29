import 'package:crud_operations_mobile_app/blocs/employee_list/employee_list_bloc.dart';
import 'package:crud_operations_mobile_app/l10n/app_localizations.dart';
import 'package:crud_operations_mobile_app/pages/employee_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // Add more locales if needed
      ],
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => EmployeeListBloc(),
        child: EmployeeListPage(),
      ),
    );
  }
}
