import 'package:expensetrackerlite/features/expense/domain/entities/expense.dart';
import 'package:expensetrackerlite/features/expense/domain/usecases/add_expense.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/add_expense/add_expense_bloc.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/add_expense/add_expense_event.dart';
import 'package:expensetrackerlite/features/expense/presentation/bloc/add_expense/add_expense_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';


class MockAddExpenseUseCase extends Mock implements AddExpenseUseCase {}

void main() {
  late AddExpenseBloc bloc;
  late MockAddExpenseUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockAddExpenseUseCase();
    bloc = AddExpenseBloc(mockUseCase);
  });

  const validCategory = 'Groceries';
  final validExpense = Expense(
    id: '1',
    title: validCategory,
    amount: 100.0,
    date: DateTime.now(),
    category: validCategory,
    convertedAmountUSD: 0.0,
  );

  blocTest<AddExpenseBloc, AddExpenseState>(
    'emits [AddExpenseError] when amount is <= 0',
    build: () => bloc,
    act: (bloc) {
      bloc.selectedCategory = validCategory;
      bloc.add(SubmitExpenseEvent(
        validExpense.copyWith(amount: 0),
      ));
    },
    expect: () => [
      const AddExpenseError('Amount must be greater than 0'),
    ],
  );

  blocTest<AddExpenseBloc, AddExpenseState>(
    'emits [AddExpenseError] when category is empty',
    build: () => bloc,
    act: (bloc) {
      bloc.selectedCategory = ''; // simulate no category selected
      bloc.add(SubmitExpenseEvent(validExpense));
    },
    expect: () => [
      const AddExpenseError('Please select a category'),
    ],
  );
  test('emits AddExpenseError when amount is negative', () async {
    final expense = Expense(
      id: '2',
      title: 'Rent',
      amount: -50.0,
      date: DateTime.now(),
      category: 'Rent',
      convertedAmountUSD: 0,
    );

    bloc.add(SubmitExpenseEvent(expense));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<AddExpenseError>().having((e) => e.message, 'message', contains('greater than 0')),
      ]),
    );
  });
  test('emits AddExpenseError when receipt is not selected', () async {
    final useCase = MockAddExpenseUseCase();
    final bloc = AddExpenseBloc(useCase);

    // Setup selected category and missing receipt
    bloc.selectedCategory = 'Groceries';
    bloc.receiptPath = null;

    final expense = Expense(
      id: '1',
      title: 'Groceries',
      amount: 100.0,
      date: DateTime.now(),
      category: 'Groceries',
      convertedAmountUSD: 0,
    );

    bloc.add(SubmitExpenseEvent(expense));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        AddExpenseError('Please attach a receipt'),
      ]),
    );
  });
  test('emits AddExpenseError when date is not selected or invalid', () async {
    final useCase = MockAddExpenseUseCase();
    final bloc = AddExpenseBloc(useCase);

    bloc.selectedCategory = 'Transport';
    bloc.receiptPath = 'dummy/path.jpg';

    final invalidDate = DateTime(1990); // before acceptable threshold
    final expense = Expense(
      id: '1',
      title: 'Transport',
      amount: 50.0,
      date: invalidDate,
      category: 'Transport',
      convertedAmountUSD: 0,
      receiptPath: 'dummy/path.jpg',
    );

    bloc.add(SubmitExpenseEvent(expense));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        const AddExpenseError('Please select a valid date'),
      ]),
    );
  });

}