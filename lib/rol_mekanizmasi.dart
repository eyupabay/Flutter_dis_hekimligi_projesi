import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/ana_menu(doktor).dart';
import 'package:flutter_uygulama_deniyorum/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/login_page.dart';
import "login_page.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class kararYeri extends StatelessWidget {
  const kararYeri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Musteriler")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc!;
                  if (user['role'] == 'doktor') {
                    return const DoktorPanel();
                  } else {
                    return const HastaPaneli();
                  }
                } else {
                  return const Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return const LoginPage();
        });
  }
}