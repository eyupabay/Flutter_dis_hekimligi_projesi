import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import '../../hasta_bilgileri/firebaseBilgileriOkuma.dart';
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
        textYazisi: "Gorev bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HastaVeriSayfasi(
                        tiklanilanHasta: widget.tiklanilanHasta,
                      )));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          /* Text(tiklanilanHasta), */
          doktorGorevAvcisi(
              eklenecekVeri: gorevler, veriDekorasyonu: gorevDekorasyonu()),
          DoktordanGorevleriOkuma(
              okunacakBilgi: FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(widget.tiklanilanHasta)
                  .collection("Gorevler")
                  .orderBy("Saat", descending: true),
              okunacakBilgiKlasoru: "gorev"),
          ElevatedButton(
              onPressed: () async {
                if (gorevler.text != "") {
                  FirebaseFirestore.instance
                      .collection("Hastalar")
                      .doc(widget.tiklanilanHasta)
                      .collection("Gorevler")
                      .doc()
                      .set({"gorev": gorevler.text, "Saat": tarihGun})
                      .whenComplete(() => print(
                          "${widget.tiklanilanHasta} kullanıcısına görev verisi ekledi."))
                      .then((value) => {gorevler.clear()});
                }
                /* gorevYaz(widget.tiklanilanHasta); */
              },
              child: Text("Gorev ver")),
        ]),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
