import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

//1 1.widget utama

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(), // halaman awal aplikasi
    );
  }
}

// 2. halaman utama ( Scaffold )

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('praktikum 1: Widgets'),
        backgroundColor: Colors.blue,
      ),
      //padding untuk memberikan jarak dari tepi layar
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreetingWidget(),   // memanggil StatelessWidget
            SizedBox(height: 20),//jarak vertikal
            BalanceCardWidget(),   // Memanggil statefulWidget
          ],
        ),
      ),
    );
  }
}

// 3. STATELESS WIDGET ( sapaan penggunaan)

class GreetingWidget extends StatelessWidget{
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        //ikon profil
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, size:30, color: Colors.white),
        ),
        SizedBox(width: 12),
        // teks sapaan
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Budi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Selamat datang kembali!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}


// 4. Stateful widget (  kartu saldo dengan toggle )

class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
} 

class _BalanceCardWidgetState extends State<BalanceCardWidget> {
  // variabel state: menyimpan status apakah saldo terluhat atau disensor
  bool _isBalanceVisible = true;

  //fungsi untuk mengubah state
  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;  //membalik nilai boolean ( true <-> false)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // baris atas kartu: teks "saldo utama" & tombol ikon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'saldo utama',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70
                  ),
                ),
                // tombol mata
                IconButton(
                  icon: Icon(
                    // logika if-else singkat ( Ternary operator)
                    _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: _toggleVisibility, // memanggil fungsi ubah state
                ),
              ],
            ),
            const SizedBox(height: 0),
            // teks nominal saldo
            Text(
              // logika if-else untuk menampilkan saldo atau sendor
              _isBalanceVisible ? 'Rp 5.000.000' : 'Rp *********',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color : Colors.white,
              ),
            ),
            const SizedBox(height: 8), // Memberikan jarak vertikal
            // latihan 2
            const Text(
              'No. Rekening: 1234-5678',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70, // Diberi warna sedikit transparan agar tidak mendominasi saldo
              ),
            ),
          ],
        ),
      ),
    );
  }
}