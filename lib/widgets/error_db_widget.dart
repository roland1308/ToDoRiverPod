import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/constants/constants.dart';

import '../constants/providers/state.dart';

class ErrorDBWidget extends ConsumerWidget {
  const ErrorDBWidget(this.message, {Key? key}) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  ref.read(toDosDBProvider.notifier).state = kRepository();
                },
                child: const Text("Reload")),
          ],
        ),
      ),
    );
  }
}
