import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/mesajlasma.dart';
import 'sayfalar/ana_menu(hasta).dart';
import 'sayfalar/profil_sayfasi.dart';

/* BottomNavigationBar enAltBar(BuildContext context) {
  return BottomNavigationBar(
    onTap: (value) async {
      if (value == Sayfalar.menu.index) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HastaPaneli()));
      } else if (value == Sayfalar.profil.index) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProfilPage()));
      }
    },
    backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    selectedItemColor:
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
    unselectedItemColor:
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
    iconSize: 30,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "ana menü",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "profil",
      ),
    ],
  );
} */

class enAltBar extends StatefulWidget {
  const enAltBar({Key? key}) : super(key: key);

  @override
  State<enAltBar> createState() => _enAltBarState();
}

class _enAltBarState extends State<enAltBar> with TickerProviderStateMixin {
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
        body: TabBarView(
            controller: _tabController,
            children: [HastaPaneli(), Gorevler(), Mesajlasma(), ProfilPage()]),
      ),
    );
  }
}

enum _MyTabViews { Ana_Menu, Gorevler, Mesajlar, Profil_Sayfasi }

AppBar ustBar(
    {required BuildContext context,
    required String textYazisi,
    List<Widget>? aksiyon}) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.shadowColor,
    title: Center(
      child: Text(
        textYazisi,
        textAlign: TextAlign.center,
      ),
    ),
    actions: aksiyon,
  );
}
