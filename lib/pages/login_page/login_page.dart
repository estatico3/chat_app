import 'dart:ui';

import 'package:chat_app/common_widgets/authorization_text_field.dart';
import 'package:chat_app/common_widgets/loading_widget.dart';
import 'package:chat_app/localization/app_localization.dart';
import 'package:chat_app/mixins/error_handler_mixin.dart';
import 'package:chat_app/pages/base_page/base_page.dart';
import 'package:chat_app/pages/login_page/bloc/login_bloc.dart';
import 'package:chat_app/pages/login_page/model/login_event.dart';
import 'package:chat_app/pages/login_page/model/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends BasePage {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginPageBloc> with ErrorHandlerMixin {
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/login_background.jpg"),
                fit: BoxFit.fill)),
        child: SafeArea(
          child: BlocBuilder<LoginPageBloc, LoginPageState>(
              builder: (context, state) {
            if (state is LoginPageLoadingState) {
              return LoadingWidget(
                  isLoading: true, child: buildPageContent(context));
            } else if (state is LoginPageDefaultState) {
              return buildPageContent(context);
            } else {
              return SizedBox();
            }
          }),
        ),
      ),
    );
  }

  Widget buildPageContent(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppLocalization.of(context).localized("lets_chat"),
                style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.white,
                    fontSize: 64,
                    fontFamily: GoogleFonts.lobster().fontFamily),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    AuthorizationTextField(
                        controller: emailController,
                        labelText: "Email",
                        prefixIconData: Icons.person,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please fill this field"
                              : null;
                        }),
                    SizedBox(
                      height: 8.0,
                    ),
                    AuthorizationTextField(
                        controller: passwordController,
                        labelText: "Password",
                        prefixIconData: Icons.lock,
                        keyboardType: TextInputType.text,
                        isObscure: true,
                        validator: (value) {
                          return value.isEmpty
                              ? "Please fill this field"
                              : null;
                        }),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 32),
                      child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            ),
                          ),
                          onPressed: () => bloc.add(LoginActionEvent(
                              emailController.text, passwordController.text))),
                    ),
                    FlatButton(
                      onPressed: () =>
                          bloc.add(ShowSignUpPageActionEvent(context)),
                      child: Text(
                        "Don't have an account? Sign up!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
