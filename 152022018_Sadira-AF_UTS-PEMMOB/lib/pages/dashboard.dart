import 'package:cobalogin/pages/suhu.dart'; // Import halaman konversi suhu
import 'package:flutter/material.dart';
import 'package:cobalogin/pages/login1.dart'; // Import halaman login
import 'package:cobalogin/pages/calculator.dart'; // Import halaman kalkulator
import 'package:cobalogin/pages/bmi.dart'; // Import halaman BMI
import 'package:cobalogin/pages/konversi.dart'; // Import halaman konversi mata uang

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String? _displayText = ''; // Menyimpan nama pengguna
  String _greetingMessage = ''; // Menyimpan pesan sapaan
  bool _isSubmitted = false; // Menyimpan status apakah nama sudah disubmit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'), // Judul pada AppBar
        backgroundColor: Colors.pinkAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/background.jpeg'), // Gambar profil
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome, $_displayText', // Menampilkan nama yang disubmit
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Menutup drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () {
                // Navigasi ke halaman kalkulator
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.accessibility),
              title: const Text('BMI'),
              onTap: () {
                // Navigasi ke halaman BMI
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BmiPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Currency Converter'),
              onTap: () {
                // Navigasi ke halaman konversi mata uang
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CurrencyConverterPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.thermostat),
              title: const Text('Temperature Converter'),
              onTap: () {
                // Navigasi ke halaman konversi suhu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Suhu()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pop(context); // Menutup drawer
                // Navigasi ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (!_isSubmitted) // Menampilkan input hanya jika belum disubmit
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter your name', // Placeholder untuk nama
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _displayText = value; // Menyimpan nama yang diinputkan
                });
              },
            ),
          const SizedBox(height: 10),
          if (!_isSubmitted) // Menampilkan tombol submit jika belum disubmit
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSubmitted = true; // Menandai bahwa nama sudah disubmit

                  // Mendapatkan waktu saat ini untuk menentukan sapaan
                  final hour = DateTime.now().hour;
                  String greeting;

                  if (hour < 12) {
                    greeting = 'Good Morning';
                  } else if (hour < 18) {
                    greeting = 'Good Afternoon';
                  } else {
                    greeting = 'Good Evening';
                  }

                  _greetingMessage = '$greeting, $_displayText! Have a nice day! 😊'; // Membuat pesan sapaan
                });
              },
              child: const Text('Submit'), // Teks pada tombol submit
            ),
          const SizedBox(height: 20),
          // Menampilkan pesan sapaan secara permanen setelah disubmit
          if (_isSubmitted)
            Text(
              _greetingMessage,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}