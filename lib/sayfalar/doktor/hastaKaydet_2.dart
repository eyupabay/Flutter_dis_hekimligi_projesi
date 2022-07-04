import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import '../../models/log_islemleri.dart';

class KayitEtHasta_2 extends StatefulWidget {
  var hastaMaili;
  KayitEtHasta_2({Key? key, this.hastaMaili}) : super(key: key);

  @override
  State<KayitEtHasta_2> createState() => _KayitEtHasta_2State();
}

class _KayitEtHasta_2State extends State<KayitEtHasta_2> {
  String girisYapanKullaniciMaili = auth.currentUser!.email.toString();
  bool sigara = false;
  bool disipi = false;
  bool agizcalkalama = false;

  @override
  Widget build(BuildContext context) {
    Future<void> hastaEntegreEt() async {
      FirebaseFirestore.instance
          .collection("Doktorlar")
          .doc(girisYapanKullaniciMaili)
          .collection("Hastalarim")
          .doc(widget.hastaMaili)
          .collection("Bilgiler")
          .doc("Özellikler")
          .update({
            "Sigara": sigara,
            "Disipi": disipi,
            "AgizCalkalama": agizcalkalama,
          })
          .whenComplete(() => print(
              "${widget.hastaMaili} kullanıcısı Hastalar koleksiyonuna eklendi."))
          .whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NavigationBarDoktor())));
    }

    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: Stringler.uygulamaAdi,
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarDoktor()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          children: <Widget>[
            CheckboxListTile(
                title: Text("Sigara kullanılıyor mu?"),
                value: sigara,
                onChanged: (sigara) {
                  setState(() {
                    this.sigara = sigara!;
                  });
                }),
            CheckboxListTile(
                title: Text("Diş ipi kullanılıyor mu?"),
                value: disipi,
                onChanged: (disipi) {
                  setState(() {
                    this.disipi = disipi!;
                  });
                }),
            CheckboxListTile(
                title: Text("Ağız çalkalama suyu kullanılıyor mu?"),
                value: agizcalkalama,
                onChanged: (agizcalkalama) {
                  setState(() {
                    this.agizcalkalama = agizcalkalama!;
                  });
                }),
            CupertinoButton.filled(
              /* 
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)) */
              onPressed: hastaEntegreEt,
              child: Text(
                Stringler.kaydet,
                style: Theme.of(context).textTheme.bodyText1,
                textScaleFactor: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
