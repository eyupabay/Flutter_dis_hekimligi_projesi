import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
          context: context,
          textYazisi: Stringler.profil,
          aksiyon: [const CikisYap()]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Email:${FirebaseAuth.instance.currentUser!.email.toString()}",
              style: const TextStyle(fontSize: 20),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    const CikisYap();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    primary: Colors.blueAccent,
                  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                  child: const Text(
                    Stringler.cikisYap,
                    textAlign: TextAlign.center,
                  )
                  //
                  //BURAYA ŞU AN İÇİN LOG OUT KISMI YAPILACAK.
                  //
                  ),
            ),
          ],
        ),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
