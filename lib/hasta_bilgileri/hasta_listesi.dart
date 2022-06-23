import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import 'firebaseBilgileriOkuma.dart';

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
                    color: Colors.indigo.shade100,
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        (listofDocsSnap[index].data() as Map)["Email"],
                        style:
                            const TextStyle(fontSize: 14.0, letterSpacing: 1.2),
                      ),
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
                          icon: const Icon(Icons.navigate_next)),
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
    .collection("Hastalar");
