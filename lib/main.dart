import 'package:flutter/material.dart';
import 'package:flutter_dc/login.dart';
import 'package:flutter_dc/mainPage.dart';
import 'package:flutter_dc/provider/HomeProvider.dart';
import 'package:flutter_dc/provider/WebsProvider.dart';
import 'package:flutter_dc/setting.dart';
import 'package:flutter_dc/web.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
        ChangeNotifierProvider<WebsProvider>.value(value: WebsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              elevation: 0),
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => FutureBuilder<String>(
                future: _getUser(),
                builder: (BuildContext context,
                    AsyncSnapshot<String> sharedPreferences) {
                  if (sharedPreferences.connectionState ==
                      ConnectionState.done) {}
                  if (sharedPreferences.data.toString().isEmpty) {
                    return LoginPage();
                  } else {
                    return MyHomePage();
                  }
                },
              ),
          "/login": (context) => LoginPage(),
          "/setting": (context) => SettingPage(),
          "/web": (context) => WebPage(
                id: Provider.of<HomeProvider>(context).productId,
              ),
        },
      ),
    );
  }

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<String> _getUser() async {
    final SharedPreferences prefs = await _prefs;
    final String num = (prefs.getString('userId') ?? "");
    return num;
  }
}
