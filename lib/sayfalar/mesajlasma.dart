import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

import '../sayfa_duzenleri.dart';

class Mesajlasma extends StatefulWidget {
  const Mesajlasma({Key? key}) : super(key: key);

  @override
  State<Mesajlasma> createState() => _MesajlasmaState();
}

class _MesajlasmaState extends State<Mesajlasma> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.mesajlar),
      body: Container(
        width: 400,
        height: 300,
        color: Colors.blue,
        child: const Center(child: Text("Burada MESAJLAR yer alacak")),
      ),
    );
  }
}
