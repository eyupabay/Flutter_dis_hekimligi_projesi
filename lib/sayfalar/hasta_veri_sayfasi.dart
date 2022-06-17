import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../hasta_bilgileri/hasta_sayfa_bilgileri.dart';
import '../hasta_bilgileri/yiyecek_ve_icecek_okuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaVeriSayfasi extends StatelessWidget {
  const HastaVeriSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.uygulamaAdi),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          HastaBilgileriOkuma(
            okunacakBilgi: yiyeceklerRef,
            okunacakBilgiKlasoru: "Yemek",
          ),
          const Divider(
            height: 20,
          ),
          HastaBilgileriOkuma(
            okunacakBilgi: iceceklerRef,
            okunacakBilgiKlasoru: "İçecek",
          ),
        ]),
      ),
      /* bottomNavigationBar: enAltBar(context), */
    );
  }
}
