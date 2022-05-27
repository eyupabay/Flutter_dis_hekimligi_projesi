import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/sayfa_duzenleri.dart';
import 'sayfalar/login_page.dart';

class KararYeri extends StatelessWidget {
  const KararYeri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("StreamBuilder baslatıldı.");
          if (snapshot.hasData && snapshot.data != null) {
            print("snapshot'ların icerisinin bos olmadıgı gozlemlendi.");
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Musteriler")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc!;
                  if (user['role'] == "doktor") {
                    print("Doktor giriş yaptı.");
                    return const EnAltBarDoktor();
                  } else {
                    print("Hasta giriş yaptı.");
                    return const EnAltBar();
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
