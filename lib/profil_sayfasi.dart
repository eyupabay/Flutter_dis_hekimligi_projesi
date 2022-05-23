import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          "Musteri Profili",
          textAlign: TextAlign.center,
        ),
      ),
      body: RawMaterialButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
          fillColor: const Color(0xFF0069FE),
          child: const Text(
            "Çıkış yap",
            textAlign: TextAlign.center,
          )
          //
          //BURAYA ŞU AN İÇİN LOG OUT KISMI YAPILACAK.
          //
          ),
    );
  }
}
