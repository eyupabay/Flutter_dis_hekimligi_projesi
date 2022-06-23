import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hasta_listesi.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_doktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/gorev_ver.dart';
import '../../hasta_bilgileri/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaVeriSayfasi extends StatelessWidget {
  const HastaVeriSayfasi({Key? key}) : super(key: key);

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
          Text(tiklanilanHasta),
          DoktordanHastaBilgileriOkuma(
            okunacakBilgi: doktorYiyeceklerRef,
            okunacakBilgiKlasoru: "Yemek",
          ),
          const Divider(
            height: 20,
          ),
          DoktordanHastaBilgileriOkuma(
            okunacakBilgi: doktorIceceklerRef,
            okunacakBilgiKlasoru: "İçecek",
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const gorevVer()));
              },
              child: Text("Atanan görevler")),
        ]),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
