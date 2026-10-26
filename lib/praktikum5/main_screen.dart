import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'history_screen.dart';
import 'profile_screen.dart';
import 'transaction_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<TransactionItem> _transactions = [
    TransactionItem(
      title: 'Makan Siang',
      amount: '- Rp 50.000',
      date: 'Hari ini',
      category: 'Makanan',
      isExpense: true,
    ),
  ];

  Future<void> _navigateToAddScreen() async {
    final result = await Navigator.pushNamed(context, '/add');
    if (result != null && result is TransactionItem) {
      setState(() {
        _transactions.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen email yang dikirim dari LoginScreen
    final String userEmail = (ModalRoute.of(context)?.settings.arguments as String?) ?? 'budi@gmail.com';

    final List<Widget> pages = [
      DashboardScreen(
        userEmail: userEmail,
        transactions: _transactions,
        onAddPressed: _navigateToAddScreen,
      ),
      HistoryScreen(transactions: _transactions),
      ProfileScreen(userEmail: userEmail),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: Colors.amber[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}