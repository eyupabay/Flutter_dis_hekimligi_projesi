import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/ana_menu(doktor).dart';

final yemek = TextEditingController();
final icecek = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

Query doktorYiyeceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(tiklanilanHasta)
    .collection("Yiyecekler")
    .orderBy("Saat", descending: true);

Query doktorIceceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(tiklanilanHasta)
    .collection("İçecekler")
    .orderBy("Saat", descending: true);

Query yiyeceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("Yiyecekler")
    .orderBy("Saat", descending: true);

Query iceceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("İçecekler")
    .orderBy("Saat", descending: true);

class HastaBilgileriOkuma extends StatelessWidget {
  const HastaBilgileriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  final Query<Object?> okunacakBilgi;
  final String okunacakBilgiKlasoru;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: okunacakBilgi.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          List<DocumentSnapshot> listofDocsSnap = snapshot.data!.docs;
          return Flexible(
            child: ListView.builder(
                itemCount: listofDocsSnap.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        listofDocsSnap[index].get(okunacakBilgiKlasoru),
                        style:
                            const TextStyle(fontSize: 14.0, letterSpacing: 1.2),
                      ),
                      subtitle: Text(listofDocsSnap[index].get("Saat")),
                      trailing: IconButton(
                          onPressed: () async {
                            await listofDocsSnap[index].reference.delete();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                }),
          );
        });
  }
}

class DoktordanHastaBilgileriOkuma extends StatelessWidget {
  const DoktordanHastaBilgileriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  final Query<Object?> okunacakBilgi;
  final String okunacakBilgiKlasoru;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: okunacakBilgi.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          List<DocumentSnapshot> listofDocsSnap = snapshot.data!.docs;
          return Flexible(
            child: ListView.builder(
                itemCount: listofDocsSnap.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        listofDocsSnap[index].get(okunacakBilgiKlasoru),
                        style:
                            const TextStyle(fontSize: 14.0, letterSpacing: 1.2),
                      ),
                      subtitle: Text(listofDocsSnap[index].get("Saat")),
                    ),
                  );
                }),
          );
        });
  }
}
