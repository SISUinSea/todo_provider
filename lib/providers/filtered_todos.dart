// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:todo_provider/providers/todo_filter.dart';
import 'package:todo_provider/providers/todo_search.dart';

import '../models/todo_model.dart';
import 'todo_list.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilteredTodosState({
    required this.filteredTodos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(filteredTodos: []);
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [filteredTodos];

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos {
  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;
  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  // FilteredTodosState get state => FilteredTodosState(
  //         filteredTodos: todoList.state.todos.where(
  //       (todo) {
  //         return (todo.completed == todoFilter.state.filter) &&
  //                 todoSearch.state.searchTerm.trim().isNotEmpty
  //             ? true
  //             : todo.desc.toLowerCase().contains(todoSearch.state.searchTerm);
  //       },
  //     ).toList());

  FilteredTodosState get state {
    List<Todo> _filteredTodos;
    switch (todoFilter.state.filter) {
      case Filter.active:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos =
            todoList.state.todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoList.state.todos;
        break;
    }
    if (todoSearch.state.searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where(
            (element) => element.desc
                .toLowerCase()
                .contains(todoSearch.state.searchTerm),
          )
          .toList();
    }
    return FilteredTodosState(filteredTodos: _filteredTodos);
  }
}
