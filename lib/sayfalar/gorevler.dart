import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfa_duzenleri.dart';

class Gorevler extends StatefulWidget {
  const Gorevler({Key? key}) : super(key: key);

  @override
  State<Gorevler> createState() => _GorevlerState();
}

class _GorevlerState extends State<Gorevler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: girisUstBar(context),
      body: Container(
        width: 400,
        height: 300,
        color: Colors.green,
        child: const Center(child: Text("Burada GÖREVLER yer alacak")),
      ),
    );
  }
}
