import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/widgets/error_db_widget.dart';

import '../constants/constants.dart';
import '../constants/providers/state.dart';

class EditingToDo extends ConsumerWidget {
  EditingToDo({Key? key, required this.index}) : super(key: key);

  final int index;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDo = ref.read(toDosProvider)[index];
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
        onPressed: () async {
          if (_textEditingController.text != "") {
            int toDoId = ref.read(toDosProvider.notifier).state[index].toDoId;
            bool removeResult = await kRepository()
                .updateTodo(toDoId, _textEditingController.text);
            if (removeResult) {
              ref.read(toDosProvider.notifier).state[index].comment =
                  _textEditingController.text;
            } else {
              const ErrorDBWidget(
                  "An error occurred while updating To Do, please retry.");
            }
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
