import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class GirilenIcecekSayfasi extends StatefulWidget {
  const GirilenIcecekSayfasi({Key? key}) : super(key: key);

  @override
  State<GirilenIcecekSayfasi> createState() => _GirilenIcecekSayfasiState();
}

class _GirilenIcecekSayfasiState extends State<GirilenIcecekSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "İçecek bilgileri",
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
          HastaBilgileriOkuma(
              okunacakBilgi: iceceklerRef, okunacakBilgiKlasoru: "İçecek"),
        ]),
      ),
    );
  }
}
