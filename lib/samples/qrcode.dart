import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: QRCodeGeneratorScreen(qrData: "Your QR Code Data Here"),
  ));
}

class QRCodeGeneratorScreen extends StatelessWidget {
  final String qrData; // The data for the QR code

  QRCodeGeneratorScreen({required this.qrData});

  final Map<String, dynamic> jsonData = {
  'name': 'John Doe',
  'age': 30,
  'location': 'New York',
};

final jsonString = jsonEncode(jsonData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 50),
        QrImageView(data: 'data',size: 250,)]),
        );
   }
}
