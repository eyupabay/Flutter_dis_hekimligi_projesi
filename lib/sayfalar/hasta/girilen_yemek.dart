import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class GirilenYemekSayfasi extends StatefulWidget {
  const GirilenYemekSayfasi({Key? key}) : super(key: key);

  @override
  State<GirilenYemekSayfasi> createState() => _GirilenYemekSayfasiState();
}

class _GirilenYemekSayfasiState extends State<GirilenYemekSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "Yemek bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarHasta()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          /* CupertinoButton.filled(child: child, onPressed: (){}), */
          HastaBilgileriOkuma(
              okunacakBilgi: yiyeceklerRef, okunacakBilgiKlasoru: "Yemek"),
        ]),
      ),
    );
  }
}
