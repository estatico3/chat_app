import 'dart:async';

import 'package:chat_app/base_bloc/base_bloc.dart';
import 'package:chat_app/pages/login_page/bloc/authorization_service.dart';
import 'package:chat_app/pages/login_page/model/login_event.dart';
import 'package:chat_app/pages/login_page/model/login_state.dart';
import 'package:chat_app/pages/sign_up_page/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageBloc extends BaseBloc<LoginPageEvent, LoginPageState> {
  final AuthorizationServiceProtocol _authorizationService;

  LoginPageBloc(initialState, this._authorizationService) : super(initialState);

  @override
  Stream<LoginPageState> mapEventToState(LoginPageEvent event) async* {
    if (event is LoginActionEvent) {
      yield LoginPageLoadingState();
      yield* _handleLoginActionEvent(event);
    } else if (event is ShowSignUpPageActionEvent) {
      _handleShowSignUpPageAction(event);
    }
  }

  Stream<LoginPageState> _handleLoginActionEvent(
      LoginActionEvent event) async* {
    var email = event.email.trim();
    var password = event.password.trim();
    try {
      var userCredentials = await _authorizationService.login(email, password);
      print(userCredentials);
      yield LoginPageDefaultState();

    } on FirebaseAuthException catch (error) {
      errorsSing.add(error.message);
      yield LoginPageDefaultState();
    }
  }

  void _handleShowSignUpPageAction(ShowSignUpPageActionEvent event) {
    Navigator.of(event.context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}
