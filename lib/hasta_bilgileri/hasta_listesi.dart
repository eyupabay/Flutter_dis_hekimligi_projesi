import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import '../logging/firebaseBilgileriOkuma.dart';

class HastaListesi extends StatefulWidget {
  @override
  State<HastaListesi> createState() => _HastaListesiState();
}

class _HastaListesiState extends State<HastaListesi> {
  late String tiklanilanHasta;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        //Hasta isimleri çekilecek.
        stream: hastalarRef.snapshots(),
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
                    child: ListTile(
                      title: Text(
                          (listofDocsSnap[index].data() as Map)["Email"],
                          style: Theme.of(context).textTheme.bodyText1),
                      trailing: IconButton(
                          onPressed: () async {
                            tiklanilanHasta =
                                listofDocsSnap[index].get("Email").toString();
                            print(tiklanilanHasta);
                            DoktordanHastaBilgileriOkuma(
                                okunacakBilgi: FirebaseFirestore.instance
                                    .collection("Hastalar")
                                    .doc(tiklanilanHasta)
                                    .collection("Yiyecekler")
                                    .orderBy("Saat", descending: true),
                                okunacakBilgiKlasoru: "Yemek");
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HastaVeriSayfasi(
                                        tiklanilanHasta: tiklanilanHasta)));
                          },
                          icon: const Icon(CupertinoIcons.forward)),
                    ),
                  );
                }),
          );
        });
  }
}

Query hastalarRef = FirebaseFirestore.instance
    .collection("Doktorlar")
    .doc(auth.currentUser!.email)
    .collection("Hastalarim");
