import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/signUp_doktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/signUp_hasta.dart';

class SignUpTabBar extends StatefulWidget {
  const SignUpTabBar({Key? key}) : super(key: key);

  @override
  State<SignUpTabBar> createState() => _LoginTabBarState();
}

class _LoginTabBarState extends State<SignUpTabBar>
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
          backgroundColor: Colors.teal[300],
          toolbarHeight: 10,
          bottom: TabBar(
              splashBorderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.zero,
              onTap: (int index) {},
              controller: _tabController,
              indicatorColor: Color(0xff00796B),
              tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList()),
        ),
        body: TabBarView(
            controller: _tabController,
            children: const [SignUpHasta(), SignUpDoktor()]),
      ),
    );
  }
}

enum _MyTabViews { Hasta, Doktor }
