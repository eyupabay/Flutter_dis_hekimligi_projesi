import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
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
    TextEditingController emailControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
    TextEditingController passwordControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

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
          "role": "doktor",
          "Email": emailControllerDoktor.text
        }).whenComplete(() => print(
                "Kullanıcı oluşturulup veritabanında Doktorlar koleksiyonuna hasta profili ekledi."));
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginTabBar())));
    }

    return Scaffold(
      /* appBar: ustBar(context: context, textYazisi: Stringler.uygulamaAdi), */
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          //Sütun döndürür..
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 150,
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/images/tooth.gif'),
            ),
            Text(
              "Doktor Kaydı",
              textAlign: TextAlign.center,
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
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginTabBar()));
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      fixedSize: const Size(100, 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  child: Text(
                    Stringler.kullaniciGiris,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal[300],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    fixedSize: const Size(140, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: kayitolDoktor,
                  child: Text(
                    "Doktor kaydı",
                    style: Theme.of(context).textTheme.bodyText1,
                    textScaleFactor: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
