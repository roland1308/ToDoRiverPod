import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/widgets/TodoSingleItem.dart';

import '../models/todo_model.dart';
import '../providers/todos_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDos = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do - RiverPod"),
      ),
      floatingActionButton: FloatingActionButton(
          key: const Key("addButton"),
          onPressed: () => addNewComment(context, ref),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: ListView.builder(
        itemCount: toDos.length,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (_, index) {
          return Card(
            child: ToDoSingleItem(
              toDo: toDos[index],
            ),
          );
        },
      ),
    );
  }

  Future<void> addNewComment(BuildContext context, WidgetRef ref) async {
    final TextEditingController textEditingController =
        TextEditingController(text: "");
    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            autofocus: true,
            controller: textEditingController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (textEditingController.text != "") {
                  List<ToDo> newList =
                      List.from(ref.read(todosProvider.notifier).state);
                  newList.add(ToDo(
                      toDoId: DateTime.now().millisecondsSinceEpoch,
                      comment: textEditingController.text));
                  ref.read(todosProvider.notifier).state = newList;
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
