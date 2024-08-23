import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/screen/password_screen/password_result_screen.dart';

class PasswordInputScreen extends ConsumerStatefulWidget {
  const PasswordInputScreen({super.key});

  @override
  _PasswordInputScreenState createState() => _PasswordInputScreenState();
}

class _PasswordInputScreenState extends ConsumerState<PasswordInputScreen> {
  int passwordLength = 8;
  bool useCapitalLetters = true;
  bool useSmallLetters = true;
  bool useNumbers = true;
  bool useSpecialChars = false;

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password Length',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.white),
                            onPressed: () {
                              if (passwordLength > 4) {
                                setState(() => passwordLength--);
                              }
                            },
                          ),
                          Text('$passwordLength',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24)),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              setState(() => passwordLength++);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildSwitch('Capital Letters', useCapitalLetters,
                          (value) => setState(() => useCapitalLetters = value)),
                      _buildSwitch('Small Letters', useSmallLetters,
                          (value) => setState(() => useSmallLetters = value)),
                      _buildSwitch('Numbers', useNumbers,
                          (value) => setState(() => useNumbers = value)),
                      _buildSwitch('Special Chars', useSpecialChars,
                          (value) => setState(() => useSpecialChars = value)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to result screen and generate password
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordResultScreen(
                          length: passwordLength,
                          useCapitalLetters: useCapitalLetters,
                          useSmallLetters: useSmallLetters,
                          useNumbers: useNumbers,
                          useSpecialChars: useSpecialChars,
                        ),
                      ),
                    );
                  },
                  child: const Text('Generate', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.orange,
        ),
      ],
    );
  }
}
