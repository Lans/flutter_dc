import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'bean/TabBean.dart';
import 'bean/home_bean.dart';
import 'http/ApiUrl.dart';
import 'provider/FindProvider.dart';
import 'provider/ProductIdProvider.dart';

class FindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FindWidget(),
    );
  }
}

class FindWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindWidgetState();
  }
}

class FindWidgetState extends State<FindWidget> {
  TabController tabController;
  var tabs = [
    new TabBean("小额秒贷", 1, 3),
    new TabBean("大额畅享", 0, 3),
    new TabBean("信用卡", 0, 4)
  ];

  Future<HomeBean> productsFuture;

  Future<HomeBean> getCategory(List<TabBean> tabList) async {
    var homeBean;
    var categoryId;
    tabList.forEach((tab) {
      if (tab.index == 1) {
        categoryId = tab.categoryId;
      }
    });
    await ApiUrl.instance.findHttp(categoryId).then((res) {
      homeBean = HomeBean.fromJson(res.data);
    });
    return homeBean;
  }

  @override
  void initState() {
    super.initState();
    productsFuture = getCategory(tabs);
    tabController = TabController(length: 3, vsync: ScaffoldState())
      ..addListener(() {
        if (tabController.indexIsChanging) {
          var tabs = [
            new TabBean("小额秒贷", 1, 3),
            new TabBean("大额畅享", 0, 3),
            new TabBean("信用卡", 0, 4)
          ];
          int length;
          switch (tabController.index) {
            case 0:
              tabs[0].index = 1;
              length = 5;
              break;
            case 1:
              tabs[1].index = 1;
              length = 8;
              break;
            case 2:
              tabs[2].index = 1;
              length = 4;
              break;
            default:
              tabs[0].index = 1;
              length = 0;
              break;
          }
          setState(() {
            this.tabs = tabs;
            productsFuture = getCategory(tabs);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: _SliverAppBarDelegate(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                alignment: Alignment.centerLeft,
                child: new TabBar(
                    tabs: tabs.map((tab) {
                      return buildTab(tab);
                    }).toList(),
                    controller: tabController,
                    indicatorColor: Color.fromRGBO(21, 201, 187, 1),
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black45,
                    indicatorWeight: 2.0,
                    labelStyle: TextStyle(height: 2)),
              ),
            ),
            minHeight: 0,
            maxHeight: 80,
          ),
        ),
        FutureBuilder(
            future: productsFuture,
            builder: (_, AsyncSnapshot<HomeBean> snapshot) {
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: AutoSizeText("请求失败"),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return SliverToBoxAdapter(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  final home = snapshot.data;
                  final findProvider = Provider.of<FindProvider>(context);
                  findProvider.transformerData(home);
                  return SliverPadding(
                    padding: const EdgeInsets.all(5.0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        findProvider.getProduct(index);
                        return GridViewLayout();
                      }, childCount: home.data.product.length),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio: 2),
                    ),
                  );
              }
              return SliverToBoxAdapter(child: AutoSizeText("empty"));
            }),
      ],
    );
  }

  Widget buildTab(TabBean tab) {
    if (tab.index == 1) {
      return AutoSizeText(
        tab.text,
        style: TextStyle(fontSize: 18),
      );
    } else {
      return AutoSizeText(
        tab.text,
        style: TextStyle(fontSize: 15),
      );
    }
  }
}

class GridViewLayout extends StatefulWidget {
  _GridViewLayoutState createState() => _GridViewLayoutState();
}

class _GridViewLayoutState extends State<GridViewLayout> {
  @override
  Widget build(BuildContext context) {
    final findProvider = Provider.of<FindProvider>(context);
    final productIdProvider = Provider.of<ProductIdProvider>(context);

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      color: Colors.white,
      child: new Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Image.network(
                  findProvider.product.pic,
                  fit: BoxFit.fill,
                  width: 50,
                  height: 50,
                ),
              ),
              new AutoSizeText(
                "申请人数:${findProvider.product.applyNums}",
                style: TextStyle(color: Colors.black26, fontSize: 12),
              ),
            ],
          ),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(findProvider.product.name,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14)),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: AutoSizeText(
                              "${findProvider.product.borrowingBalanceMin}~${findProvider.product.borrowingBalanceMax}元",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    margin: EdgeInsets.only(bottom: 5),
                    child: FlatButton(
                        textColor: Colors.white,
                        color: Color.fromRGBO(21, 201, 187, 1),
                        child: AutoSizeText(
                          "立即申请",
                          style: TextStyle(fontSize: 12),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        onPressed: () {
                          productIdProvider
                              .setId(findProvider.product.productId);
                          Navigator.pushNamed(context, "/web");
                        }),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
