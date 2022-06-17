import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/mesajlasma.dart';
import "package:flutter_uygulama_deniyorum/sayfalar/ana_menu(hasta).dart";
import "package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart";

class EnAltBar extends StatefulWidget {
  const EnAltBar({Key? key}) : super(key: key);

  @override
  State<EnAltBar> createState() => _EnAltBarState();
}

class _EnAltBarState extends State<EnAltBar> with TickerProviderStateMixin {
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
        /* floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[400],
            onPressed: () {
              _tabController.animateTo(_MyTabViews.Ana_Menu.index);
            },
            child: const Icon(Icons.add)), */
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
        body: TabBarView(controller: _tabController, children: const [
          HastaPaneli(),
          Gorevler(),
          Mesajlasma(),
          ProfilPage()
        ]),
      ),
    );
  }
}

enum _MyTabViews { Ana_Menu, Gorevler, Mesajlar, Profil_Sayfasi }
