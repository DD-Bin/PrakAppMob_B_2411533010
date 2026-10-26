class TransactionItem {
  final String title;
  final String amount;
  final String date;
  final String category;
  final bool isExpense;

  TransactionItem({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.isExpense,
  });
}