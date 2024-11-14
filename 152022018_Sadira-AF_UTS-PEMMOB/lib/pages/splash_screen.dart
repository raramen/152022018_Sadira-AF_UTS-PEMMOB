import 'dart:async'; // Mengimpor library untuk penggunaan Timer.
import 'package:flutter/material.dart'; // Mengimpor library material design untuk widget Flutter.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState(); // Membuat state untuk SplashScreen.
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Timer untuk menunda perpindahan ke halaman login selama 5 detik.
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login'); // Mengarahkan ke halaman login setelah 5 detik.
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 170, 238), // Mengatur warna latar belakang.
      body: Align(
        alignment: Alignment.topCenter, // Menempatkan konten di bagian atas layar.
        child: Padding(
          padding: EdgeInsets.only(top: 80), // Memberikan jarak dari atas layar.
          child: Column(
            mainAxisSize: MainAxisSize.min, // Menjaga kolom tetap sekompak mungkin.
            children: [
              Image(
                image: AssetImage('assets/foto1.png'), // Menampilkan gambar dari folder assets.
                width: 300, // Mengatur lebar gambar.
                height: 300, // Mengatur tinggi gambar.
              ),
              SizedBox(height: 20), // Jarak antar elemen sebesar 20 piksel.
              Icon(
                Icons.assignment, // Menampilkan ikon assignment.
                size: 100, // Mengatur ukuran ikon.
                color: Colors.white, // Mengatur warna ikon menjadi putih.
              ),
              SizedBox(height: 20), // Jarak antar elemen sebesar 20 piksel.
              Text(
                '152022018 Sadira Amalina F', // Menampilkan teks dengan nama dan ID.
                style: TextStyle(
                  color: Colors.white, // Mengatur warna teks menjadi putih.
                  fontSize: 24, // Mengatur ukuran teks.
                  fontWeight: FontWeight.bold, // Membuat teks menjadi tebal.
                ),
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah.
              ),
              Text(
                'Aplikasi UTS', // Menampilkan teks judul aplikasi.
                style: TextStyle(
                  color: Colors.white, // Mengatur warna teks menjadi putih.
                  fontSize: 24, // Mengatur ukuran teks.
                  fontWeight: FontWeight.bold, // Membuat teks menjadi tebal.
                ),
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
