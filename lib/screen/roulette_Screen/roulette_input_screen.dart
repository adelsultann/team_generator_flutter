import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:team_generator/providers/roulette_provider.dart';
import 'package:team_generator/screen/roulette_Screen/roulette_wheel_screen.dart';

class RouletteInputScreen extends ConsumerStatefulWidget {
  const RouletteInputScreen({Key? key}) : super(key: key);

  @override
  _RouletteInputScreenState createState() => _RouletteInputScreenState();
}

class _RouletteInputScreenState extends ConsumerState<RouletteInputScreen> {
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 60), // Add space for the back button
              Expanded(
                child: ListView.builder(
                  itemCount: _controllers.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _controllers.length) {
                      return ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Add Name'),
                        onTap: () {
                          setState(() {
                            _controllers.add(TextEditingController());
                          });
                        },
                      );
                    }
                    return ListTile(
                      leading: Text(
                        '${index + 1}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 254, 251, 251),
                            fontSize: 15),
                      ),
                      title: TextField(
                        controller: _controllers[index],
                        decoration: const InputDecoration(
                          hintText: 'Enter name',
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete,
                            color: Color.fromARGB(255, 233, 136, 11)),
                        onPressed: () {
                          setState(() {
                            _controllers.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
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
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final names = _controllers
              .map((c) => c.text.trim())
              .where((name) => name.isNotEmpty)
              .toList();
          ref.read(rouletteProvider.notifier).setNames(names);
          ref.read(rouletteProvider.notifier).setResultName('');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RouletteWheelScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.refresh_outlined, color: Colors.white),
        ),
      ),
    );
  }
}
