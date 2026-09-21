import 'package:flutter/material.dart';
import 'add_transaction_screen.dart'; //memanggil file form input

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'expense Tracker - modul 3',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, //tema warna modul 3
      ),
      home: const AddTransactionScreen(),  // langsung membuka halaman form
    );
  }
}

