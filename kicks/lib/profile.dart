import 'package:flutter/material.dart';
import 'LoginPage.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bagian Profil
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Nama Pengguna',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.0),
            Text(
              'user@example.com',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 24.0),
            Divider(),

            // Bagian Opsi Pengaturan
            ListTile(
              leading: Icon(Icons.edit, color: Colors.blue),
              title: Text('Edit Profil'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur Edit Profil belum tersedia.')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.blue),
              title: Text('Ubah Password'),
              onTap: () {
                // Tambahkan logika untuk fitur Ubah Password
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur Ubah Password belum tersedia.')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.blue),
              title: Text('Pengaturan'),
              onTap: () {
              
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur Pengaturan belum tersedia.')),
                );
              },
            ),
            Divider(),
            SizedBox(height: 16.0),

            // Tombol Logout
            ElevatedButton.icon(
              onPressed: () {
                // Arahkan kembali ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
