import 'package:hive/hive.dart';
import '../models/expense_model.dart';

class ExpenseLocalDataSource {
  static const String _boxName = 'expenses_box';

  Future<void> addExpense(ExpenseModel model) async {
    final box = Hive.box<ExpenseModel>(_boxName);
    await box.put(model.hiveId, model);
  }

  Future<List<ExpenseModel>> getExpenses() async {
    final box = Hive.box<ExpenseModel>(_boxName);
    return box.values.toList();
  }

  Future<void> deleteExpense(String id) async {
    final box = Hive.box<ExpenseModel>(_boxName);
    await box.delete(id);
  }

  Future<void> clearAllExpenses() async {
    final box = Hive.box<ExpenseModel>(_boxName);
    await box.clear();
  }
}