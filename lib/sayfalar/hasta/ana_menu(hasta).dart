import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/girilen_icecekler.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/girilen_yemek.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import '../../models/dekorasyonlar.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
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
          CupertinoButton.filled(
            onPressed: () async {
              yeIcVeriEkle();
            },
            /* 
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ), */
            child: Text(
              "Veri ekle",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const Divider(
            height: 150,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 60.0,
                icon: const Icon(Icons.food_bank),
                tooltip: "Yiyecekler",
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GirilenYemekSayfasi()));
                },
              ),
              IconButton(
                iconSize: 60.0,
                icon: const Icon(Icons.local_drink),
                tooltip: "İçecekler",
                onPressed: () async {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GirilenIcecekSayfasi()));
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
