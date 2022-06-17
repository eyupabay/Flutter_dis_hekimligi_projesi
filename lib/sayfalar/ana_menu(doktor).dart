import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/hastaKayitEt_byDoktor.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../hasta_bilgileri/yiyecek_ve_icecek_okuma.dart';

class DoktorPanel extends StatefulWidget {
  const DoktorPanel({Key? key}) : super(key: key);

  @override
  DoktorPanelState createState() => DoktorPanelState();
}

class DoktorPanelState extends State<DoktorPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
          context: context,
          textYazisi: Stringler.uygulamaAdi,
          aksiyon: const [HastaEklemeButonu()]),
      //Hastaları doktorun olduğu koleksiyonda, Hastalar adlı klasörün içerisine sadece email ismini kaydediyoruz.
      body: Column(
        children: [
          StreamBuilder(
              //Hasta isimleri çekilecek.
              stream: hastalarRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              style: const TextStyle(
                                  fontSize: 14.0, letterSpacing: 1.2),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  StreamBuilder(
                                      stream: yiyeceklerRef.snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              hastaSnapshot) {
                                        if (hastaSnapshot.data == null) {
                                          return const CircularProgressIndicator();
                                        }
                                        List<DocumentSnapshot> yemeklistofdocs =
                                            hastaSnapshot.data!.docs;
                                        return Flexible(
                                          child: ListView.builder(
                                              itemCount: yemeklistofdocs.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  color: Colors.indigo.shade100,
                                                  elevation: 2.0,
                                                  child: ListTile(
                                                    title: Text(
                                                      yemeklistofdocs[index]
                                                          .get("Yemek"),
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          letterSpacing: 1.2),
                                                    ),
                                                    subtitle: Text(
                                                        yemeklistofdocs[index]
                                                            .get("Saat")),
                                                  ),
                                                );
                                              }),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.navigate_next)),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }

  Query hastalarRef = FirebaseFirestore.instance
      .collection("Doktorlar")
      .doc(auth.currentUser!.email)
      .collection("Hastalar");
}
