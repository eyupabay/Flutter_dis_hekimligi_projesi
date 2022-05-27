import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sayfalar/ana_menu(doktor).dart';
import 'sayfalar/ana_menu(hasta).dart';
import 'sayfalar/login_page.dart';

class KararYeri extends StatelessWidget {
  const KararYeri({Key? key}) : super(key: key);

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
                  if (user['role'] == "doktor") {
                    print("Doktor giriş yaptı.");
                    return const DoktorPanel();
                  } else {
                    print("Hasta giriş yaptı.");
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
