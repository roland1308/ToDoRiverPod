import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/constants.dart';
import '../constants/providers/state.dart';
import '../models/todo_model.dart';
import '../repository/todos_repository.dart';
import '../widgets/error_db_widget.dart';
import '../widgets/list_of_todos.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log("BUILD PAGE");
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do - RiverPod"),
      ),
      floatingActionButton: FloatingActionButton(
          key: const Key("addButton"),
          onPressed: () async {
            addNewComment(context, ref);
          },
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const ListOfToDos(),
    );
  }

  Future<void> addNewComment(BuildContext context, WidgetRef ref) async {
    final TextEditingController textEditingController =
        TextEditingController(text: "");
    final navigator = Navigator.of(context);
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
              onPressed: () async {
                if (textEditingController.text != "") {
                  final toDo = <String, dynamic>{
                    "comment": textEditingController.text,
                    "toDoId": DateTime.now().millisecondsSinceEpoch,
                  };
                  bool addResult = await kRepository().addTodo(toDo);
                  if (addResult) {
                    List<ToDo> newList =
                        List.from(ref.read(toDosProvider.notifier).state);
                    newList.add(ToDo.fromJson(toDo));
                    ref.read(toDosProvider.notifier).state = newList;
                    navigator.pop();
                  } else {
                    const ErrorDBWidget(
                        "An error occurred while adding To Do, please retry.");
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
