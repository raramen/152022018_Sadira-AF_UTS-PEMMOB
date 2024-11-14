import 'package:flutter/material.dart';

// Membuat widget Stateful untuk halaman konversi suhu
class Suhu extends StatefulWidget {
  @override
  _SuhuState createState() => _SuhuState();
}

class _SuhuState extends State<Suhu> {
  // Controller untuk input suhu
  final TextEditingController _inputController = TextEditingController();
  
  // Variabel untuk menyimpan unit asal dan tujuan konversi
  String _fromUnit = 'Celsius';  // Unit asal konversi, defaultnya adalah Celsius
  String _toUnit = 'Fahrenheit';  // Unit tujuan konversi, defaultnya adalah Fahrenheit
  double? _result;  // Variabel untuk menyimpan hasil konversi suhu

  // Daftar unit suhu yang digunakan dalam dropdown
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  // Fungsi untuk melakukan konversi suhu
  void _convertTemperature() {
    // Mengambil input suhu yang dimasukkan pengguna dan mencoba mengonversinya menjadi double
    double? inputTemperature = double.tryParse(_inputController.text);
    
    // Jika input tidak valid, tampilkan SnackBar dan set hasil ke null
    if (inputTemperature == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid temperature'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _result = null;  // Kosongkan hasil jika input tidak valid
      });
      return;
    }

    double convertedTemperature;  // Variabel untuk menyimpan suhu yang sudah dikonversi

    // Melakukan konversi suhu berdasarkan unit asal (_fromUnit) dan unit tujuan (_toUnit)
    if (_fromUnit == 'Celsius') {
      if (_toUnit == 'Fahrenheit') {
        convertedTemperature = (inputTemperature * 9 / 5) + 32;  // Konversi dari Celsius ke Fahrenheit
      } else if (_toUnit == 'Kelvin') {
        convertedTemperature = inputTemperature + 273.15;  // Konversi dari Celsius ke Kelvin
      } else {
        convertedTemperature = inputTemperature;  // Jika unit tujuan sama dengan unit asal (Celsius)
      }
    } else if (_fromUnit == 'Fahrenheit') {
      if (_toUnit == 'Celsius') {
        convertedTemperature = (inputTemperature - 32) * 5 / 9;  // Konversi dari Fahrenheit ke Celsius
      } else if (_toUnit == 'Kelvin') {
        convertedTemperature = (inputTemperature - 32) * 5 / 9 + 273.15;  // Konversi dari Fahrenheit ke Kelvin
      } else {
        convertedTemperature = inputTemperature;  // Jika unit tujuan sama dengan unit asal (Fahrenheit)
      }
    } else { // Unit asal adalah Kelvin
      if (_toUnit == 'Celsius') {
        convertedTemperature = inputTemperature - 273.15;  // Konversi dari Kelvin ke Celsius
      } else if (_toUnit == 'Fahrenheit') {
        convertedTemperature = (inputTemperature - 273.15) * 9 / 5 + 32;  // Konversi dari Kelvin ke Fahrenheit
      } else {
        convertedTemperature = inputTemperature;  // Jika unit tujuan sama dengan unit asal (Kelvin)
      }
    }

    // Mengupdate hasil konversi dan menampilkan hasil pada UI
    setState(() {
      _result = convertedTemperature;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),  // Judul aplikasi
        backgroundColor: Colors.pinkAccent,  // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Field input untuk suhu yang ingin dikonversi
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter temperature',  // Label untuk input suhu
                border: OutlineInputBorder(),  // Border untuk input field
              ),
              keyboardType: TextInputType.number,  // Hanya menerima input angka
            ),
            const SizedBox(height: 20),  // Spacer
            // Dropdown untuk memilih unit asal suhu
            DropdownButton<String>(
              value: _fromUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;  // Update unit asal suhu
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),  // Spacer
            // Dropdown untuk memilih unit tujuan suhu
            DropdownButton<String>(
              value: _toUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;  // Update unit tujuan suhu
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),  // Spacer
            // Tombol untuk melakukan konversi suhu
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),  // Teks pada tombol
            ),
            const SizedBox(height: 20),  // Spacer
            // Menampilkan hasil konversi jika ada hasil
            if (_result != null)
              Text(
                'Converted Temperature: ${_result!.toStringAsFixed(2)} °${_toUnit[0]}',  // Menampilkan hasil konversi
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}