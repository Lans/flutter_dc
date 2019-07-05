import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'bean/web_bean.dart';
import 'http/ApiUrl.dart';

class WebPage extends StatefulWidget {
  final int id;

  const WebPage({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WebPageState(id: id);
  }
}

class WebPageState extends State<WebPage> {
  final int id;
  Future<SharedPreferences> sp = SharedPreferences.getInstance();

  Future<WebBean> webBeanFuture;

  WebPageState({Key key, @required this.id});

  Future<WebBean> getUrl() async {
    var userId = "";
    WebBean webBean;
    await sp.then((sp) {
      userId = sp.getString("userId");
    });
    await ApiUrl.instance.webHttp(id, userId).then((res) {
      webBean = WebBean.fromJson(res.data);
    });
    return webBean;
  }

  @override
  void initState() {
    super.initState();
    webBeanFuture = getUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          "产品详情",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        elevation: 10,
      ),
      body: FutureBuilder<WebBean>(
          future: webBeanFuture,
          builder: (_, AsyncSnapshot<WebBean> snapshot) {
            if (snapshot.hasError) {
              return AutoSizeText("无法加载此地址");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                var webBean = snapshot.data;
                if (webBean.status == 1) {
                  if (webBean.data.url.startsWith("http://")) {
                    return WebView(
                      debuggingEnabled: true,
                      initialUrl: webBean.data.url,

                    );
                  } else {
                    return Center(child: AutoSizeText("地址有误"));
                  }
                } else {
                  return Center(child: AutoSizeText(webBean.msg));
                }
                break;
            }
            return Center(child: AutoSizeText("产品不存在"));
          }),
    );
  }
}
