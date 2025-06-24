// Category Grid Widget
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/add_expense/add_expense_bloc.dart';
import '../../../bloc/add_expense/add_expense_event.dart';
import '../../../bloc/add_expense/add_expense_state.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
      builder: (context, state) {
        String selected = '';
        if (state is AddExpenseInitial) {
          selected = state.selectedCategory;
        }

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: categories.map((cat) {
            final isSelected = cat['name'] == selected;

            return GestureDetector(
              onTap: () {
                context.read<AddExpenseBloc>().add(SelectCategoryEvent(cat['name']));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: isSelected ? const Color(0xFF246BFD) : const Color(0xFFF1F3F6),
                    child: Icon(cat['icon'], color: isSelected ? Colors.white : Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['name'],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
