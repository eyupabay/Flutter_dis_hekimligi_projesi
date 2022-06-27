import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Stream<DocumentSnapshot> doktorBilgileri = FirebaseFirestore.instance
      .collection('Doktorlar')
      .doc(FirebaseAuth.instance.currentUser?.email.toString())
      .snapshots();

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
              "Email:${FirebaseAuth.instance.currentUser!.email.toString()}}",
              style: Theme.of(context).textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
