import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/state.dart';

class EditingToDo extends ConsumerWidget {
  EditingToDo({Key? key, required this.index}) : super(key: key);

  final int index;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDo = ref.read(todosProvider)[index];
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
            ref.read(todosProvider.notifier).state[index].comment =
                _textEditingController.text;
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
