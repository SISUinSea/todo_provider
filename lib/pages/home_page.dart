// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_provider_sisu/providers/active_todo_count.dart';
import 'package:todo_provider_sisu/providers/filtered_todo.dart';
import 'package:todo_provider_sisu/providers/todo_filter.dart';
import 'package:todo_provider_sisu/providers/todo_list.dart';
import 'package:todo_provider_sisu/providers/todo_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            children: [
              TodoHeader(),
              CreateTodo(),
              SizedBox(height: 10.0),
              SearchAndFilterTodo(),
              SizedBox(height: 10.0),
              ShowTodos(),
            ],
          ),
        )),
      ),
    );
  }
}

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final count = context.watch<ActiveTodoCountState>().activeTodoCount;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Todo",
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          "${count} items left",
          style: TextStyle(fontSize: 30.0, color: Colors.red),
        )
      ],
    );
  }
}

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        if (controller.text.trim().isNotEmpty) {
          context.read<TodoList>().addTodo(value);
          controller.clear();
        }
      },
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search), labelText: 'What to do?'),
    );
  }
}

class SearchAndFilterTodo extends StatefulWidget {
  const SearchAndFilterTodo({Key? key}) : super(key: key);

  @override
  State<SearchAndFilterTodo> createState() => _SearchAndFilterTodoState();
}

class _SearchAndFilterTodoState extends State<SearchAndFilterTodo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            context.read<TodoSearch>().change(value);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(Filter.all),
            filterButton(Filter.active),
            filterButton(Filter.completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(Filter filter) {
    return TextButton(
      child: Text(
        filter.toString().substring(7),
        style: TextStyle(
            fontSize: 18,
            color:
                context.watch<Filter>() == filter ? Colors.blue : Colors.grey),
      ),
      onPressed: () {
        context.read<TodoFilter>().change(filter);
      },
    );
  }
}

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosState>().filteredTodos;
    TextEditingController descriptonController = TextEditingController();
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (_) {
            context.read<TodoList>().deleteTodo(todos[index].id);
          },
          key: ValueKey(todos[index].id),
          child: ListTile(
            onLongPress: () {
              descriptonController.text = todos[index].descripton;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Edit todo'),
                  content: TextField(
                    controller: descriptonController,
                    decoration: InputDecoration(),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Edit'),
                      onPressed: () {
                        context.read<TodoList>().editTodo(
                            todos[index].id, descriptonController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            leading: Checkbox(
                value: todos[index].completed,
                onChanged: (value) {
                  print('checkbox is pressed!');
                  context.read<TodoList>().toggleTodo(todos[index].id);
                }),
            title: Text(todos[index].descripton),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey,
        );
      },
    );
  }
}
