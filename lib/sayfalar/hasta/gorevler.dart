import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class Gorevler extends StatefulWidget {
  const Gorevler({Key? key}) : super(key: key);

  @override
  State<Gorevler> createState() => _GorevlerState();
}

class _GorevlerState extends State<Gorevler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.gorevler),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            HastaGorevleriOkuma(
                okunacakBilgi: gorevlerRef, okunacakBilgiKlasoru: "gorev"),
          ],
        ),
      ),
    );
  }
}
