import 'package:flutter/cupertino.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart';

// Main Screen
class NavigationBarHasta extends StatefulWidget {
  @override
  _NavigationBarHastaState createState() => _NavigationBarHastaState();
}

class _NavigationBarHastaState extends State<NavigationBarHasta> {
  final List<Widget> _tabs = const [HastaPaneli(), Gorevler(), ProfilPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.text_badge_checkmark)),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person))
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
    );
  }
}
