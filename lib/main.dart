import 'package:chat_app/localization/app_localization.dart';
import 'package:chat_app/localization/localization_manager.dart';
import 'package:chat_app/pages/base_page/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    localizationManager: AppLocalizationManager(),
  ));
}

class MyApp extends StatelessWidget {
  final LocalizationManager localizationManager;

  const MyApp({Key key, this.localizationManager}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Locale>(
      initialData: localizationManager.currentAppLocale,
      stream: localizationManager.getLocaleStream(),
      builder: (context, snapshot) {
        return snapshot.hasData ? buildMaterialApp(snapshot) : buildLoading();
      },
    );
  }

  Container buildLoading() {
    return Container(
        color: Colors.white, child: Center(child: CircularProgressIndicator()));
  }

  MaterialApp buildMaterialApp(AsyncSnapshot<Locale> snapshot) {
    return MaterialApp(
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
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        localizationManager: localizationManager,
      ),
    );
  }
}

 class MyHomePage extends BasePage {
  MyHomePage({Key key, this.title, this.localizationManager}) : super(key: key);
  final LocalizationManager localizationManager;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BasePageState<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    List<Locale> locales = widget.localizationManager.supportedLocales;
    widget.localizationManager.setLocale(locales[_counter % 2]);
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context).localized('hello_world'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
