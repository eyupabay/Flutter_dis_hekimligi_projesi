import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../hasta_bilgileri/hasta_sayfa_bilgileri.dart';
import '../hasta_bilgileri/yiyecek_ve_icecek_okuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaPaneli extends StatefulWidget {
  const HastaPaneli({Key? key}) : super(key: key);

  @override
  _HastaPaneliState createState() => _HastaPaneliState();
}

class _HastaPaneliState extends State<HastaPaneli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.uygulamaAdi),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          hastaVeriAvcisi(
              eklenecekVeri: yemekler, veriDekorasyonu: yiyecekDekorasyonu()),
          hastaVeriAvcisi(
              eklenecekVeri: icecekler, veriDekorasyonu: yiyecekDekorasyonu()),
          ElevatedButton(
            onPressed: () async {
              yeIcVeriEkle();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              primary: Colors.blueAccent,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: const Text(
              "Veri ekle",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
