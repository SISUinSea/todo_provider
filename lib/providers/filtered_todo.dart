import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_provider_sisu/models/todo.dart';
import 'package:todo_provider_sisu/providers/todo_filter.dart';
import 'package:todo_provider_sisu/providers/todo_list.dart';
import 'package:todo_provider_sisu/providers/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilteredTodosState({
    required this.filteredTodos,
  });

  @override
  List<Object> get props => [filteredTodos];

  @override
  String toString() => 'FilteredTodoState(filteredTodos: $filteredTodos)';

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos extends StateNotifier<FilteredTodosState>
    with LocatorMixin {
  FilteredTodos() : super(FilteredTodosState(filteredTodos: []));

  @override
  void update(Locator watch) {
    final todos = watch<TodoListState>().todos;
    final filter = watch<Filter>();
    final searchTerm = watch<TodoSearchState>().searchString;

    List<Todo> _newFilteredTodos;
    switch (filter) {
      case Filter.active:
        _newFilteredTodos =
            todos.where((element) => !element.completed).toList();
        break;
      case Filter.completed:
        _newFilteredTodos =
            todos.where((element) => element.completed).toList();
        break;
      case Filter.all:
        _newFilteredTodos = todos;
        break;
    }
    if (searchTerm.isNotEmpty) {
      _newFilteredTodos = _newFilteredTodos
          .where((element) =>
              element.descripton.toLowerCase().contains(searchTerm))
          .toList();
    }
    state = state.copyWith(filteredTodos: _newFilteredTodos);

    super.update(watch);
  }
}
