import 'package:flutter/material.dart';
import 'logging/log_islemleri.dart';
import 'sayfalar/ana_menu(hasta).dart';
import 'sayfalar/profil_sayfasi.dart';
import 'stringler.dart';

BottomNavigationBar enAltBar(BuildContext context) {
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
}

AppBar girisUstBar(BuildContext context) {
  return AppBar(
    //Ekranın en üstünde bir bar açar
    leadingWidth: double.infinity,
    title: Center(
      child: Text(
        Stringler.uygulamaAdi,
        //textAlign: TextAlign.center,
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
    ),
  );
}

AppBar menuUstBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.shadowColor,
    title: const Text(
      Stringler.anaSayfa,
      textAlign: TextAlign.center,
    ),
    actions: const [CikisYap()],
  );
}

mixin Yonlendirme {
  void sayfaYonlendirme(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }
}

enum Sayfalar { menu, profil }
