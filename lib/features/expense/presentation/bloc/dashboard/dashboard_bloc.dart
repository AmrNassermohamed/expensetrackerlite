
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/pagination_params.dart';
import '../../../domain/entities/expense.dart';
import '../../../domain/usecases/get_expenses.dart';
import '../../../domain/usecases/get_filtered_expense_usescases.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetExpensesUseCase getExpenses;
  final GetFilteredExpensesUseCase filterExpenses;

  DashboardBloc(this.getExpenses, this.filterExpenses)
      : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboard);
    on<LoadMoreExpenses>(_onLoadMore);
  }

  Future<void> _onLoadDashboard(
      LoadDashboardData event,
      Emitter<DashboardState> emit,
      ) async {
    emit(DashboardLoading());

    const page = 1;
    const limit = 10;

    try {
      final expenses = await getExpenses(params: const PaginationParams(page: page, limit: limit));
      final filtered = filterExpenses(expenses, event.filter);

      emit(DashboardLoaded(
        expenses: filtered,
        totalIncome: _calcIncome(filtered),
        totalExpense: _calcExpense(filtered),
        balance: _calcIncome(filtered) - _calcExpense(filtered),
        filter: event.filter,
        currentPage: page,
        hasMore: filtered.length == limit,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }


  Future<void> _onLoadMore(
      LoadMoreExpenses event,
      Emitter<DashboardState> emit,
      ) async {
    final currentState = state;

    if (currentState is DashboardLoaded &&
        !currentState.isLoadingMore &&
        currentState.hasMore) {
      emit(currentState.copyWith(isLoadingMore: true));

      final nextPage = currentState.currentPage + 1;

      try {
        final newItems =
        await getExpenses(params: PaginationParams(page: nextPage, limit: 10));
        final all = [...currentState.expenses, ...newItems];

        emit(currentState.copyWith(
          expenses: all,
          currentPage: nextPage,
          hasMore: newItems.length == 10,
          isLoadingMore: false,
          totalIncome: _calcIncome(all),
          totalExpense: _calcExpense(all),
          balance: _calcIncome(all) - _calcExpense(all),
        ));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    }
  }


  double _calcIncome(List<Expense> items) =>
      items.where((e) => e.amount > 0).fold(0.0, (sum, e) => sum + e.amount);

  double _calcExpense(List<Expense> items) =>
      items.where((e) => e.amount < 0).fold(0.0, (sum, e) => sum + e.amount.abs());
}