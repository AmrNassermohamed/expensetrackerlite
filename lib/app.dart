import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/enums/dashboard_filter.dart';

import 'injection_container.dart';
import 'presentation/bloc/dashboard/dashboard_bloc.dart';
import 'presentation/bloc/dashboard/dashboard_event.dart';
import 'presentation/pages/Dashboard_screen/dashboard_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker Lite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => sl<DashboardBloc>()..add(const LoadDashboardData(filter: DashboardFilter.thisMonth)),
        child: const DashboardScreen(),
      ),

    );
  }
}