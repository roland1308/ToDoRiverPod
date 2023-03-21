import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/providers/state.dart';
import 'todo_single_item.dart';

class ListOfToDos extends ConsumerWidget {
  const ListOfToDos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("BUILD LIST");
    final nrOfTodos = ref.watch(toDosProvider.select((toDos) => toDos.length));
    return ListView.builder(
      itemCount: nrOfTodos,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (_, index) {
        return Card(
          child: ToDoSingleItem(
            index: index,
          ),
        );
      },
    );
  }
}
