import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_hasta.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_signUp.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class LoginPageHasta extends StatefulWidget {
  const LoginPageHasta({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageHasta> {
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getDataHasta() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Hastalar').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (emailController.text == querySnapshot.docs[i]["Email"]) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const EnAltBar()));
        break;
      } else {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hata'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('Bir hata ile karşılaştınız'),
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
      /*  appBar: ustBar(context: context, textYazisi: Stringler.karsila), */
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
                        builder: (context) => const SignUpTabBar()));
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
