import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_expense_event.dart';
import 'add_expense_state.dart';
import '../../../domain/usecases/add_expense.dart';
class AddExpenseBloc extends Bloc<AddExpenseEvent, AddExpenseState> {
  final AddExpenseUseCase addExpenseUseCase;

  String selectedCategory = '';
  String? receiptPath;
  DateTime selectedDate = DateTime.now();

  AddExpenseBloc(this.addExpenseUseCase)
      : super(AddExpenseInitial(selectedCategory: '', selectedDate: DateTime.now())) {

    on<SelectCategoryEvent>((event, emit) {
      selectedCategory = event.category;
      emit(AddExpenseInitial(
        selectedCategory: selectedCategory,
        receiptPath: receiptPath,
        selectedDate: selectedDate,
      ));
    });

    on<UploadReceiptEvent>((event, emit) {
      receiptPath = event.path;

      emit(AddExpenseInitial(
        selectedCategory: selectedCategory,
        receiptPath: receiptPath,
        selectedDate: selectedDate,
      ));
    });

    on<UpdateDateEvent>((event, emit) {
      selectedDate = event.date;
      emit(AddExpenseInitial(
        selectedCategory: selectedCategory,
        receiptPath: receiptPath,
        selectedDate: selectedDate,
      ));
    });

    on<SubmitExpenseEvent>((event, emit) async {
      if (event.expense.amount <= 0) {
        emit(const AddExpenseError('Amount must be greater than 0'));
        return;
      }
      if (selectedCategory.isEmpty) {
        emit(const AddExpenseError('Please select a category'));
        return;
      }
      if (receiptPath == null || receiptPath!.isEmpty) {
        emit(const AddExpenseError('Please attach a receipt'));
        return;
      }
      if (event.expense.date.isBefore(DateTime(2000))) {
        emit(const AddExpenseError('Please select a valid date'));
        return;
      }
      emit(AddExpenseSubmitting());
      try {
        final updatedExpense = event.expense.copyWith(
          category: selectedCategory,
          convertedAmount: null,
          receiptPath: receiptPath,
          date: selectedDate,
        );
        await addExpenseUseCase(updatedExpense);
        emit(AddExpenseSuccess());
      } catch (e) {
        emit(AddExpenseError(e.toString()));
      }
    });
  }
}



