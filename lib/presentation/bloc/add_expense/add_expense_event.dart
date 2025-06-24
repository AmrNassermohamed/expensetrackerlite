import 'package:equatable/equatable.dart';
import '../../../domain/entities/expense.dart';

abstract class AddExpenseEvent extends Equatable {
  const AddExpenseEvent();

  @override
  List<Object?> get props => [];
}

class SelectCategoryEvent extends AddExpenseEvent {
  final String category;

  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
class UploadReceiptEvent extends AddExpenseEvent {
  final String path;
  const UploadReceiptEvent(this.path);
}

class SubmitExpenseEvent extends AddExpenseEvent {
  final Expense expense;

  const SubmitExpenseEvent(this.expense);

  @override
  List<Object?> get props => [expense];
}
class UpdateDateEvent extends AddExpenseEvent {
  final DateTime date;
  UpdateDateEvent(this.date);
}