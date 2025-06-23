import 'package:equatable/equatable.dart';
import '../../../../../core/enums/dashboard_filter.dart';
import '../../../domain/entities/expense.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoading extends DashboardState {
  @override
  List<Object?> get props => [];
}

class DashboardLoaded extends DashboardState {
  final List<Expense> expenses;
  final double totalIncome;
  final double totalExpense;
  final double balance;
  final DashboardFilter filter;

  final bool hasMore;
  final int currentPage;
  final bool isLoadingMore;

  const DashboardLoaded({
    required this.expenses,
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required this.filter,
    required this.hasMore,
    required this.currentPage,
    required this.isLoadingMore,
  });

  DashboardLoaded copyWith({
    List<Expense>? expenses,
    double? totalIncome,
    double? totalExpense,
    double? balance,
    DashboardFilter? filter,
    bool? hasMore,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return DashboardLoaded(
      expenses: expenses ?? this.expenses,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      balance: balance ?? this.balance,
      filter: filter ?? this.filter,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    expenses,
    totalIncome,
    totalExpense,
    balance,
    filter,
    hasMore,
    currentPage,
    isLoadingMore,
  ];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}