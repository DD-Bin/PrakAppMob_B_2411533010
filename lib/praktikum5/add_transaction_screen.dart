import 'package:flutter/material.dart';
import 'transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = 'Makanan';
  bool _isExpense = true;

  void _saveTransaction() {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;

    final newTransaction = TransactionItem(
      title: _titleController.text,
      amount: '${_isExpense ? "- Rp " : "+ Rp "}${_amountController.text}',
      date: 'Hari ini',
      category: _category,
      isExpense: _isExpense,
    );

    // Mengembalikan data transaksi baru ke halaman sebelumnya
    Navigator.pop(context, newTransaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
        backgroundColor: const Color(0xFFF59E0B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Nama Transaksi', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nominal (cth: 50.000)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text(_isExpense ? 'Pengeluaran' : 'Pemasukan'),
              value: _isExpense,
              onChanged: (val) => setState(() => _isExpense = val),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF59E0B)),
                onPressed: _saveTransaction,
                child: const Text('Simpan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}