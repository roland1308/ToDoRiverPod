import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_riverpod/providers/state.dart';
import 'package:to_do_riverpod/widgets/editing_todo_widget.dart';
import 'package:to_do_riverpod/widgets/normal_todo_widget.dart';

class ToDoSingleItem extends ConsumerWidget {
  const ToDoSingleItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingIndex = ref.read(editingIdProvider);
    final isEditing = ref.watch(isEditingProvider);
    if (isEditing && editingIndex == index) {
      return EditingToDo(index: index);
    }
    return NormalToDo(index: index);
  }
}
