import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:to_do_riverpod/constants/constants.dart';
import 'package:to_do_riverpod/repository/todos_repository.dart';

import '../../models/todo_model.dart';


final toDosDBProvider = StateProvider<ToDosRepository>((ref) => kRepository());
final toDosData = FutureProvider<List<ToDo>>((ref) async {
  return ref.watch(toDosDBProvider).fetchToDos();
});
final toDosProvider = StateProvider((ref) => <ToDo>[]);
final editingIdProvider = StateProvider((ref) => 0);
final isEditingProvider = StateProvider((ref) => false);
