import 'package:expensetrackerlite/domain/entities/expense.dart';
import 'package:hive/hive.dart';




part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends Expense {
  @HiveField(0)
  final String hiveId;

  @HiveField(1)
  final String hiveTitle;

  @HiveField(2)
  final double hiveAmount;

  @HiveField(3)
  final DateTime hiveDate;

  @HiveField(4)
  final String hiveCategory;

  @HiveField(5)
  final double hiveConvertedAmountUSD;

  ExpenseModel({
    required this.hiveId,
    required this.hiveTitle,
    required this.hiveAmount,
    required this.hiveDate,
    required this.hiveCategory,
    required this.hiveConvertedAmountUSD,
  }) : super(
    id: hiveId,
    title: hiveTitle,
    amount: hiveAmount,
    date: hiveDate,
    category: hiveCategory,
    convertedAmountUSD: hiveConvertedAmountUSD,
  );

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      hiveId: expense.id,
      hiveTitle: expense.title,
      hiveAmount: expense.amount,
      hiveDate: expense.date,
      hiveCategory: expense.category,
      hiveConvertedAmountUSD: expense.convertedAmountUSD,
    );
  }


  Expense toEntity() {
    return Expense(
      id: hiveId,
      title: hiveTitle,
      amount: hiveAmount,
      date: hiveDate,
      category: hiveCategory,
      convertedAmountUSD: hiveConvertedAmountUSD,
    );
  }
}
