import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:roulette/roulette.dart';
import 'package:team_generator/providers/roulette_provider.dart';
import 'package:team_generator/utils/randomcolorsRoulette.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouletteWheelScreen extends ConsumerStatefulWidget {
  const RouletteWheelScreen({super.key});
  @override
  _RouletteWheelScreenState createState() => _RouletteWheelScreenState();
}

class _RouletteWheelScreenState extends ConsumerState<RouletteWheelScreen>
    with SingleTickerProviderStateMixin {
  late RouletteController _controller;
  final Random _random = Random();
  Color? selectedColor;
  late List<Color> segmentColors;

  @override
  void initState() {
    super.initState();
    final names = ref.read(rouletteProvider).names;
    segmentColors =
        List.generate(names.length, (_) => ColorUtils.getRandomColor());

    _controller = RouletteController(
      vsync: this,
      group: RouletteGroup.uniform(
        names.length,
        colorBuilder: (index) => segmentColors[index],
        textBuilder: (index) => names[index].toString(),
        textStyleBuilder: (index) => TextStyle(
          fontFamily:
              'Roboto', // Make sure you've added this font to your project
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.3),
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() async {
    ref.read(rouletteProvider.notifier).setResultName('');
    final names = ref.read(rouletteProvider).names;
    final targetIndex = _random.nextInt(names.length);
    await _controller.rollTo(
      targetIndex,
      offset: Random().nextDouble(),
    );
    ref.read(rouletteProvider.notifier).setResultName(names[targetIndex]);
    setState(() {
      selectedColor = segmentColors[targetIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultName = ref.watch(rouletteProvider).newResultName;
    return Scaffold(
      backgroundColor: selectedColor?.withOpacity(0.3) ??
          const Color.fromARGB(255, 45, 45, 45),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Roulette(
                        controller: _controller,
                        style: const RouletteStyle(
                          dividerColor: Colors.black,
                          centerStickerColor: Colors.black,
                          dividerThickness: 3,
                        ),
                      ),
                      const Icon(
                        FontAwesomeIcons.downLong,
                        size: 25,
                        color: Color.fromARGB(255, 140, 140, 140),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _spinWheel,
                  child: Text(AppLocalizations.of(context)!.spin),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    resultName,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(FontAwesomeIcons.arrowLeft, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
