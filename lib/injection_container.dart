import 'package:expensetrackerlite/data/datasources/expense_local_data_source.dart';
import 'package:expensetrackerlite/data/datasources/expense_remote_data_source.dart';
import 'package:expensetrackerlite/data/repositories/expense_repository_impl.dart';
import 'package:expensetrackerlite/domain/repositories/expense_repository.dart';
import 'package:expensetrackerlite/domain/usecases/add_expense.dart';
import 'package:expensetrackerlite/domain/usecases/get_expenses.dart';
import 'package:expensetrackerlite/domain/usecases/get_filtered_expense_usescases.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'presentation/bloc/add_expense/add_expense_bloc.dart';
import 'presentation/bloc/dashboard/dashboard_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // ✅ External

  sl.registerLazySingleton<Dio>(() => Dio());

  // ✅ Data Sources
  sl.registerLazySingleton(() => ExpenseLocalDataSource());
  sl.registerLazySingleton(() => ExpenseRemoteDataSource(sl()));

  // ✅ Repository
  sl.registerLazySingleton<ExpenseRepository>(() =>
      ExpenseRepositoryImpl(sl(), sl()));

  // ✅ Use Cases
  sl.registerLazySingleton(() => AddExpenseUseCase(sl()));
  sl.registerLazySingleton(() => GetExpensesUseCase(sl()));
  sl.registerLazySingleton(() => GetFilteredExpensesUseCase());

  // ✅ Bloc
  sl.registerFactory(() => AddExpenseBloc(sl()));

  sl.registerFactory(() => DashboardBloc(
    sl<GetExpensesUseCase>(),
    sl<GetFilteredExpensesUseCase>(),
  ));

}