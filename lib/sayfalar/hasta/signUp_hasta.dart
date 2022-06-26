import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_loginPage.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class SignUpHasta extends StatefulWidget {
  const SignUpHasta({Key? key}) : super(key: key);

  @override
  _SignUpHastaState createState() => _SignUpHastaState();
}

class _SignUpHastaState extends State<SignUpHasta> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailControllerHasta = TextEditingController();
    TextEditingController passwordControllerHasta = TextEditingController();

    Future<void> kayitolHasta() async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailControllerHasta.text,
              password: passwordControllerHasta.text)
          .then((kullanici) {
        FirebaseFirestore.instance
            .collection("Hastalar")
            .doc(emailControllerHasta.text)
            .set({"Email": emailControllerHasta.text}).whenComplete(() => print(
                "Kullanıcı oluşturulup veritabanında Hastalar koleksiyonuna hasta profili ekledi."));
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginTabBar())));
    }

    TextEditingController emailControllerDoktor = TextEditingController();
    TextEditingController passwordControllerDoktor = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          children: <Widget>[
            const AnaEkrangif(),
            Text(
              "Hasta Kaydı",
              style: Theme.of(context).textTheme.headline4,
            ),
            textGirdileri(
                alinacakBilgi: emailControllerDoktor,
                dekorasyon: girisMailDekorasyonu(),
                ilerleme: TextInputAction.next,
                isAutofocus: true,
                isObscureText: false),
            textGirdileri(
                alinacakBilgi: passwordControllerDoktor,
                dekorasyon: girisSifreDekorasyonu(),
                ilerleme: TextInputAction.none,
                isAutofocus: false,
                isObscureText: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginTabBar()));
                  },
                  /* 
                  style: ElevatedButton.styleFrom(), */
                  child: Text(
                    Stringler.kullaniciGiris,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  /* 
                  style: ElevatedButton.styleFrom(), */
                  onPressed: kayitolHasta,
                  child: Text("Kayıt ol",
                      style: Theme.of(context).textTheme.headline2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
