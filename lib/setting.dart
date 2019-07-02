import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "设置",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: true,
        brightness: Brightness.light,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("版本"),
                    ),
                    FutureBuilder<PackageInfo>(
                      future: PackageInfo.fromPlatform(),
                      builder: (BuildContext context,
                          AsyncSnapshot<PackageInfo> packageInfo) {
                        switch (packageInfo.connectionState) {
                          case ConnectionState.none:
                            return Text('Press button to start.');
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Text('Awaiting result...');
                          case ConnectionState.done:
                            if (packageInfo.hasError)
                              return Text('Error: ${packageInfo.error}');
                            return Text('v${packageInfo.data.version}');
                        }
                        return Text("获取不到"); // unreachable
                      },
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  textColor: Colors.white,
                  minWidth: window.physicalSize.width,
                  color: Color.fromRGBO(21, 201, 187, 1),
                  child: Text(
                    "退出",
                    style: TextStyle(fontSize: 13),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)),
                  onPressed: () {
                    SharedPreferences.getInstance().then((sp) {
                      sp.clear();
                    }).whenComplete(() {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (Route<dynamic> route) => false);
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
