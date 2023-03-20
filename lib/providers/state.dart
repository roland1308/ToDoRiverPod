

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/todo_model.dart';

final todosProvider = StateProvider((ref) => <ToDo>[]);
final editingIdProvider = StateProvider((ref) => 0);
final isEditingProvider = StateProvider((ref) => false);