import 'dart:io';
import 'package:expensetrackerlite/features/expense/presentation/pages/add_expense_screen/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/add_expense/add_expense_bloc.dart';
import '../../../bloc/add_expense/add_expense_event.dart';
import '../../../bloc/add_expense/add_expense_state.dart';

class ReceiptUploader extends StatelessWidget {
  const ReceiptUploader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddExpenseBloc, AddExpenseState>(
      builder: (context, state) {
        String? path;
        if (state is AddExpenseInitial) {
          path = state.receiptPath;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              readOnly: true,
              onTap: () async {
                final picker = ImagePicker();
                final file = await picker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  context.read<AddExpenseBloc>().add(UploadReceiptEvent(file.path));
                }
              },
                labelText: 'Attach Receipt',
                suffixIcon: Icons.camera_alt,
                fillColor: Colors.white,
            ),
            if (path != null) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(path),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
