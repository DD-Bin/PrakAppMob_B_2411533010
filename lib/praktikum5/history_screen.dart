import 'package:flutter/material.dart';
import 'transaction_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<TransactionItem> transactions;

  const HistoryScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: const Color(0xFFF59E0B),
        foregroundColor: Colors.white,
      ),
      body: transactions.isEmpty
          ? const Center(child: Text('Belum ada riwayat transaksi'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.isExpense ? Colors.red[50] : Colors.green[50],
                    child: Icon(
                      item.isExpense ? Icons.arrow_downward : Icons.arrow_upward,
                      color: item.isExpense ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${item.category} • ${item.date}'),
                  trailing: Text(
                    item.amount,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: item.isExpense ? Colors.red : Colors.green,
                    ),
                  ),
                );
              },
            ),
    );
  }
}