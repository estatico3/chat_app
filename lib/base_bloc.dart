import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  PublishSubject _errorsSubject = PublishSubject();

  Stream get errorsStream => _errorsSubject.stream;

  Sink get errorsSing => _errorsSubject.sink;

  void dispose() async {
    await _errorsSubject.close();
  }
}