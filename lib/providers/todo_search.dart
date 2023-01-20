import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

class TodoSearchState extends Equatable {
  final String searchString;
  TodoSearchState({
    required this.searchString,
  });

  factory TodoSearchState.initital() {
    return TodoSearchState(searchString: '');
  }

  @override
  List<Object> get props => [searchString];

  @override
  String toString() => 'TodoSearchState(searchString: $searchString)';

  TodoSearchState copyWith({
    String? searchString,
  }) {
    return TodoSearchState(
      searchString: searchString ?? this.searchString,
    );
  }
}

class TodoSearch extends StateNotifier<TodoSearchState> {
  TodoSearch() : super(TodoSearchState.initital());

  void change(String newSearchString) {
    state = state.copyWith(searchString: newSearchString);
  }
}
