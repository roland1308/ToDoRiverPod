import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/pages/home_page.dart';
import 'package:to_do_riverpod/widgets/error_db_widget.dart';

import 'constants/providers/state.dart';
import 'firebase_options.dart';
import 'models/todo_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(toDosData);
    return MaterialApp(
      title: 'To Do - RiverPod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: data.when(
        data: (List<ToDo> data) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(toDosProvider.notifier).state = data;
          });
          return HomePage();
        },
        error: (error, __) {
          return ErrorDBWidget(error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
