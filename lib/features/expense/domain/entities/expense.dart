class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final double convertedAmountUSD;
  final String? receiptPath; // optional receipt image path

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.convertedAmountUSD,
    this.receiptPath,
  });

  Expense copyWith({
    String? title,
    double? amount,
    DateTime? date,
    String? category,
    double? convertedAmount,
    String? receiptPath,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      convertedAmountUSD: convertedAmount ?? convertedAmountUSD,
      receiptPath: receiptPath ?? this.receiptPath,
    );
  }
}
