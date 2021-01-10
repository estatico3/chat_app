import 'package:chat_app/base_bloc.dart';
import 'package:flutter/material.dart';

abstract class BasePage<Bloc extends BaseBloc> extends StatefulWidget {
  final Bloc bloc;

  const BasePage({Key key, this.bloc}) : super(key: key);
}

abstract class BasePageState<Page extends BasePage> extends State<Page> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
