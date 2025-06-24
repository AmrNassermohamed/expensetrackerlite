import 'package:expensetrackerlite/core/utils/pagination_params.dart';
import 'package:expensetrackerlite/domain/entities/expense.dart';
import 'package:expensetrackerlite/domain/repositories/expense_repository.dart';

import '../datasources/expense_local_data_source.dart';
import '../datasources/expense_remote_data_source.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseLocalDataSource local;
  final ExpenseRemoteDataSource remote;

  ExpenseRepositoryImpl(this.local, this.remote);

  @override
  Future<void> addExpense(Expense expense) async {
    final usd = await remote.convertToUSD(expense.amount, 'EGP');

    final updated = Expense(
      id: expense.id,
      title: expense.title,
      amount: expense.amount,
      date: expense.date,
      category: expense.category,
      convertedAmountUSD: usd,
    );

    final model = ExpenseModel.fromEntity(updated);
    await local.addExpense(model);
  }

  @override
  Future<List<Expense>> getExpensesWithPagination(PaginationParams params) async {
    final allModels = await local.getExpenses(); // full list
    final start = (params.page - 1) * params.limit;


    final paginated = allModels.skip(start).take(params.limit).toList();
    return paginated;
  }
}