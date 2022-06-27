import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/hasta/profil_bilgileri.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_signUp.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/profil_sayfasi.dart';
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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getDataHasta() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Hastalar').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (emailController.text.toString().toLowerCase() !=
          querySnapshot.docs[i]["Email"]) {
        print("Hasta bulunamadı.");
      } else {
        print("Hasta bulunamadı, diğer fonksiyona geçiliyor...");
        var querySnapshot =
            await FirebaseFirestore.instance.collection('Hastalar').get();
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          if (emailController.text.toString().toLowerCase() !=
              querySnapshot.docs[i]["Email"]) {
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
                      child: const Text('Tamam'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => NavigationBarHasta()));
            print("Hasta bulundu.");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          children: <Widget>[
            const AnaEkrangif(),
            Text(
              "Hasta Girişi",
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
                CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUpTabBar()));
                  },
                  /* 
                  style: ElevatedButton.styleFrom(), */
                  child: Text(
                    Stringler.kayitOl,
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
                  onPressed: () async {
                    User? user = await emailsifreGiris(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      /* return getDataHasta(); */
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NavigationBarHasta()));
                    }
                  },
                  child: Text(
                    "Giriş yap",
                    style: Theme.of(context).textTheme.headline2,
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
