import '../../../../core/utils/pagination_params.dart';
import '../entities/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpensesWithPagination(PaginationParams params);
  Future<void> addExpense(Expense expense);
}