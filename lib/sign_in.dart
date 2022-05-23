import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/login_page.dart';
import 'package:flutter_uygulama_deniyorum/stringler.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
        padding:
            const EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 15),
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
              Stringler.kayitOl,
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
                        builder: (context) => const LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    fixedSize: const Size(120, 20),
                  ),
                  child: const Text(
                    Stringler.kullaniciGiris,
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
              onPressed: kayitol,
              child: const Text(
                "Kayıt Ol",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
