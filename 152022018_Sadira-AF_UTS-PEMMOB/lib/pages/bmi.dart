import 'package:flutter/material.dart';
import 'dart:math';

// Halaman utama untuk kalkulator BMI
class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  _BmiPageState createState() => _BmiPageState();
}

// State untuk kalkulator BMI
class _BmiPageState extends State<BmiPage> {
  final TextEditingController _ageController = TextEditingController(); // Controller untuk input usia
  final TextEditingController _heightController = TextEditingController(); // Controller untuk input tinggi
  final TextEditingController _weightController = TextEditingController(); // Controller untuk input berat

  String? _selectedGender; // Variabel untuk gender
  double _bmiResult = 0.0; // Hasil BMI
  String _bmiCategory = ''; // Kategori BMI
  String _errorMessage = ''; // Pesan error, jika ada

  // Fungsi untuk menghitung BMI
  void _calculateBMI() {
    setState(() {
      _errorMessage = ''; // Kosongkan pesan error sebelumnya
    });

    final int? age = int.tryParse(_ageController.text); // Parsing input usia
    final double? height = double.tryParse(_heightController.text); // Parsing input tinggi
    final double? weight = double.tryParse(_weightController.text); // Parsing input berat

    // Validasi input
    if (_ageController.text.isEmpty || _heightController.text.isEmpty || _weightController.text.isEmpty || height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _errorMessage = 'Please enter valid age, height, and weight.'; // Set pesan error jika input invalid
        _bmiResult = 0.0;
        _bmiCategory = '';
      });
      return;
    }

    // Menghitung BMI berdasarkan rumus: BMI = berat / (tinggi * tinggi)
    final double bmi = weight / ((height / 100) * (height / 100));

    setState(() {
      _bmiResult = bmi; // Menyimpan hasil BMI
      _bmiCategory = _getBMICategory(bmi); // Menentukan kategori BMI
    });
  }

  // Fungsi untuk menentukan kategori BMI berdasarkan nilai BMI
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight'; // Jika BMI kurang dari 18.5, kategori Underweight
    } else if (bmi < 25) {
      return 'Normal'; // Jika BMI antara 18.5 dan 25, kategori Normal
    } else {
      return 'Overweight'; // Jika BMI lebih dari 25, kategori Overweight
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: Colors.pinkAccent, // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input untuk usia
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Enter your age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Pemilihan jenis kelamin menggunakan radio button
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Input untuk tinggi badan (dalam cm)
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(
                labelText: 'Enter height (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Input untuk berat badan (dalam kg)
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(
                labelText: 'Enter weight (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Tombol untuk menghitung BMI
            ElevatedButton(
              onPressed: _calculateBMI,
              child: const Text('Calculate'),
            ),

            const SizedBox(height: 20),

            // Menampilkan pesan error jika ada
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),

            const SizedBox(height: 20),

            // Menampilkan hasil BMI
            Text(
              'Your BMI: ${_bmiResult.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Menampilkan speedometer untuk BMI
            CustomPaint(
              size: Size(200, 100),
              painter: BmiSpeedometerPainter(_bmiResult),
            ),

            const SizedBox(height: 20),

            // Menampilkan kategori BMI
            Text(
              _bmiCategory,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _getBMICategoryColor(_bmiCategory), // Mengatur warna berdasarkan kategori BMI
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan warna kategori BMI
  Color _getBMICategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.red; // Merah untuk Underweight
      case 'Normal':
        return Colors.green; // Hijau untuk Normal
      case 'Overweight':
        return Colors.red; // Merah untuk Overweight
      default:
        return Colors.black; // Warna default jika kategori kosong
    }
  }
}

// CustomPainter untuk menggambar speedometer
class BmiSpeedometerPainter extends CustomPainter {
  final double bmi;

  BmiSpeedometerPainter(this.bmi);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    // Menggambar latar belakang speedometer
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), pi, pi, true, paint);

    // Menghitung sudut untuk nilai BMI
    double angle = (bmi >= 30)
        ? 1.0 // BMI tinggi
        : (bmi >= 25)
            ? 0.75 // Overweight
            : (bmi >= 18.5)
                ? 0.5 // Normal
                : 0.25; // Underweight

    // Menggambar arc progres BMI
    paint.color = Colors.pinkAccent;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      pi,
      pi * angle,
      true,
      paint,
    );

    // Menampilkan nilai BMI di tengah
    TextSpan span = TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), text: '${bmi.toStringAsFixed(1)}');
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Memungkinkan untuk menggambar ulang
  }
}