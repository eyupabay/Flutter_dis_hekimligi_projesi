import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/ana_menu(doktor).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/mesajlasma.dart';
import "package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart";

class EnAltBarDoktor extends StatefulWidget {
  const EnAltBarDoktor({Key? key}) : super(key: key);

  @override
  State<EnAltBarDoktor> createState() => _EnAltBarDoktorState();
}

class _EnAltBarDoktorState extends State<EnAltBarDoktor>
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
        extendBody: true,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 7,
          child: TabBar(
              splashBorderRadius: BorderRadius.circular(20),
              padding: EdgeInsets.zero,
              onTap: (int index) {},
              controller: _tabController,
              indicatorColor: Colors.green,
              tabs: _MyTabViews.values.map((e) => Tab(text: e.name)).toList()),
        ),
        body: TabBarView(
            controller: _tabController,
            children: const [DoktorPanel(), ProfilPage()]),
      ),
    );
  }
}

enum _MyTabViews { Menu, Profil }
