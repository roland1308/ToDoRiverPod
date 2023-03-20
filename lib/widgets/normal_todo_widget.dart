import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/todo_model.dart';
import '../providers/state.dart';

class NormalToDo extends HookConsumerWidget {
  const NormalToDo({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDo = ref.read(todosProvider)[index];

    final animationController = useAnimationController(
      initialValue: 1,
      duration: const Duration(milliseconds: 500),
    );

    useAnimation(animationController);

    useEffect(() {
      if (animationController.isDismissed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          List<ToDo> newList =
              List.from(ref.read(todosProvider.notifier).state);
          newList.removeAt(index);
          ref.read(todosProvider.notifier).state = newList;
          animationController.value = 1;
        });
      }
      return null;
    }, [animationController.status]);

    return Opacity(
      opacity: animationController.value,
      child: ListTile(
        onTap: () {
          ref.read(isEditingProvider.notifier).state = true;
          ref.read(editingIdProvider.notifier).state = index;
        },
        leading: CircleAvatar(
          child: Text(toDo.comment[0].toUpperCase()),
        ),
        title: Text(toDo.comment),
        trailing: IconButton(
          onPressed: () {
            animationController.reverse();
          },
          icon: const Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
