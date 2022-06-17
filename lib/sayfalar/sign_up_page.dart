import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../logging/log_islemleri.dart';
import 'login_page.dart';
import '../stringler.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    //textfield controller
    TextEditingController emailControllerHasta =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
    TextEditingController passwordControllerHasta =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

// İlk yaptığımız hasta kaydolma paneli ve ardından Firestore un Hastalar koleksiyonunda döküman açma emri.
    Future<void> kayitolHasta() async {
      //HASTALAR İÇİN
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              //Email ile kullanıcı oluşturmak için kullanılan Firebase fonksiyonu
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
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }

// Sonradan geliştirmeye çalıştırdığımız doktora atama emri.
    Future<void> kayitolHasta2() async {
      //HASTALAR İÇİN
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              //Email ile kullanıcı oluşturmak için kullanılan Firebase fonksiyonu
              email: emailControllerHasta.text,
              password: passwordControllerHasta.text)
          .then((kullanici) {
        FirebaseFirestore.instance.collection("Doktorlar").get().whenComplete(
            () => print(
                "Kullanıcı oluşturulup veritabanında Hastalar koleksiyonuna hasta profili ekledi."));
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }

    TextEditingController emailControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
    TextEditingController passwordControllerDoktor =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

    Future<void> kayitolDoktor() async {
      //HASTALAR İÇİN
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              //Email ile kullanıcı oluşturmak için kullanılan Firebase fonksiyonu
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
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }

    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.uygulamaAdi),
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
              Stringler.doktorKaydi,
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
                        builder: (context) => const LoginPage()));
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(Theme.of(context).backgroundColor.blue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                fixedSize: const Size(170, 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: kayitolDoktor,
              child: Text(
                Stringler.kayitOl,
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
