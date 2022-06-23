import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/loginPage_doktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/loginPage_hasta.dart';

class LoginTabBar extends StatefulWidget {
  const LoginTabBar({Key? key}) : super(key: key);

  @override
  State<LoginTabBar> createState() => _LoginTabBarState();
}

class _LoginTabBarState extends State<LoginTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _MyTabViews.values.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _MyTabViews.values.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          bottom: TabBar(
              splashBorderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.zero,
              onTap: (int index) {},
              controller: _tabController,
              indicatorColor: Colors.green,
              tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList()),
        ),
        body: TabBarView(
            controller: _tabController,
            children: const [LoginPageHasta(), LoginPageDoktor()]),
      ),
    );
  }
}

enum _MyTabViews { Hasta, Doktor }
