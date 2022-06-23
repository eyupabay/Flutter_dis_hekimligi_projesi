import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hasta_listesi.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_doktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/gorev_ver.dart';
import '../../hasta_bilgileri/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaVeriSayfasi extends StatefulWidget {
  var tiklanilanHasta;
  HastaVeriSayfasi({this.tiklanilanHasta});

  @override
  State<HastaVeriSayfasi> createState() => _HastaVeriSayfasiState();
}

class _HastaVeriSayfasiState extends State<HastaVeriSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "Hasta bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const EnAltBarDoktor()));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Text(widget.tiklanilanHasta),
          DoktordanHastaBilgileriOkuma(
            okunacakBilgi: FirebaseFirestore.instance
                .collection("Hastalar")
                .doc(widget.tiklanilanHasta)
                .collection("Yiyecekler")
                .orderBy("Saat", descending: true),
            okunacakBilgiKlasoru: "Yemek",
          ),
          const Divider(
            height: 20,
          ),
          DoktordanHastaBilgileriOkuma(
            okunacakBilgi: FirebaseFirestore.instance
                .collection("Hastalar")
                .doc(widget.tiklanilanHasta)
                .collection("İçecekler")
                .orderBy("Saat", descending: true),
            okunacakBilgiKlasoru: "İçecek",
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => gorevVer(
                          tiklanilanHasta: widget.tiklanilanHasta,
                        )));
              },
              child: Text("Atanan görevler")),
        ]),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
