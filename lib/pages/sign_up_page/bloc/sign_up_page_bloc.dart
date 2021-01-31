import 'package:chat_app/base_bloc/base_bloc.dart';
import 'package:chat_app/pages/login_page/bloc/authorization_service.dart';
import 'package:chat_app/pages/login_page/login_page.dart';
import 'package:chat_app/pages/sign_up_page/model/sign_up_event.dart';
import 'package:chat_app/pages/sign_up_page/model/sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPageBloc extends BaseBloc<SignUpPageEvent, SignUpPageState> {
  final AuthorizationServiceProtocol _authorizationService;

  SignUpPageBloc(initialState, this._authorizationService)
      : super(initialState);

  @override
  Stream<SignUpPageState> mapEventToState(SignUpPageEvent event) async* {
    if (event is SignUpActionEvent) {
      yield SignUpLoadingState();
      yield* _handleSignUpActionEvent(event);
    } else if (event is ShowLoginPageEvent) {
      _handleShowLoginPageAction(event);
    }
  }

  Stream<SignUpPageState> _handleSignUpActionEvent(
      SignUpActionEvent event) async* {
    try {
      var user =
          await _authorizationService.signUp(event.email, event.password);
      print(user);
      yield SignUpPageDefaultState();
    } on FirebaseAuthException catch (error) {
      yield SignUpPageDefaultState();
      errorsSing.add(error.message);
    }
  }

  void _handleShowLoginPageAction(ShowLoginPageEvent event) {
    Navigator.of(event.context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
