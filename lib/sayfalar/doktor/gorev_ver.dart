import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hasta_listesi.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_doktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hasta_veri_sayfasi.dart';
import '../../hasta_bilgileri/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class gorevVer extends StatefulWidget {
  const gorevVer({Key? key}) : super(key: key);

  @override
  State<gorevVer> createState() => _gorevVerState();
}

class _gorevVerState extends State<gorevVer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "Gorev bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HastaVeriSayfasi()));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Text(tiklanilanHasta),
          doktorGorevAvcisi(
              eklenecekVeri: gorevler, veriDekorasyonu: gorevDekorasyonu()),
          DoktordanGorevleriOkuma(
              okunacakBilgi: doktorGorevlerRef, okunacakBilgiKlasoru: "gorev"),
          ElevatedButton(
              onPressed: () async {
                gorevYaz();
              },
              child: Text("Gorev ver")),
        ]),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
