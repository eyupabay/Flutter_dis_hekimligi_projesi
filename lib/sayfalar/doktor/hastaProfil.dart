import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaninProfilDetaylari extends StatefulWidget {
  var tiklanilanHasta;
  HastaninProfilDetaylari({Key? key, this.tiklanilanHasta}) : super(key: key);

  @override
  State<HastaninProfilDetaylari> createState() => ProfilSayfasiHastaState();
}

class ProfilSayfasiHastaState extends State<HastaninProfilDetaylari> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HastaVeriSayfasi(
                        tiklanilanHasta: widget.tiklanilanHasta,
                      )));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
        context: context,
        textYazisi: Stringler.profil,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Doktorlar")
                  .doc(FirebaseAuth.instance.currentUser?.email)
                  .collection("Hastalarim")
                  .doc(widget.tiklanilanHasta)
                  .collection("Bilgiler")
                  .snapshots(),
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
                          children: [
                            Text(
                              "İsim : ${listofDocsSnap[index].get("İsim")}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              "Soyisim : ${listofDocsSnap[index].get("Soyisim")}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              "YAŞ : ${listofDocsSnap[index].get("Yaş").toString()}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              "Email : ${listofDocsSnap[index].get("Email")}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              "Telefon : ${listofDocsSnap[index].get("Telefon").toString()}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              "Şikayet : ${listofDocsSnap[index].get("Şikayet")}",
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
