import 'package:equatable/equatable.dart';

abstract class AddExpenseState extends Equatable {
  const AddExpenseState();

  @override
  List<Object?> get props => [];
}


class AddExpenseInitial extends AddExpenseState {
  final String selectedCategory;
  final String? receiptPath;
  final DateTime selectedDate;

  const AddExpenseInitial({
    this.selectedCategory = '',
    this.receiptPath,
    required this.selectedDate,
  });

  AddExpenseInitial copyWith({
    String? selectedCategory,
    String? receiptPath,
    DateTime? selectedDate,
  }) {
    return AddExpenseInitial(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      receiptPath: receiptPath ?? this.receiptPath,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, receiptPath, selectedDate];
}

class AddExpenseSubmitting extends AddExpenseState {}

class AddExpenseSuccess extends AddExpenseState {}

class AddExpenseError extends AddExpenseState {
  final String message;

  const AddExpenseError(this.message);

  @override
  List<Object?> get props => [message];
}