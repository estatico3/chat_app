import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  PublishSubject _errorsSubject = PublishSubject();

  BaseBloc(initialState) : super(initialState);

  Stream get errorsStream => _errorsSubject.stream;

  Sink get errorsSing => _errorsSubject.sink;

  Future<void> dispose() async {
    await _errorsSubject.close();
  }
}