import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/expense.dart';
import '../../../bloc/add_expense/add_expense_bloc.dart';
import '../../../bloc/add_expense/add_expense_event.dart';
import '../../../bloc/add_expense/add_expense_state.dart';

class ActionButton extends StatelessWidget {
   final TextEditingController controller;

  const ActionButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final bloc = context.read<AddExpenseBloc>();
        final selected = bloc.selectedCategory;
        final state = bloc.state;

        final selectedDate = (state is AddExpenseInitial) ? state.selectedDate : DateTime.now();
        final receiptPath = (state is AddExpenseInitial) ? state.receiptPath : null;

        final expense = Expense(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: selected,
          amount: double.tryParse(controller.text) ?? 0.0,
          date: selectedDate,
          category: selected,
          convertedAmountUSD: 0,
          receiptPath: receiptPath,
        );

        bloc.add(SubmitExpenseEvent(expense));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF246BFD),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }


}