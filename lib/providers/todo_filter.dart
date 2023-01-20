import 'package:state_notifier/state_notifier.dart';

enum Filter {
  all,
  active,
  completed,
}

class TodoFilter extends StateNotifier<Filter> {
  TodoFilter() : super(Filter.all);

  void change(Filter newfilter) {
    state = newfilter;
  }
}
