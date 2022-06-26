import 'package:flutter/cupertino.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/ana_menu(doktor).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart';

// Main Screen
class NavigationBarDoktor extends StatefulWidget {
  @override
  _NavigationBarDoktorState createState() => _NavigationBarDoktorState();
}

class _NavigationBarDoktorState extends State<NavigationBarDoktor> {
  final List<Widget> _tabs = const [DoktorPanel(), ProfilPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person))
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _tabs[index];
          }),
    );
  }
}
