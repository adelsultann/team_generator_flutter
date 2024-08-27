import 'package:flutter/material.dart';
import 'package:lazy_image/lazy_image.dart';

class MainItem extends StatelessWidget {
  final String Function(BuildContext) textBuilder;
  // final String text;
  final String imagePath;
  final Gradient gradient;
  final VoidCallback onTap;

  const MainItem({
    super.key,
    //for languages
    required this.textBuilder,
    // required this.text,
    required this.imagePath,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Set width to take up all horizontal space
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 1, 6, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                textBuilder(context),
                style: const TextStyle(color: Colors.white, fontSize: 30),
              ),
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
