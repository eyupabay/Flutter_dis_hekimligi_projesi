import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/ana_menu(doktor).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/mesajlasma.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart';

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
