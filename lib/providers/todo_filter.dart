// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;
  TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() {
    return TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();
  TodoFilterState get state => _state;

  void changeFilter(Filter newFilter) {
    // print('new filter is ${newFilter}.\ncurrent filter is ${state}');
    _state = _state.copyWith(filter: newFilter);
    print('new filter is ${newFilter}.\ncurrent filter is ${state}');

    notifyListeners();
  }
}
