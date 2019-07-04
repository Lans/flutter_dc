import 'package:flutter/material.dart';
import 'package:flutter_dc/provider/WebsProvider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'bean/web_bean.dart';

class WebPage extends StatelessWidget {
  final int id;

  const WebPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final websProvider = Provider.of<WebsProvider>(context);
    websProvider.getUrl(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "web",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<WebBean>(
          stream: websProvider.webBeanStream,
          builder: (_, AsyncSnapshot<WebBean> snapshot) {
            if (snapshot.hasError) {
              return Text("无法加载此地址");
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final webBean = snapshot.data;
                return WebView(
                  initialUrl: webBean.data.url,
                );
            }
            return Center(child: Text("产品不存在"));
          }),
    );
  }
}
