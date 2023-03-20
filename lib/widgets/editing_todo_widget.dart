import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_model.dart';
import '../providers/provider.dart';

class EditingToDo extends ConsumerWidget {
  EditingToDo({Key? key, required this.toDo}) : super(key: key);

  final ToDo toDo;
  final TextEditingController _textEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _textEditingController.text = toDo.comment;
    return ListTile(
      key: const Key("editTile"),
      leading: const CircleAvatar(
        backgroundColor: Colors.red,
        child: Icon(Icons.edit),
      ),
      title: TextField(
        autofocus: true,
        controller: _textEditingController,
        decoration: const InputDecoration(hintText: 'Type your comment'),
      ),
      trailing: IconButton(
        onPressed: () {
          if (_textEditingController.text != "") {
            List<ToDo> newList =
                List.from(ref.read(todosProvider.notifier).state);
            newList[newList
                        .indexWhere((element) => element.toDoId == toDo.toDoId)]
                    .comment =
                _textEditingController.text;
            ref.read(todosProvider.notifier).state = newList;
            ref.read(isEditingProvider.notifier).state = false;
          }
        },
        icon: const Icon(
          Icons.send_and_archive,
          color: Colors.green,
        ),
      ),
    );
  }
}
