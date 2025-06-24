import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'app.dart';

import '/injection_container.dart' as di;
import 'data/models/expense_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
 await Hive.openBox<ExpenseModel>('expenses_box');
  WidgetsFlutterBinding.ensureInitialized();

  await di.init(); // from injection_container

  runApp(const MyApp());
}


