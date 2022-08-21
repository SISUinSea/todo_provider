import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/providers.dart';

import './pages/todo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),
        ProxyProvider<TodoList, ActiveTodoCount>(
            update:
                (BuildContext context, TodoList todoList, ActiveTodoCount? _) =>
                    ActiveTodoCount(todos: todoList)),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList, FilteredTodos>(
            update: (BuildContext context,
                    TodoFilter todoFilter,
                    TodoSearch todoSearch,
                    TodoList todoList,
                    FilteredTodos? _) =>
                FilteredTodos(
                    todoFilter: todoFilter,
                    todoSearch: todoSearch,
                    todoList: todoList))
      ],
      child: MaterialApp(
        title: 'TODOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TodosPage(),
      ),
    );
  }
}
