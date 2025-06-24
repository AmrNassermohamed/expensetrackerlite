// Date Field Widget
import 'package:expensetrackerlite/presentation/pages/add_expense_screen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../bloc/add_expense/add_expense_bloc.dart';
import '../../../bloc/add_expense/add_expense_event.dart';
import '../../../bloc/add_expense/add_expense_state.dart';

class DateField extends StatelessWidget {
  const DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
      builder: (context, state) {
        final bloc = context.read<AddExpenseBloc>();
        final date = (state is AddExpenseInitial) ? state.selectedDate : DateTime.now();

        return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          CustomTextFormField(
            readOnly: true,
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                bloc.add(UpdateDateEvent(pickedDate));
              }
            },
            labelText: DateFormat('dd/MM/yy').format(date),
            suffixIcon:  Icons.calendar_today,
            hintText: DateFormat('dd/MM/yy').format(date),

          )
        ],)

         ;
      },
    );
  }
}
