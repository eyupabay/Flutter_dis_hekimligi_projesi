import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../logging/log_islemleri.dart';
import 'login_page.dart';
import '../stringler.dart';

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
      }).whenComplete(() => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage())));
    }

    return Scaffold(
      appBar: AppBar(
        //Ekranın en üstünde bir bar açar
        leadingWidth: double.infinity,
        title: Center(
          child: Text(
            Stringler.uygulamaAdi,
            //textAlign: TextAlign.center,
            style: Theme.of(context).appBarTheme.titleTextStyle,
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
              margin: const EdgeInsets.only(bottom: 10),
              child: Image.asset('assets/images/tooth.png'),
            ),
            Text(
              Stringler.kayitOlmaPaneli,
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
              onPressed: kayitol,
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
