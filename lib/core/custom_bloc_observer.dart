import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('Changed $change');
  }

  @override
  void onClose(BlocBase bloc) {
    print('closed $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    print('created $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('event $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('transition $transition ');
  }
}
