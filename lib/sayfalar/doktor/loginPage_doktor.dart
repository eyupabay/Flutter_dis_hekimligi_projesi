import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/models/dekorasyonlar.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_signUp.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class LoginPageDoktor extends StatefulWidget {
  const LoginPageDoktor({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPageDoktor> {
  static Future<User?> emailsifreGiris(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("Kullanici bulunamadi.");
      }
    }
    return user;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future getDataDoktor() async {
    var querySnapshot =
        await FirebaseFirestore.instance.collection('Doktorlar').get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (emailController.text.toString().toLowerCase() !=
          querySnapshot.docs[i]["Email"]) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            print("Doktor bulunamadı.");
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
            MaterialPageRoute(builder: (context) => NavigationBarDoktor()));
        print("Doktor bulundu");
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
              "Doktor Girişi",
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
                      return getDataDoktor();
                      /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const EnAltBarDoktor())); */
                    }
                  },
                  child: Text("Giriş yap",
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
