import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dc/Utils/Strings.dart';
import 'package:flutter_dc/http/ApiUrl.dart';
import 'package:multiple_dialog/multiple_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'bean/login_bean.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String telStr = "13800000000";
  String codeStr = "123456";
  Timer _timer;

  //倒计时数值
  var countdownTime = 0;

  //倒计时方法
  startCountdown() {
    countdownTime = 60;
    final call = (timer) {
      setState(() {
        if (countdownTime < 1) {
          _timer.cancel();
        } else {
          countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  String handleCodeAutoSizeText() {
    if (countdownTime > 0) {
      return "${countdownTime}s后重新获取";
    } else
      return "获取验证码";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Image.asset(
              "asset/ic_launcher.png",
              width: 80,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "请输入手机号",
                    ),
                    autofocus: true,
                    maxLength: 11,
                    onChanged: (tel) {
                      telStr = tel;
                    },
                    controller: TextEditingController(text: "13800000000"),
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "请输入验证码",
                        ),
                        maxLength: 6,
                        onChanged: (code) {
                          codeStr = code;
                        },
                        controller: TextEditingController(text: "123456"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            if (countdownTime == 0) {
                              startCountdown();
                            }
                          },
                          child: AutoSizeText(
                            handleCodeAutoSizeText(),
                            style: TextStyle(
                                color: Color.fromRGBO(21, 201, 187, 1)),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: MaterialButton(
                textColor: Colors.white,
                minWidth: window.physicalSize.width,
                color: Color.fromRGBO(21, 201, 187, 1),
                child: AutoSizeText(
                  "登录",
                  style: TextStyle(fontSize: 13),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                onPressed: () {
                  login(telStr, codeStr);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void login(String telStr, String codeStr) {
    if (telStr.isEmpty) {
      Toast.show("手机号不能为空", context, gravity: Toast.CENTER);
      return;
    }
    if (codeStr.isEmpty) {
      Toast.show("验证码不能为空", context, gravity: Toast.CENTER);
      return;
    }
    loginHttp();
    showLoadingDialog(context: context, barrierDismissible: true);
  }

  //参数获取
  loginHttp() async {
    String ver = "";
    String model = "";
    String id = "";
    PackageInfo.fromPlatform()
        .then((packageInfo) => {
              ver = packageInfo.version,
            })
        .whenComplete(() {
      var device = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        device.androidInfo
            .then((info) => {model = info.model, id = info.androidId})
            .whenComplete(() {
          http(ver, model, id);
        });
      } else if (Platform.isIOS) {
        device.iosInfo
            .then((info) => {model = info.model, id = info.identifierForVendor})
            .whenComplete(() {
          http(ver, model, id);
        });
      }
    });
  }

//真正的请求
  http(String ver, String model, String id) {
    ApiUrl().loginHttp(telStr, codeStr, ver, model, id).then((res) {
      var loginBean = LoginBean.fromJson(res.data);
      if (loginBean.code == 1000) {
        Navigator.pop(context);
        Toast.show(Strings.loginSuccess, context);
        SharedPreferences.getInstance()
          .then((sp) {
            sp.setString("userId", loginBean.data.userId.toString());
            sp.setString("userTel", loginBean.data.phone.toString());
          }).whenComplete(() {
            Navigator.pushNamed(context, "/");
          });
      } else {
        Navigator.pop(context);
        Toast.show(loginBean.msg, context);
      }
    }).catchError((e) {
      print(Strings.errorMsg + e.toString());
      Navigator.pop(context);
    });
  }
}
