import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna'),
        backgroundColor: const Color(0xFFF59E0B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFFF59E0B),
                child: Icon(Icons.person, size: 55, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                userEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout', style: TextStyle(fontSize: 16)),
                  onPressed: () {
                    // Membersihkan seluruh route dan kembali ke layar login
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}