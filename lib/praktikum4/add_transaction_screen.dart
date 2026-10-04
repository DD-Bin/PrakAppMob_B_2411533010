import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // 1. Controller untuk menampung Tanggal Transaksi
  final _dateController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // 2. Fungsi Pemilih Tanggal (Date Picker)
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        // Format tanggal menjadi DD/MM/YYYY
        String day = pickedDate.day.toString().padLeft(2, '0');
        String month = pickedDate.month.toString().padLeft(2, '0');
        String year = pickedDate.year.toString();
        _dateController.text = "$day/$month/$year";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catat Transaksi"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Judul",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Tidak boleh kosong" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Nominal",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Tidak boleh kosong" : null,
                ),
                const SizedBox(height: 16),

                // 3. Input Tanggal Transaksi (Latihan 1.5)
                TextFormField(
                  controller: _dateController,
                  readOnly: true, // Mencegah ketik manual agar format tetap konsisten
                  decoration: InputDecoration(
                    labelText: "Tanggal Transaksi",
                    hintText: "DD/MM/YYYY",
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  onTap: () => _selectDate(context),
                  // Validasi wajib diisi
                  validator: (value) =>
                      value == null || value.isEmpty ? "Tanggal wajib diisi!" : null,
                ),
                const SizedBox(height: 32),

                // Tombol Simpan
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // Cek validasi seluruh input (Judul, Nominal, Tanggal)
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transaksi Berhasil Disimpan!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // NAVIGASI POP: Kembali ke Halaman Utama (Dashboard)
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Simpan", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}