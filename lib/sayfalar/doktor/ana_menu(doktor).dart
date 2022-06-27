import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hasta_listesi.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/profil_bilgileri.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class DoktorPanel extends StatefulWidget {
  const DoktorPanel({Key? key}) : super(key: key);

  @override
  DoktorPanelState createState() => DoktorPanelState();
}

class DoktorPanelState extends State<DoktorPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(
          context: context,
          textYazisi: Stringler.uygulamaAdi,
          aksiyon: const [HastaEklemeButonu()]),
      //Hastaları doktorun olduğu koleksiyonda, Hastalar adlı klasörün içerisine sadece email ismini kaydediyoruz.
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [HastaListesi()],
        ),
      ),
    );
  }
}
