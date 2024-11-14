import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  @override
  _CurrencyConverterPageState createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedInputCurrency;
  String? _selectedOutputCurrency;
  double _conversionResult = 0.0;

  // Kode konversi mata uang (contoh)
  final Map<String, double> _exchangeRates = {
    'Rupiah': 1.0,    // 1 Rupiah
    'USD': 0.000066,  // Rupiah to USD
    'EUR': 0.000059,  // Rupiah to EUR
    'JPY': 0.0088,    // Rupiah to JPY
    'AUD': 0.0001,    // Rupiah to AUD
    'CAD': 0.00009,   // Rupiah to CAD
    'GBP': 0.00005,   // Rupiah to GBP
    'SGD': 0.00009,   // Rupiah to SGD
    'CNY': 0.00047,   // Rupiah to CNY
  };

  // Fungsi untuk mengonversi mata uang
  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text); // Parsing input amount
    if (amount != null && _selectedInputCurrency != null && _selectedOutputCurrency != null) {
      // Menghitung nilai dalam Rupiah
      double amountInRupiah = amount / _exchangeRates[_selectedInputCurrency]!;

      // Menghitung hasil konversi ke mata uang yang dipilih
      setState(() {
        _conversionResult = amountInRupiah * _exchangeRates[_selectedOutputCurrency]!;
      });
    } else {
      // Jika input tidak valid, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a valid amount and select currencies.'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _conversionResult = 0.0; // Reset hasil konversi jika input tidak valid
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input untuk memasukkan jumlah uang yang akan dikonversi
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // Hanya menerima input angka
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih mata uang input
            DropdownButtonFormField<String>(
              value: _selectedInputCurrency,
              hint: const Text('Select Input Currency'),
              items: _exchangeRates.keys.map((String currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedInputCurrency = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Dropdown untuk memilih mata uang output
            DropdownButtonFormField<String>(
              value: _selectedOutputCurrency,
              hint: const Text('Select Output Currency'),
              items: _exchangeRates.keys.map((String currency) {
                return DropdownMenuItem(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedOutputCurrency = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Tombol untuk melakukan konversi
            ElevatedButton(
              onPressed: _convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),

            // Menampilkan hasil konversi
            Text(
              'Converted Amount: ${_conversionResult.toStringAsFixed(2)} ${_selectedOutputCurrency ?? ''}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}