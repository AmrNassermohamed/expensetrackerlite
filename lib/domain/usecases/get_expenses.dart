import '../../../../core/utils/pagination_params.dart';
import '../entities/expense.dart';
import '../repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository repository;

  GetExpensesUseCase(this.repository);

  Future<List<Expense>> call({required PaginationParams params}) {
    return repository.getExpensesWithPagination(params);
  }
}