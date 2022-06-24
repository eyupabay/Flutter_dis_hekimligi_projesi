import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../../models/dekorasyonlar.dart';
import '../../hasta_bilgileri/firebaseBilgileriOkuma.dart';
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
              eklenecekVeri: icecekler, veriDekorasyonu: icecekDekorasyonu()),
          ElevatedButton(
            onPressed: () async {
              yeIcVeriEkle();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal[400],
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            child: Text(
              "Veri ekle",
              style: Theme.of(context).textTheme.bodyText1,
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
