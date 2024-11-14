import 'package:flutter/material.dart'; // Mengimpor package Flutter yang menyediakan widget dasar untuk membuat aplikasi.
import 'package:cobalogin/pages/splash_screen.dart'; // Mengimpor halaman splash screen.
import 'package:cobalogin/pages/login1.dart'; // Mengimpor halaman login.
import 'package:cobalogin/pages/register.dart'; // Mengimpor halaman register.
import 'package:cobalogin/pages/dashboard.dart'; // Mengimpor halaman dashboard.

void main() {
  runApp(const MyApp()); // Menjalankan aplikasi dengan widget root 'MyApp'.
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp', // Judul aplikasi.
      debugShowCheckedModeBanner: false, // Menghilangkan banner "debug" di pojok kanan atas.
      theme: ThemeData(
        primarySwatch: Colors.pink, // Mengatur tema utama aplikasi dengan warna dasar 'pink'.
      ),
      initialRoute: '/', // Menetapkan rute awal saat aplikasi pertama kali dibuka, yaitu halaman splash screen.
      routes: {
        '/': (context) => const SplashScreen(), // Rute menuju halaman SplashScreen.
        '/login': (context) => LoginPage(), // Rute menuju halaman LoginPage.
        '/register': (context) => const RegisterPage(), // Rute menuju halaman RegisterPage.
        '/dashboard': (context) => const DashboardPage(), // Rute menuju halaman DashboardPage.
      },
    );
  }
}