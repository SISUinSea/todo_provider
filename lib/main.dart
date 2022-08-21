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
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(
              initialActiveTodoCount:
                  context.read<TodoList>().state.todos.length),
          update: (BuildContext context, TodoList todoList,
                  ActiveTodoCount? activeTodoCount) =>
              activeTodoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          create: (context) =>
              FilteredTodos(initialTodos: context.read<TodoList>().state.todos),
          update: (BuildContext context,
                  TodoFilter todoFilter,
                  TodoSearch todoSearch,
                  TodoList todoList,
                  FilteredTodos? filteredTodos) =>
              filteredTodos!..update(todoList, todoSearch, todoFilter),
        )
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
