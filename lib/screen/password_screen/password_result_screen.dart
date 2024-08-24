import 'package:flutter/material.dart';
import 'dart:math';

class PasswordResultScreen extends StatelessWidget {
  final int length;
  final bool useCapitalLetters;
  final bool useSmallLetters;
  final bool useNumbers;
  final bool useSpecialChars;

  const PasswordResultScreen({
    super.key,
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
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  'Generated Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    password,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement copy to clipboard functionality
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Copy to Clipboard',
                      style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
