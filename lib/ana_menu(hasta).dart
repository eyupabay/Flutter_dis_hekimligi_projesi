import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/main.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'yiyecek_ve_icecek_okuma.dart';

class HastaPaneli extends StatefulWidget {
  const HastaPaneli({Key? key}) : super(key: key);

  @override
  _HastaPaneliState createState() => _HastaPaneliState();
}

class _HastaPaneliState extends State<HastaPaneli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text(
          Stringler.anaSayfa,
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.logout_sharp),
          )
        ],
      ),
      body: Column(children: [
        const BoslukOlustur(),
        yemekAvcisi(),
        const BoslukOlustur(),
        icecekAvcisi(),
        const BoslukOlustur(),
        RawMaterialButton(
          onPressed: () {
            veriEkle().then((value) => {yemek.clear(), icecek.clear()});
          },
          fillColor: Theme.of(context).colorScheme.secondary,
          child: const Text(
            "Veri ekle",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const BoslukOlustur(),
        yiyecekleriOkuma(yiyeceklerRef: yiyeceklerRef),
        icecekleriOkuma(iceceklerRef: iceceklerRef),
      ]),
      bottomNavigationBar: enAltBar(context),
    );
  }

  TextField icecekAvcisi() {
    return TextField(
      controller: icecek,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: "İçtiğiniz içecek",
        prefixIcon: Icon(Icons.local_drink),
      ),
    );
  }

  TextField yemekAvcisi() {
    return TextField(
      controller: yemek,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          hintText: "Yediğiniz yiyecek", prefixIcon: Icon(Icons.food_bank)),
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
    backgroundColor: Theme.of(context).backgroundColor,
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