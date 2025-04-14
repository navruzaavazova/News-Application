import 'dart:async';
import 'spider_bloc_base.dart';

typedef EventHandler<E, S> = FutureOr<void> Function(E event, Emitter<S> emit);

class Emitter<S> {
  final SpiderBlocBase<S> _bloc;
  Emitter(this._bloc);

  void call(S state) => _bloc.emit(state);
}

abstract class SpiderBloc<E, S> extends SpiderBlocBase<S> {
  final StreamController<E> _eventController = StreamController<E>.broadcast();
  final Map<Type, EventHandler<dynamic, S>> _handlers = {};

  SpiderBloc(super.initialState) {
    _eventController.stream.listen(_listenEvent);
  }

  void on<T extends E>(EventHandler<T, S> handler) {
    _handlers[T] = (event, emit) => handler(event as T, emit);
  }

  void add(E event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  Future<void> _listenEvent(E event) async {
    final handler = _handlers[event.runtimeType];
    if (handler != null) {
      await handler(event, Emitter<S>(this));
    }
  }

  @override
  Future<void> close() async {
    await _eventController.close();
  }
}