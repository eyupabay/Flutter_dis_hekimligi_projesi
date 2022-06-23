import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
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
    //textfield controller
    TextEditingController emailControllerHasta = TextEditingController();
    TextEditingController passwordControllerHasta = TextEditingController();

    Future<void> kayitolHasta() async {
      //HASTALAR İÇİN
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailControllerHasta.text,
              password: passwordControllerHasta.text)
          .then((kullanici) {
        FirebaseFirestore.instance
            .collection("Hastalar")
            .doc(emailControllerHasta.text)
            .set({
          "role": "hasta",
          "Email": emailControllerHasta.text
        }).whenComplete(() => print(
                "Kullanıcı oluşturulup veritabanında Hastalar koleksiyonuna hasta profili ekledi."));
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginTabBar())));
    }

    TextEditingController emailControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
    TextEditingController passwordControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

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
              "Hasta Kaydı",
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
                  onPressed: kayitolHasta,
                  child: Text(
                    "Hasta kaydı",
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
