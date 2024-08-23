import 'package:flutter/material.dart';
import 'dart:math';

class PasswordResultScreen extends StatelessWidget {
  final int length;
  final bool useCapitalLetters;
  final bool useSmallLetters;
  final bool useNumbers;
  final bool useSpecialChars;

  PasswordResultScreen({
    required this.length,
    required this.useCapitalLetters,
    required this.useSmallLetters,
    required this.useNumbers,
    required this.useSpecialChars,
  });

  String generatePassword() {
    String chars = '';
    if (useCapitalLetters) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (useSmallLetters) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (useNumbers) chars += '0123456789';
    if (useSpecialChars) chars += '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    return List.generate(
        length, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    final password = generatePassword();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Generated Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    password,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement copy to clipboard functionality
                  },
                  child:
                      Text('Copy to Clipboard', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
