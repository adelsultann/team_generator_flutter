import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team_generator/providers/randomNumbers_provider.dart';

class NumberResult extends ConsumerWidget {
  const NumberResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultState = ref.watch(ranomNumberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Number Result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generated Numbers:',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: resultState.resultList.isEmpty
                  ? const Center(child: Text('No numbers generated yet.'))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: resultState.resultList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 9, 65, 110),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${resultState.resultList[index]}',
                              // style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              'Range: ${resultState.minimumNumber} - ${resultState.maxmumNumber}',
            ),
            Text(
              'Total Numbers: ${resultState.resultList.length}',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(ranomNumberProvider.notifier).generateRandomResult();
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Generate New Numbers',
      ),
    );
  }
}
