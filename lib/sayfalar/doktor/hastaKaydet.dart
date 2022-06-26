import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import '../../models/log_islemleri.dart';

class KayitEtHasta extends StatefulWidget {
  const KayitEtHasta({Key? key}) : super(key: key);

  @override
  State<KayitEtHasta> createState() => _KayitEtHastaState();
}

class _KayitEtHastaState extends State<KayitEtHasta> {
  String girisYapanKullaniciMaili = auth.currentUser!.email.toString();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    Future<void> hastaEntegreEt() async {
      FirebaseFirestore.instance
          .collection("Doktorlar")
          .doc(girisYapanKullaniciMaili)
          .collection("Hastalarim")
          .doc(emailController.text)
          .set({
            "Email": emailController.text,
            "role": "hasta",
            "doktorMaili": girisYapanKullaniciMaili
          })
          .whenComplete(() => print(
              "${emailController.text} kullanıcısı doktorun koleksiyonuna eklendi."))
          .whenComplete(() => FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(emailController.text)
                  .set({
                "Email": emailController.text,
                "role": "hasta",
                "doktorMaili": girisYapanKullaniciMaili
              }))
          .whenComplete(() => print(
              "${emailController.text} kullanıcısı Hastalar koleksiyonuna eklendi."))
          .whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => NavigationBarDoktor())));
    }

    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: Stringler.uygulamaAdi,
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarDoktor()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const AnaEkrangif(),
            Text(
              "Hasta kayıt et",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            textGirdileri(
                alinacakBilgi: emailController,
                dekorasyon: girisMailDekorasyonu(),
                ilerleme: TextInputAction.next,
                isAutofocus: true,
                isObscureText: false),
            CupertinoButton.filled(
              /* 
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)) */
              onPressed: hastaEntegreEt,
              child: Text(
                Stringler.kaydet,
                style: Theme.of(context).textTheme.bodyText1,
                textScaleFactor: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
