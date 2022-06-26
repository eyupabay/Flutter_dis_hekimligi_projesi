import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_loginPage.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class SignUpDoktor extends StatefulWidget {
  const SignUpDoktor({Key? key}) : super(key: key);

  @override
  _SignUpDoktorState createState() => _SignUpDoktorState();
}

class _SignUpDoktorState extends State<SignUpDoktor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailControllerDoktor = TextEditingController();
    TextEditingController passwordControllerDoktor = TextEditingController();

    Future<void> kayitolDoktor() async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailControllerDoktor.text,
              password: passwordControllerDoktor.text)
          .then((kullanici) {
        FirebaseFirestore.instance
            .collection("Doktorlar")
            .doc(emailControllerDoktor.text)
            .set({
          "Email": emailControllerDoktor.text
        }).whenComplete(() => print(
                "Kullanıcı oluşturulup veritabanında Doktorlar koleksiyonuna hasta profili ekledi."));
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginTabBar())));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          children: <Widget>[
            const AnaEkrangif(),
            Text(
              "Doktor Kaydı",
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
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  ), */
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
                  onPressed: kayitolDoktor,
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
