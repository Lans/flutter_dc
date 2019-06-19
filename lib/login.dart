import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dc/loadingDialog.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
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

  String handleCodeText() {
    if (countdownTime > 0) {
      return "${countdownTime}s后重新获取";
    } else
      return "获取验证码";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  "asset/ic_launcher.png",
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "请输入手机号",
                        ),
                        autofocus: true,
                        maxLength: 13,
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
                            onChanged: (data) {
                              print("验证码$data");
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onTap: () {
                                if (countdownTime == 0) {
                                  startCountdown();
                                }
                              },
                              child: Text(
                                handleCodeText(),
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
                    child: Text(
                      "登录",
                      style: TextStyle(fontSize: 13),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return LoadingDialog(
                              titleStyle: TextStyle(fontSize: 12),
                            );
                          });
                      ///测试dialog消失
                      Future(() {
                        Future.delayed(Duration(seconds: 3), () {
                          print("dialog消失了");
                          Navigator.pop(context);
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
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
}
