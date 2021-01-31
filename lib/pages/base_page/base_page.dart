import 'package:chat_app/base_bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key key}) : super(key: key);
}

abstract class BasePageState<Page extends BasePage, Bloc extends BaseBloc> extends State<Page> {
  Bloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<Bloc>(context, listen: false);
  }

  @override
  void dispose() async {
     bloc.dispose();
    super.dispose();
  }
}
