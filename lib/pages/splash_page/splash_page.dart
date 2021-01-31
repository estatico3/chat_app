import 'package:chat_app/pages/base_page/base_page.dart';
import 'package:chat_app/pages/splash_page/logic/splash_page_bloc.dart';
import 'package:flutter/material.dart';

class SplashPage<SplashPageBloc> extends BasePage {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends BasePageState<SplashPage, SplashPageBloc> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
