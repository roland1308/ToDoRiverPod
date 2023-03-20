import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/providers/provider.dart';
import 'package:to_do_riverpod/widgets/editing_todo_widget.dart';
import 'package:to_do_riverpod/widgets/normal_todo_widget.dart';

import '../models/todo_model.dart';

class ToDoSingleItem extends ConsumerWidget {
  const ToDoSingleItem({Key? key, required this.toDo}) : super(key: key);

  final ToDo toDo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingId = ref.watch(editingIdProvider);
    final isEditing = ref.watch(isEditingProvider);
    if (isEditing && editingId == toDo.toDoId) {
      return EditingToDo(toDo: toDo);
    }
    return NormalToDo(toDo: toDo);
  }
}
