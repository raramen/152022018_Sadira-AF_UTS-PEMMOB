import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  // Controller untuk mengambil input username dan password dari pengguna
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image: Menampilkan gambar latar belakang
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),  // Pastikan gambar ini ada di folder assets
                fit: BoxFit.cover,  // Menyesuaikan gambar agar memenuhi seluruh layar
              ),
            ),
          ),
          // Gradient Overlay: Lapisan warna hitam semi-transparan di atas gambar background
          Container(
            color: Colors.black54,
          ),
          // Login Form: Formulir login yang ditampilkan di tengah layar
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,  // Latar belakang putih untuk kontainer form
                  borderRadius: BorderRadius.circular(10),  // Sudut melengkung
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,  // Warna bayangan
                      blurRadius: 10,  // Tingkat blur bayangan
                      offset: Offset(0, 2),  // Posisi bayangan
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Teks Selamat Datang
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 218, 170, 238),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // TextField untuk username
                    TextField(
                      controller: _usernameController,  // Menggunakan controller untuk mengambil input
                      decoration: const InputDecoration(
                        labelText: 'Username',  // Label yang muncul di dalam field
                        border: OutlineInputBorder(),  // Bingkai field
                        prefixIcon: Icon(Icons.person),  // Ikon di sebelah kiri
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk password
                    TextField(
                      controller: _passwordController,
                      obscureText: true,  // Menyembunyikan teks sebagai tanda bintang
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Login
                    ElevatedButton(
                      onPressed: () {
                        // Logika login
                        String username = _usernameController.text;
                        String password = _passwordController.text;

                        if (username.isNotEmpty && password.isNotEmpty) {
                          print('Navigating to dashboard');
                          // Navigasi ke dashboard setelah login berhasil
                          Navigator.pushReplacementNamed(context, '/dashboard');
                        } else {
                          // Menampilkan pesan kesalahan jika username atau password kosong
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter username and password'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 218, 170, 238),  // Warna tombol
                        padding: const EdgeInsets.symmetric(vertical: 15),  // Padding vertikal tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),  // Sudut melengkung tombol
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),  // Ukuran font tombol
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Tombol untuk Sign Up
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman daftar
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Color.fromARGB(255, 143, 159, 172)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}