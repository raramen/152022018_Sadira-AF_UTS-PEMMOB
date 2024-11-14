import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk mengakses input teks dari pengguna
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Boolean untuk mengatur visibilitas password
  bool passwordVisible = false;

  // Variabel untuk menyimpan pesan error
  String? _nameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    // Membersihkan controller ketika widget dihapus dari widget tree
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk validasi input dan navigasi ke dashboard jika valid
  void _validateAndRegister() {
    setState(() {
      // Mengatur pesan error jika ada field yang kosong
      _nameError = _nameController.text.isEmpty ? 'Name is required' : null;
      _phoneError = _phoneController.text.isEmpty ? 'Phone Number is required' : null;
      _emailError = _emailController.text.isEmpty ? 'Email is required' : null;
      _passwordError = _passwordController.text.isEmpty ? 'Password is required' : null;
    });

    // Cek jika semua field diisi (tidak ada error)
    if (_nameError == null && _phoneError == null && _emailError == null && _passwordError == null) {
      // Jika tidak ada error, navigasi ke halaman dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image: Gambar latar belakang untuk halaman register
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Pastikan gambar ini ada di folder assets
                fit: BoxFit.cover,  // Menyelaraskan gambar dengan ukuran layar
              ),
            ),
          ),
          // Gradient Overlay: Lapisan gelap di atas gambar latar belakang
          Container(
            color: Colors.black54,
          ),
          // Register Form
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: 300,  // Lebar form register
                padding: const EdgeInsets.all(20),  // Padding di dalam form
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),  // Sudut melengkung pada form
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
                    // Teks "Create Account" sebagai judul form
                    Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 129, 148, 163),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk input nama
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.person),  // Ikon user
                        errorText: _nameError, // Menampilkan pesan error jika ada
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk input nomor telepon
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.phone),  // Ikon telepon
                        errorText: _phoneError, // Menampilkan pesan error jika ada
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk input email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.email),  // Ikon email
                        errorText: _emailError, // Menampilkan pesan error jika ada
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk input password
                    TextField(
                      controller: _passwordController,
                      obscureText: !passwordVisible,  // Mengatur visibilitas password
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        // Ikon untuk menampilkan atau menyembunyikan password
                        suffixIcon: IconButton(
                          icon: Icon(
                            passwordVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;  // Mengubah status visibilitas password
                            });
                          },
                        ),
                        errorText: _passwordError, // Menampilkan pesan error jika ada
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Tombol Register
                    ElevatedButton(
                      onPressed: _validateAndRegister,  // Fungsi untuk validasi dan registrasi
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 218, 170, 238),  // Warna tombol
                        padding: const EdgeInsets.symmetric(vertical: 15),  // Padding vertikal tombol
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),  // Sudut melengkung pada tombol
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 16),  // Ukuran font pada tombol
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