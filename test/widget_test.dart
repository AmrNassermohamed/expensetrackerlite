import 'package:expensetrackerlite/core/enums/dashboard_filter.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/dashboard/dashboard_state.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/Dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class FakeDashboardState extends Fake implements DashboardState {}
class MockDashboardBloc extends Mock implements DashboardBloc {
  @override
  Stream<DashboardState> get stream => Stream.value(state);
}

void main() {
  late MockDashboardBloc dashboardBloc;

  setUpAll(() {
    registerFallbackValue(FakeDashboardState());
  });

  setUp(() {
    dashboardBloc = MockDashboardBloc();
  });

  testWidgets('DashboardScreen renders Recent Expenses and FAB', (WidgetTester tester) async {
    // Arrange: Stub the BLoC state
    when(() => dashboardBloc.state).thenReturn(
      const DashboardLoaded(
        expenses: [],
        totalIncome: 0,
        totalExpense: 0,
        balance: 0,
        filter: DashboardFilter.thisMonth,
        currentPage: 1,
        hasMore: false,
        isLoadingMore: false,
      ),
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<DashboardBloc>.value(
          value: dashboardBloc,
          child: const DashboardScreen(),
        ),
      ),
    );

    // Assert
    expect(find.text('Recent Expenses'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
}
