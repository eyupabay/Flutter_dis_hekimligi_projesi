import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import '../rol_mekanizmasi.dart';
import '../sayfa_duzenleri.dart';
import '../stringler.dart';
import 'ana_menu(hasta).dart';
import 'sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Giris fonksiyonları
  static Future<User?> emailsifreGiris(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth =
        FirebaseAuth.instance; //Firebase Authentication çalıştırıyoruz.
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          //userCredential sınıfı içerisinde kayıtlı email aranıyor...
          email: email,
          password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      //userCredential içerisinde kayıtlı email yoksa ekrana bulunamadı yazdırıyor...
      if (e.code == "user-not-found") {
        print("Kullanici bulunamadi.");
      }
    }
    return user;
  }

  //textfield controller
  TextEditingController emailController =
      TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
  TextEditingController passwordController =
      TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

  Future getDataDoktor() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Doktorlar').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (emailController.text == querySnapshot.docs[i]["Email"]) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const EnAltBarDoktor()));
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Bir hata ile karşılaştınız'),
                    Text('Would you like to approve of this message?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Approve'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future getDataHasta() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Musteriler').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (emailController.text == querySnapshot.docs[i]["Email"]) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const EnAltBar()));
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Bir hata ile karşılaştınız'),
                    Text('Yanlış butona basmış olabilirsiniz.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('TAMAM'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ustBar(context: context, textYazisi: Stringler.karsila),
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
              Stringler.karsila,
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
                alinacakBilgi: passwordController,
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
                        builder: (context) => const SignUpPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    fixedSize: const Size(80, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    Stringler.kayitOl,
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
                      primary: Color(Theme.of(context).backgroundColor.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      fixedSize: const Size(140, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () async {
                    User? user = await emailsifreGiris(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      return getDataDoktor();
                    }
                  },
                  child: Text(
                    "Doktor Girişi",
                    style: Theme.of(context).textTheme.bodyText1,
                    textScaleFactor: 1.2,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(Theme.of(context).backgroundColor.blue),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      fixedSize: const Size(140, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () async {
                    User? user = await emailsifreGiris(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      return getDataHasta();
                    }
                  },
                  child: Text(
                    "Hasta Girişi",
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
