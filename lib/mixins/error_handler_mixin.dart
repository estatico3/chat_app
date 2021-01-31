import 'dart:async';

import 'package:chat_app/base_bloc/base_bloc.dart';
import 'package:chat_app/pages/base_page/base_page.dart';
import 'package:flutter/material.dart';

mixin ErrorHandlerMixin<Page extends BasePage, Bloc extends BaseBloc>
    on BasePageState<Page, Bloc> {
  StreamSubscription errorsSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _listenErrors();
  }

  void _listenErrors() async {
    await errorsSubscription?.cancel();
    errorsSubscription = bloc.errorsStream.listen((event) {
      showErrorDialog(event.toString());
    });
  }

  void showErrorDialog(String error) {
    showDialog(
        context: context,
        builder: (alertContext) {
          return AlertDialog(
            title: Text(error),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(alertContext).pop(),
                  child: Text("OK"))
            ],
          );
        });
  }

  @override
  void dispose() {
    errorsSubscription.cancel();
    super.dispose();
  }
}
