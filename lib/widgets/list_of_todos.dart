import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/provider.dart';
import 'todo_single_item.dart';

class ListOfToDos extends ConsumerWidget {
  const ListOfToDos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("BUILD LIST");
    final toDos = ref.watch(todosProvider);
    return ListView.builder(
      itemCount: toDos.length,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (_, index) {
        return Card(
          child: ToDoSingleItem(
            toDo: toDos[index],
          ),
        );
      },
    );
  }
}
