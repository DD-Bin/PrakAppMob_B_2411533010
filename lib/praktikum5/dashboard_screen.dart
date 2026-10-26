import 'package:flutter/material.dart';
import 'transaction_model.dart';

class DashboardScreen extends StatelessWidget {
  final String userEmail;
  final List<TransactionItem> transactions;
  final VoidCallback onAddPressed;

  const DashboardScreen({
    super.key,
    required this.userEmail,
    required this.transactions,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
        onPressed: onAddPressed,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF59E0B),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, $userEmail!',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Rp 5.000.000',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildQuickActionButton(Icons.arrow_downward, const Color(0xFFFEF3C7), Colors.amber[900]!),
                      _buildQuickActionButton(Icons.arrow_upward, const Color(0xFFFCE7F3), Colors.pink[400]!),
                      _buildQuickActionButton(Icons.swap_horiz, const Color(0xFFE0E7FF), Colors.blue[600]!),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transaksi Terakhir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  transactions.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: Text('Belum ada transaksi'),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length > 5 ? 5 : transactions.length,
                          itemBuilder: (context, index) {
                            final item = transactions[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFFFEF3C7),
                                  child: Icon(
                                    item.isExpense ? Icons.restaurant : Icons.attach_money,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                ),
                                title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(item.date),
                                trailing: Text(
                                  item.amount,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: item.isExpense ? Colors.red : Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}