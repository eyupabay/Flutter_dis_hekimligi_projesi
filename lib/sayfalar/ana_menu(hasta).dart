import 'package:flutter/material.dart';
import '../hasta_bilgileri/hasta_sayfa_bilgileri.dart';
import '../hasta_bilgileri/yiyecek_ve_icecek_okuma.dart';
import '../sayfa_duzenleri.dart';

class HastaPaneli extends StatefulWidget {
  const HastaPaneli({Key? key}) : super(key: key);

  @override
  _HastaPaneliState createState() => _HastaPaneliState();
}

class _HastaPaneliState extends State<HastaPaneli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: menuUstBar(context),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          hastaVeriAvcisi(
              eklenecekVeri: yemek, veriDekorasyonu: yiyecekDekorasyonu()),
          hastaVeriAvcisi(
              eklenecekVeri: icecek, veriDekorasyonu: yiyecekDekorasyonu()),
          ElevatedButton(
            onPressed: yeIcVeriEkle,
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

class BoslukOlustur extends StatelessWidget {
  const BoslukOlustur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25.0,
    );
  }
}
