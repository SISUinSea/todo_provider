import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_provider_sisu/models/todo.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  TodoListState({
    required this.todos,
  });

  factory TodoListState.initital() {
    return TodoListState(todos: [
      Todo(id: '1', descripton: 'Clean my room'),
      Todo(id: '2', descripton: 'Clean cat toilet'),
      Todo(id: '3', descripton: 'Eat Breakfast'),
    ]);
  }
  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: $todos)';

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}

class TodoList extends StateNotifier<TodoListState> {
  TodoList() : super(TodoListState.initital());

  void addTodo(String newDescription) {
    Todo newTodo = Todo(descripton: newDescription);
    state = state.copyWith(todos: [...state.todos, newTodo]);
  }

  void editTodo(String id, String newDescription) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
            id: id, descripton: newDescription, completed: todo.completed);
      }
      return todo;
    }).toList();

    state = state.copyWith(todos: newTodos);
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(
            id: id, descripton: todo.descripton, completed: !todo.completed);
      }
      return todo;
    }).toList();
    state = state.copyWith(todos: newTodos);
  }

  void deleteTodo(String id) {
    final newTodos = state.todos.where((element) => element.id != id).toList();
    state = state.copyWith(todos: newTodos);
    // state.todos.where(
    //   (element) => element.id != id,
    // );
  }
}
