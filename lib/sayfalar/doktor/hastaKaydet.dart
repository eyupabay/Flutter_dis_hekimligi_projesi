import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hastaKaydet_2.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import '../../models/log_islemleri.dart';

class KayitEtHasta extends StatefulWidget {
  const KayitEtHasta({
    Key? key,
  }) : super(key: key);

  @override
  State<KayitEtHasta> createState() => _KayitEtHastaState();
}

class _KayitEtHastaState extends State<KayitEtHasta> {
  String girisYapanKullaniciMaili = auth.currentUser!.email.toString();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController isim = TextEditingController();
    TextEditingController soyisim = TextEditingController();
    TextEditingController yas = TextEditingController();
    TextEditingController sikayet = TextEditingController();
    TextEditingController telefon = TextEditingController();

    Future<void> hastaEntegreEt() async {
      FirebaseFirestore.instance
          .collection("Doktorlar")
          .doc(girisYapanKullaniciMaili)
          .collection("Hastalarim")
          .doc(emailController.text)
          .collection("Bilgiler")
          .doc("Özellikler")
          .set({
            "Email": emailController.text,
            "İsim": isim.text.toUpperCase(),
            "Soyisim": soyisim.text.toUpperCase(),
            "Yaş": yas.text,
            "Şikayet": sikayet.text.toUpperCase(),
            "Telefon": telefon.text,
            "doktorMaili": girisYapanKullaniciMaili
          })
          .whenComplete(() => print(
              "${emailController.text} kullanıcısı doktorun koleksiyonuna eklendi."))
          .whenComplete(() => FirebaseFirestore.instance
                  .collection("Doktorlar")
                  .doc(girisYapanKullaniciMaili)
                  .collection("Hastalarim")
                  .doc(emailController.text)
                  .set({
                "Email": emailController.text,
                "İsim": isim.text.toUpperCase(),
                "Soyisim": soyisim.text.toUpperCase(),
                "doktorMaili": girisYapanKullaniciMaili
              }))
          .whenComplete(() => FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(emailController.text)
                  .collection("Bilgiler")
                  .doc("Bilgilerim")
                  .set({
                "Email": emailController.text,
                "İsim": isim.text.toUpperCase(),
                "Soyisim": soyisim.text.toUpperCase(),
                "Yaş": yas.text,
                "Şikayet": sikayet.text.toUpperCase(),
                "Telefon": telefon.text,
                "doktorMaili": girisYapanKullaniciMaili
              }))
          .whenComplete(() => print(
              "${emailController.text} kullanıcısı Hastalar koleksiyonuna eklendi."))
          .whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) =>
                      KayitEtHasta_2(hastaMaili: emailController.text))));
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
          children: <Widget>[
            /* const AnaEkrangif(), */
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
            textGirdileri(
                alinacakBilgi: isim,
                dekorasyon: InputDecoration(hintText: "İsim"),
                ilerleme: TextInputAction.next,
                isAutofocus: false,
                isObscureText: false),
            textGirdileri(
                alinacakBilgi: soyisim,
                dekorasyon: InputDecoration(hintText: "Soyisim"),
                ilerleme: TextInputAction.next,
                isAutofocus: false,
                isObscureText: false),
            textGirdileri(
                alinacakBilgi: yas,
                dekorasyon: InputDecoration(hintText: "Yaş"),
                ilerleme: TextInputAction.next,
                isAutofocus: false,
                isObscureText: false),
            textGirdileri(
                alinacakBilgi: telefon,
                dekorasyon: InputDecoration(hintText: "Telefon No"),
                ilerleme: TextInputAction.next,
                isAutofocus: false,
                isObscureText: false),
            textGirdileri(
                alinacakBilgi: sikayet,
                dekorasyon: InputDecoration(hintText: "Şikayet"),
                ilerleme: TextInputAction.done,
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
