import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class TodoSearchState extends Equatable {
  final String searchTerm;
  TodoSearchState({
    required this.searchTerm,
  });
  factory TodoSearchState.initial() {
    return TodoSearchState(searchTerm: '');
  }
  @override
  bool get stringify => true;

  @override
  List<Object> get props => [searchTerm];

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();
  TodoSearchState get state => _state;

  void setSearchTerm(String newSearchTerm) {
    _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
