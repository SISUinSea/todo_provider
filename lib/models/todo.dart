import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

Uuid uuid = Uuid();

class Todo extends Equatable {
  final String id;
  final String descripton;
  bool completed;

  Todo({String? id, required this.descripton, this.completed = false})
      : id = id ?? uuid.v4();

  @override
  List<Object> get props => [id, descripton, completed];

  @override
  String toString() =>
      'Todo(id: $id, descripton: $descripton, completed: $completed)';
}
