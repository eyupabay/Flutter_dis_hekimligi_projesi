import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/sign_in.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

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

  @override
  Widget build(BuildContext context) {
    //textfield controller
    TextEditingController emailController =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
    TextEditingController passwordController =
        TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

    Future<void> kayitol() async {
      //HASTALAR İÇİN
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              //Email ile kullanıcı oluşturmak için kullanılan Firebase fonksiyonu
              email: emailController.text,
              password: passwordController.text)
          .then((kullanici) {
        FirebaseFirestore.instance
            .collection("Musteriler")
            .doc(emailController.text)
            .set({
          "role": "hasta",
          "Email": emailController.text
        }).whenComplete(() => print(
                "Kullanıcı oluşturulup veritabanında Musteriler koleksiyonuna hasta profili ekledi."));
      });
    }

    return Scaffold(
      appBar: AppBar(
        //Ekranın en üstünde bir bar açar
        leadingWidth: double.infinity,
        title: Center(
          child: Text(
            Stringler.uygulamaAdi,
            //textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[120]),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 5),
        child: Column(
          //Sütun döndürür..
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 150,
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset('assets/images/tooth.png'),
            ),
            const Text(
              Stringler.karsila,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 30.0),
            ),
            kayitMailBilgileri(emailController),
            kayitSifreBilgileri(passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SigninPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    fixedSize: const Size(80, 60),
                  ),
                  child: const Text(
                    Stringler.kayitOl,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                fixedSize: const Size(170, 60),
              ),
              onPressed: () async {
                //const kararYeri();
                User? user = await emailsifreGiris(
                    email: emailController.text,
                    password: passwordController.text,
                    context: context);
                print(user);
                if (user != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HastaPaneli()));
                  //Navigate ile ilerideki sayfaya yönlendirdik.
                }
              },
              child: const Text(
                "Giriş yap",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
