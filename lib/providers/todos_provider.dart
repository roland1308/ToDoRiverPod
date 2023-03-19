
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo_model.dart';

final todosProvider = StateProvider((ref) => <ToDo>[]);