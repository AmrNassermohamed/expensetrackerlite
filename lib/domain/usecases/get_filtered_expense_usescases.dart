import '../../../../core/enums/dashboard_filter.dart';
import '../entities/expense.dart';


class GetFilteredExpensesUseCase {
  List<Expense> call(List<Expense> expenses, DashboardFilter filter) {
    final now = DateTime.now();
    return expenses.where((e) {
      if (filter == DashboardFilter.thisMonth) {
        return e.date.month == now.month && e.date.year == now.year;
      } else if (filter == DashboardFilter.last7Days) {
        return e.date.isAfter(now.subtract(const Duration(days: 7)));
      }
      return true;
    }).toList();
  }
}