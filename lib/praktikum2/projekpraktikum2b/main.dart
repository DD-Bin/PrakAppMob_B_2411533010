import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Widget Utama ( root Aplikasi)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'expense tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}

// 2. HAlAMAN UTAMA ( Scaffold ) - Diperbarui
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 2 : layouting'),
        backgroundColor: Colors.blue,
      ),
      //mengunakan SingleChildScrollView agar layar bisa di scroll
      body: const SingleChildScrollView(
        child : Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GreetingWidget(),   //dari modul 1 
              SizedBox(height: 20),   
              BalanceCardWidget(), //dari modul 1
              SizedBox(height: 20),
              ActionButtonWidget(),//Wiidget baru modul 2
              SizedBox(height: 20),
              RecentTransactionWidget(),//widget baru modul 2
            ],
          ),
        ),
      ),
    );
  }
}


// 3. STATELESS WIDGET ( Sapaan - dari Modul 1)
class GreetingWidget extends StatelessWidget {
  const GreetingWidget ({super.key});

    @override 
    Widget build(BuildContext contextt) {
      return const Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.person, size:30, color: Colors.white),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Halo, budi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('selamat datang kembali!',style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      );
    }
  }



// 4. Stateful widget (kartu saldo - dari modul 1)
class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget ({super.key});

  @override
  State<BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<BalanceCardWidget> {
  bool _isBalanceVisible = true;

  _toggleVisibility() {
    setState(() {
       _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('saldo utama', style: TextStyle(fontSize: 16, color: Colors.white70)),
                IconButton(
                  icon: Icon(_isBalanceVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white,),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBalanceVisible ? 'Rp 5.000.000' : 'Rp *********',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Widget Tombol aksi ( ROW - baru )
class ActionButtonWidget extends StatelessWidget {
  const ActionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // menggunakan row sementara untuk menata tombol secara horizontal
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // jarak dibagi rata 
      children: [
        
        // latihan 1
        _buildActionButton(Icons.arrow_downward, 'pemasukan', Colors.green),
        _buildActionButton(Icons.arrow_upward, 'pengeluaran', Colors.red),
        _buildActionButton(Icons.swap_horiz, 'transfer', Colors.blue),
      ],
    );
  }

  // fungsi pembantu untuk membuat desain tombol agar kode tidak berulang 
  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        //container untuk membungkus ikon dengan warna background
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2), //warna transparan
            borderRadius: BorderRadius.circular(12)
          ),
          child: Icon(icon, color:color, size: 28),
        ),
        const SizedBox(height: 8,),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

// 6. Widget Dafar transaksi (Column & list tile) - baru
class RecentTransactionWidget extends StatelessWidget {
  const RecentTransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'transaksi terakhir',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12,),
        //menggunakan card agar daftar transaksi memiliki bayangan/bingkai
        Card(elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            //item transaksi 1
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.fastfood, color: Colors.white),
              ),
              title: const Text('makan siang'),
              subtitle: const Text('13 september 2026'),
              trailing: const Text(
                '- Rp 50.000',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),  //tanggal statis
            ),
            const Divider(height: 1,), //garis pemisah

            //item Transaksi 2
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.attach_money, color: Colors.white,),
              ),
              title: const Text('gaji bulanan'),
              subtitle: const Text('01 september 2026'),
              trailing: const Text(
                '+ Rp 5.000.000',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 1,),
            
            //item transaksi 3
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.directions_car, color: Colors.white,),
              ),
              title: const Text('isi bensin'),
              subtitle: const Text('10 sep 2026'),
              trailing:  const Text(
                '- Rp 150.000',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
            
            //Latihan 2
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
                child: Icon(Icons.fastfood, color: Colors.white,),
              ),
              title: const Text('Beli Gacoan'),
              subtitle: const Text('10 sep 2026'),
              trailing:  const Text(
                '- Rp 150.000.000',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),

            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.money, color: Colors.white,),
              ),
              title: const Text('Menang Judol'),
              subtitle: const Text('10 sep 2026'),
              trailing:  const Text(
                '+ Rp 550.000',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      )
      ],
    );
  }
}
