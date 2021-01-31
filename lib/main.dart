import 'package:chat_app/localization/app_localization.dart';
import 'package:chat_app/localization/localization_manager.dart';
import 'package:chat_app/pages/login_page/bloc/authorization_service.dart';
import 'package:chat_app/pages/login_page/bloc/login_bloc.dart';
import 'package:chat_app/pages/login_page/login_page.dart';
import 'package:chat_app/pages/login_page/model/login_state.dart';
import 'package:chat_app/pages/sign_up_page/bloc/sign_up_page_bloc.dart';
import 'package:chat_app/pages/sign_up_page/model/sign_up_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    localizationManager: AppLocalizationManager(),
    authorizationService: AuthorizationService(),
  ));
}

class MyApp extends StatelessWidget {
  final LocalizationManager localizationManager;
  final AuthorizationServiceProtocol authorizationService;

  const MyApp({Key key, this.localizationManager, this.authorizationService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      initialData: localizationManager.currentAppLocale,
      stream: localizationManager.getLocaleStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoading();
        }
        return snapshot.hasData ? buildMaterialApp(snapshot) : buildLoading();
      },
    );
  }

  Widget buildLoading() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.white,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget buildMaterialApp(AsyncSnapshot<Locale> snapshot) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginPageBloc(LoginPageDefaultState(), authorizationService),
        ),
        BlocProvider(
          create: (context) =>
              SignUpPageBloc(SignUpPageDefaultState(), authorizationService),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          locale: snapshot.data,
          supportedLocales: localizationManager.supportedLocales,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (deviceLocale.languageCode == supportedLocale.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginPage()),
    );
  }
}
