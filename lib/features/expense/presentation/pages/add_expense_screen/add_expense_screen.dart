import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/action_button.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/amount_field.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/category_grid.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/date_field.dart';
import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/recipt_uploader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/ui_constants.dart';
import '../../bloc/add_expense/add_expense_bloc.dart';
import '../../bloc/add_expense/add_expense_state.dart';

class AddExpenseScreen extends StatelessWidget {
   AddExpenseScreen({super.key});

  final _amountController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String selectedCategory = 'Entertainment';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddExpenseBloc, AddExpenseState>(
      listener: (context, state) {
        if (state is AddExpenseSubmitting) {
          // optional loading state
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(content: Text('Expense added successfully!')),
          // );
        } else if (state is AddExpenseSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Expense added successfully!')),
          );
          // Navigator.pop(context); // return to Dashboard
        } else if (state is AddExpenseError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Expense'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              AmountField(controller: _amountController),
              const SizedBox(height: 16),
              const DateField(),
              const SizedBox(height: 16),
              const ReceiptUploader(),
              const SizedBox(height: 24),
              const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              CategoryGrid(categories: ExpenseCategories),
              const SizedBox(height: 24),
               ActionButton(controller: _amountController,),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}