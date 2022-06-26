import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class gorevVer extends StatefulWidget {
  var tiklanilanHasta;
  gorevVer({this.tiklanilanHasta});

  @override
  State<gorevVer> createState() => _gorevVerState();
}

class _gorevVerState extends State<gorevVer> {
  /* late String tiklanilanHasta; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "Görev bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HastaVeriSayfasi(
                        tiklanilanHasta: widget.tiklanilanHasta,
                      )));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          doktorGorevAvcisi(
              eklenecekVeri: gorevler, veriDekorasyonu: gorevDekorasyonu()),
          DoktordanGorevleriOkuma(
              okunacakBilgi: FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(widget.tiklanilanHasta)
                  .collection("Gorevler")
                  .orderBy("Saat", descending: true),
              okunacakBilgiKlasoru: "gorev"),
          CupertinoButton.filled(
              /* 
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)), */
              onPressed: () async {
                if (gorevler.text != "") {
                  FirebaseFirestore.instance
                      .collection("Hastalar")
                      .doc(widget.tiklanilanHasta)
                      .collection("Gorevler")
                      .doc()
                      .set({
                        "gorev": gorevler.text.toUpperCase(),
                        "Saat": tarihGun,
                        "yapildi": false
                      })
                      .whenComplete(() => print(
                          "${widget.tiklanilanHasta} kullanıcısına görev verisi ekledi."))
                      .then((value) => {gorevler.clear()});
                }
              },
              child: Text(
                "Görev ver",
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ]),
      ),
    );
  }
}
