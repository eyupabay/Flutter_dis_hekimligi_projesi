import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/pages/profil_sayfasi.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../hasta_bilgileri/hasta_sayfa_bilgileri.dart';
import '../hasta_bilgileri/yiyecek_ve_icecek_okuma.dart';

class HastaPaneli extends StatefulWidget {
  const HastaPaneli({Key? key}) : super(key: key);

  @override
  _HastaPaneliState createState() => _HastaPaneliState();
}

class _HastaPaneliState extends State<HastaPaneli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: girisUstBar(context),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          hastaVeriAvcisi(yemek, yiyecekDekorasyonu()),
          hastaVeriAvcisi(icecek, icecekDekorasyonu()),
          ElevatedButton(
            onPressed: yeIcVeriEkle,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              primary: Colors.blueAccent,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: const Text(
              "Veri ekle",
              style: TextStyle(color: Colors.white),
            ),
          ),
          yiyecekleriOkuma(yiyeceklerRef: yiyeceklerRef),
          const Divider(
            height: 20,
          ),
          icecekleriOkuma(iceceklerRef: iceceklerRef),
        ]),
      ),
      bottomNavigationBar: enAltBar(context),
    );
  }
}

class BoslukOlustur extends StatelessWidget {
  const BoslukOlustur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25.0,
    );
  }
}

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
    backgroundColor: Theme.of(context).appBarTheme.shadowColor,
    title: const Text(
      Stringler.anaSayfa,
      textAlign: TextAlign.center,
    ),
    actions: const [CikisYap()],
  );
}

enum Sayfalar { menu, profil }
