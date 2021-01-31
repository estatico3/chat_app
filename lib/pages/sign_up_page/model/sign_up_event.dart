import 'package:flutter/cupertino.dart';

class SignUpPageEvent {}

class SignUpActionEvent extends SignUpPageEvent {
  final String email;
  final String password;

  SignUpActionEvent(this.email, this.password);
}

class ShowLoginPageEvent extends SignUpPageEvent {
  final BuildContext context;

  ShowLoginPageEvent(this.context);
}