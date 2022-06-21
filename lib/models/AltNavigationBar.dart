/* import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/ana_menu(doktor).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/gorevler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/mesajlasma.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart';




BottomNavigationBar enAltBar(BuildContext context) {
  
  int _selectedIndex = 0;
  
  List Sayfalar = [HastaPaneli(), Gorevler(), Mesajlasma(), ProfilPage()];
  return BottomNavigationBar(

    currentIndex: _selectedIndex,
    onTap: ,
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
        icon: Icon(Icons.toc_outlined),
        label: "gorevler",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: "mesajlar",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: "profil",
      ),
    ],
  );
  
}
 */