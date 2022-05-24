import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import '../sayfa_duzenleri.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: menuUstBar(context),
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
