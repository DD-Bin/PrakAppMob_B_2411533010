import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget{
  const AddTransactionScreen({super.key});

  @override
  State <AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  //gloobalKey untuk mengontrol form dan memicu validasi
  final _formKey = GlobalKey<FormState>();

  //controller untuk mengambil teks dari input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();

  Future<void> _pilihTanggal(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        String day = pickedDate.day.toString().padLeft(2, '0');
        String month = pickedDate.month.toString().padLeft(2, '0');
        String year = pickedDate.year.toString();
        _dateController.text = "$day/$month/$year";
      });
    }
  }

  //State untuk dropdown
  String _selectedCategory = 'makanan';
  final List<String> _categories = ['makanan', 'transportasi', 'hiburan', 'lainnya'];

  @override
  void dispose() {
    // bersihkan controller saat halaman ditutup untuk mencegah memory leak
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: const Text("catat transaksi baru"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // SingleChildScrollView mencegah error layout saat keyboard muncul
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              // input 1: judul transaksi 
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "judul transaksi",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if ( value == null  || value.isEmpty ) {
                    return "judul transaksi tidak boleh kosong";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),

              //input 2: Nominal Saldo ( keyboard Angka )
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "nominal ( RP )",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if ( value == null || value.isEmpty) {
                    return "nominal wajib diisi";
                  }
                  if (int.tryParse(value) == null) {
                    return "harus berupa angka bulat yang valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //input 3 kategori dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: "kategori",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String> (
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 32,),
              
              // latihan 
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Tanggal Transaksi",
                  hintText: "DD/MM/YYYY",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  // Tombol plus untuk memanggil fungsi showDatePicker
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: "Pilih Tanggal",
                    onPressed: () => _pilihTanggal(context),
                  ),
                ),
                // Validasi wajib diisi
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tanggal transaksi wajib diisi";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              //tombol simpan
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  //jalankan validasi
                  if (_formKey.currentState!.validate()) {
                    //jika lolos validasi, tampilkan pop-up snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tersimpan: ${_titleController.text} (Rp ${_amountController.text})',
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },

                child: const Text(
                  "simpan transaksi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}