import 'package:flutter/material.dart';

class LoginPageEvent {}

class LoginActionEvent extends LoginPageEvent {
  final String email;
  final String password;

  LoginActionEvent(this.email, this.password);
}

class ShowSignUpPageActionEvent extends LoginPageEvent {
  final BuildContext context;

  ShowSignUpPageActionEvent(this.context);
}