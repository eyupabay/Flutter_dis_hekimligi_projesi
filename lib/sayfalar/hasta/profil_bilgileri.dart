/* import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import '../logging/firebaseBilgileriOkuma.dart';

class HastaListesi2 extends StatefulWidget {
  const HastaListesi2({Key? key}) : super(key: key);

  @override
  State<HastaListesi2> createState() => _HastaListesiState();
}

class _HastaListesiState extends State<HastaListesi2> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DoktorBilgileri?>(
        //Hasta isimleri çekilecek.
        future: hastaBilgisiOku(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final doktorlar = snapshot.data;
            return doktorlar == null
                ? Center(
                    child: Text("kimse yok"),
                  )
                : doktorYapisi(doktorlar);
          } else {
            return CircularProgressIndicator(
              backgroundColor: Colors.black,
            );
          }
        });
  }
}

class DoktorBilgileri {
  final String? isim;
  final String? soyisim;
  final int? yas;

  DoktorBilgileri({
    this.isim,
    this.soyisim,
    this.yas,
  });

  static DoktorBilgileri fromJson(Map<String, dynamic> json) => DoktorBilgileri(
        isim: json["İsim"],
        soyisim: json["Soyisim"],
        yas: json["Yaş" as Int],
      );

  /*  Map<String,dynamic> toJson()=>{
    "İsim" = isim,
    "Soyisim" = soyisim,
    "Yaş" = yas,
  }; */
}

Widget doktorYapisi(DoktorBilgileri doktorBilgileri) => ListTile(
      title: Text("${doktorBilgileri.soyisim}"),
      subtitle: Text(doktorBilgileri.yas.toString()),
    );

Stream<List<DoktorBilgileri>> doktorBilgileriOku() => FirebaseFirestore.instance
    .collection("Hastalar")
    .snapshots()
    .map((snapshot) => snapshot.docs
        .map((doc) => DoktorBilgileri.fromJson(doc.data()))
        .toList());

Future<DoktorBilgileri?> hastaBilgisiOku() async {
  final docsHasta =
      FirebaseFirestore.instance.collection("Hastalar").doc("hasta@ktu.com");
  final snapshot = await docsHasta.get();

  if (snapshot.exists) {
    return DoktorBilgileri.fromJson(snapshot.data()!);
  }
}
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class ProfilSayfasiHasta extends StatefulWidget {
  const ProfilSayfasiHasta({Key? key}) : super(key: key);

  @override
  State<ProfilSayfasiHasta> createState() => ProfilSayfasiHastaState();
}

class ProfilSayfasiHastaState extends State<ProfilSayfasiHasta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
          context: context,
          textYazisi: Stringler.profil,
          aksiyon: [const CikisYap()]),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          /* CupertinoButton.filled(child: child, onPressed: (){}), */
          StreamBuilder(
              stream: profilRef.snapshots(),
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
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${listofDocsSnap[index].get("İsim")} ${listofDocsSnap[index].get("Soyisim")}",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8)),
                              child: Text(
                                "YAŞ : ${listofDocsSnap[index].get("Yaş").toString()}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8)),
                              child: Text(
                                "Email : ${listofDocsSnap[index].get("Email")}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8)),
                              child: Text(
                                "Telefon : ${listofDocsSnap[index].get("Telefon").toString()}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            Card(
                              color: Colors.grey[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8)),
                              child: Text(
                                "Şikayet : ${listofDocsSnap[index].get("Şikayet")}",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ),
                            const Divider(
                              height: 20,
                            ),
                            Text(
                              "Doktorunuzun E-Postası : ${listofDocsSnap[index].get("doktorMaili")}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        );
                      }),
                );
              })
        ]),
      ),
    );
  }
}
