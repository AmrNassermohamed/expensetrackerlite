import 'package:bloc_test/bloc_test.dart';
import 'package:expensetrackerlite/core/enums/dashboard_filter.dart';
import 'package:expensetrackerlite/core/utils/pagination_params.dart';
import 'package:expensetrackerlite/features/expense/domain/entities/expense.dart';
import 'package:expensetrackerlite/features/expense/domain/usecases/get_expenses.dart';
import 'package:expensetrackerlite/features/expense/domain/usecases/get_filtered_expense_usescases.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/dashboard/dashboard_event.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



class MockGetExpensesUseCase extends Mock implements GetExpensesUseCase {}

class MockGetFilteredExpensesUseCase extends Mock implements GetFilteredExpensesUseCase {}

class FakePaginationParams extends Fake implements PaginationParams {}



void main() {
  late DashboardBloc dashboardBloc;
  late MockGetExpensesUseCase mockGetExpenses;
  late MockGetFilteredExpensesUseCase mockFilterExpenses;

  setUpAll(() {
    registerFallbackValue(FakePaginationParams());
    registerFallbackValue(DashboardFilter.all); // Fallback for DashboardFilter
  });

  setUp(() {
    mockGetExpenses = MockGetExpensesUseCase();
    mockFilterExpenses = MockGetFilteredExpensesUseCase();
    dashboardBloc = DashboardBloc(mockGetExpenses, mockFilterExpenses);
  });

  final expenseList = List.generate(
    10,
        (index) => Expense(
      id: '$index',
      title: 'Test',
      amount: 100,
      date: DateTime.now(),
      category: 'Test',
      convertedAmountUSD: 0,
    ),
  );

  group('DashboardBloc pagination', ()
  {
    blocTest<DashboardBloc, DashboardState>(
      'emits DashboardLoaded with paginated data when LoadMoreExpenses is added',
      build: () {
        when(() => mockGetExpenses(params: any(named: 'params')))
            .thenAnswer((_) async => expenseList);
        when(() => mockFilterExpenses(any(), any())).thenReturn(expenseList);
        return DashboardBloc(mockGetExpenses, mockFilterExpenses);
      },
      act: (bloc) async {
        bloc.add(const LoadDashboardData(filter: DashboardFilter.all));
        await Future.delayed(
            Duration.zero); // allow LoadDashboardData to resolve
        bloc.add(const LoadMoreExpenses());
      },
      expect: () =>
      [
        DashboardLoading(),
        isA<DashboardLoaded>()
            .having((s) => s.expenses.length, 'loaded items', 10)
            .having((s) => s.currentPage, 'page', 1)
            .having((s) => s.isLoadingMore, 'isLoadingMore', false),
        isA<DashboardLoaded>()
            .having((s) => s.expenses.length, 'still 10 before fetching more',
            10)
            .having((s) => s.currentPage, 'page', 1)
            .having((s) => s.isLoadingMore, 'loading more in progress', true),
        isA<DashboardLoaded>()
            .having((s) => s.expenses.length, 'total after pagination', 20)
            .having((s) => s.currentPage, 'page after pagination', 2)
            .having((s) => s.isLoadingMore, 'done loading', false),
      ],
    );
  });
}

