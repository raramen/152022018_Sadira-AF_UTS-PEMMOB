import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double? _firstNumber; // Menyimpan angka pertama untuk operasi
  double? _secondNumber; // Menyimpan angka kedua untuk operasi
  String? _operator; // Menyimpan operator matematika yang dipilih
  String _result = ''; // Menyimpan hasil perhitungan
  final TextEditingController _inputController = TextEditingController(); // Controller untuk input teks

  // Fungsi untuk menambah angka ke input saat tombol angka ditekan
  void _appendNumber(String number) {
    setState(() {
      // Memastikan hanya angka atau titik desimal yang bisa dimasukkan
      if (number == '.' && _inputController.text.contains('.')) {
        // Mencegah penambahan titik desimal ganda
        return;
      }
      _inputController.text += number; // Menambahkan angka ke input
    });
  }

  // Fungsi untuk menyet operator (tambah, kurang, kali, bagi)
  void _setOperator(String operator) {
    if (_firstNumber == null) {
      _firstNumber = double.tryParse(_inputController.text); // Menyimpan angka pertama
      _operator = operator; // Menyimpan operator yang dipilih
      _inputController.clear(); // Menghapus input setelah operator diset
    }
  }

  // Fungsi untuk melakukan perhitungan setelah operator dan angka kedua diset
  void _calculate() {
    // Cek jika input kosong sebelum melakukan perhitungan
    if (_inputController.text.isEmpty) {
      // Menampilkan pesan SnackBar jika input kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a number to calculate'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Pastikan angka pertama dan operator sudah diinput
    if (_firstNumber != null && _operator != null) {
      _secondNumber = double.tryParse(_inputController.text); // Menyimpan angka kedua
      if (_secondNumber == null) {
        setState(() {
          _result = 'Invalid input'; // Menampilkan pesan jika input tidak valid
        });
        return;
      }

      double calculationResult;
      // Melakukan perhitungan berdasarkan operator
      switch (_operator) {
        case '+':
          calculationResult = _firstNumber! + _secondNumber!;
          break;
        case '-':
          calculationResult = _firstNumber! - _secondNumber!;
          break;
        case '*':
          calculationResult = _firstNumber! * _secondNumber!;
          break;
        case '/':
          if (_secondNumber == 0) {
            setState(() {
              _result = 'Cannot divide by zero'; // Menangani pembagian dengan nol
            });
            return;
          }
          calculationResult = _firstNumber! / _secondNumber!;
          break;
        default:
          calculationResult = 0;
      }

      setState(() {
        _result = calculationResult.toString(); // Menampilkan hasil perhitungan
        _inputController.clear(); // Menghapus input setelah perhitungan
        _firstNumber = null; // Menghapus angka pertama setelah perhitungan
        _secondNumber = null; // Menghapus angka kedua setelah perhitungan
        _operator = null; // Menghapus operator setelah perhitungan
      });
    }
  }

  // Fungsi untuk menghapus input dan hasil perhitungan
  void _clear() {
    setState(() {
      _firstNumber = null;
      _secondNumber = null;
      _operator = null;
      _inputController.clear();
      _result = ''; // Menghapus hasil perhitungan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')), // Judul pada AppBar
      body: Padding(
        padding: const EdgeInsets.all(20), // Padding untuk tampilan
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Menyusun elemen secara vertikal
          children: [
            // Input field untuk menampilkan angka yang sedang diketik
            TextField(
              controller: _inputController, // Menghubungkan dengan controller
              decoration: const InputDecoration(
                labelText: 'Input', // Label input
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.none, // Tidak menggunakan keyboard fisik
              readOnly: true, // Membuat input hanya bisa dibaca
            ),
            const SizedBox(height: 20),
            // Menampilkan hasil perhitungan
            Text(
              'Result: $_result', // Menampilkan hasil perhitungan
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Tombol untuk angka 0-9
            GridView.count(
              crossAxisCount: 3, // Menampilkan 3 kolom
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Tidak bisa scroll
              children: List.generate(10, (index) {
                return ElevatedButton(
                  onPressed: () => _appendNumber(index.toString()), // Menambahkan angka ke input
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    minimumSize: const Size(40, 40),
                  ),
                  child: Text(
                    index.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList()
                ..add(ElevatedButton(
                  onPressed: () => _appendNumber('.'), // Menambahkan titik desimal
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    minimumSize: const Size(40, 40),
                  ),
                  child: const Text(
                    '.',
                    style: TextStyle(fontSize: 16),
                  ),
                )),
            ),
            const SizedBox(height: 20),
            // Tombol operator (+, -, *, /)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _setOperator('+'), // Menetapkan operator tambah
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('-'), // Menetapkan operator kurang
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('*'), // Menetapkan operator kali
                  child: const Text('*'),
                ),
                ElevatedButton(
                  onPressed: () => _setOperator('/'), // Menetapkan operator bagi
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Tombol untuk perhitungan (=) dan menghapus input (Clear)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _calculate, // Menjalankan perhitungan
                  child: const Text('='), 
                ),
                ElevatedButton(
                  onPressed: _clear, // Menghapus input dan hasil perhitungan
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}