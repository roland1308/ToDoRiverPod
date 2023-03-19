import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_model.dart';
import '../providers/todos_provider.dart';

class ToDoSingleItem extends ConsumerWidget {
  const ToDoSingleItem({Key? key, required this.toDo}) : super(key: key);

  final ToDo toDo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      key: const Key("ToDoWidget"),
      onTap: () {},
      leading: CircleAvatar(
        child: Text(toDo.comment[0].toUpperCase()),
      ),
      title: Text(toDo.comment),
      trailing: IconButton(
        onPressed: () {
            List<ToDo> newList =
            List.from(ref.read(todosProvider.notifier).state);
            newList.remove(toDo);
            ref.read(todosProvider.notifier).state = newList;
        },
        icon: const Icon(
          Icons.remove_circle,
          color: Colors.red,
        ),
      ),
    );
  }
}
