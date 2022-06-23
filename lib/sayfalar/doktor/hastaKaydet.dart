import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_doktor.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';
import '../../logging/log_islemleri.dart';

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
          .collection("Hastalar")
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
              MaterialPageRoute(builder: (context) => const EnAltBarDoktor())));
    }

    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: Stringler.uygulamaAdi,
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const EnAltBarDoktor()));
            },
            icon: const Icon(Icons.keyboard_arrow_left_sharp)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          //Sütun döndürür..
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 150,
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/images/tooth.png'),
            ),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(Theme.of(context).backgroundColor.blue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                fixedSize: const Size(170, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
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
