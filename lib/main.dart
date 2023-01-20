import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_sisu/pages/home_page.dart';
import 'package:todo_provider_sisu/providers/active_todo_count.dart';
import 'package:todo_provider_sisu/providers/filtered_todo.dart';
import 'package:todo_provider_sisu/providers/todo_filter.dart';
import 'package:todo_provider_sisu/providers/todo_list.dart';
import 'package:todo_provider_sisu/providers/todo_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoList, TodoListState>(
          create: (context) => TodoList(),
        ),
        StateNotifierProvider<TodoFilter, Filter>(
          create: (context) => TodoFilter(),
        ),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
          create: (context) => TodoSearch(),
        ),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
          create: (context) => ActiveTodoCount(),
        ),
        StateNotifierProvider<FilteredTodos, FilteredTodosState>(
          create: (context) => FilteredTodos(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TodoApp',
        home: HomePage(),
      ),
    );
  }
}
