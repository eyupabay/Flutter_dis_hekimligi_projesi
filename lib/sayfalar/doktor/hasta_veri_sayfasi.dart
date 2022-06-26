import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/gorev_ver.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaVeriSayfasi extends StatefulWidget {
  var tiklanilanHasta;
  HastaVeriSayfasi({Key? key, this.tiklanilanHasta}) : super(key: key);

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
                  builder: (context) => NavigationBarDoktor()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
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
          CupertinoButton.filled(
              /* 
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)) */
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => gorevVer(
                      tiklanilanHasta: widget.tiklanilanHasta,
                    ),
                  ),
                );
              },
              child: Text(
                "Atanan görevler",
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ]),
      ),
    );
  }
}
