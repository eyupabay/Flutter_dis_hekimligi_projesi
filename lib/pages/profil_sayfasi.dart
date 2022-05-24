import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/pages/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: girisUstBar(context),
      body: ElevatedButton(
          onPressed: () {
            const CikisYap();
          },
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            primary: Colors.blueAccent,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          child: const Text(
            "Çıkış yap",
            textAlign: TextAlign.center,
          )
          //
          //BURAYA ŞU AN İÇİN LOG OUT KISMI YAPILACAK.
          //
          ),
      bottomNavigationBar: enAltBar(context),
    );
  }
}
