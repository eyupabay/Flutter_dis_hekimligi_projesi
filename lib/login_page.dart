import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/ana_menu(hasta).dart';
import 'package:flutter_uygulama_deniyorum/rol_mekanizmasi.dart';
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
  Query doktor = FirebaseFirestore.instance
      .collection("Musteriler")
      .where("Doktor", isEqualTo: true);

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

    return Column(
      //Sütun döndürür..
      crossAxisAlignment: CrossAxisAlignment
          .center, //CrossAxisAlignment, Column üzerinde Row oluşturarak ortalayan koordinat
      children: <Widget>[
        AppBar(
          //Ekranın en üstünde bir bar açar
          leadingWidth: double.infinity, //Ekranın en üstünü boydan boya kaplar
          backgroundColor: Colors.blueGrey.shade900, //Renk verir
          title: const Center(
            child: Text(
              Stringler.uygulamaAdi,
              //textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
        const BoslukOlustur(),
        const Text(
          Stringler.kullaniciGiris,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red, fontSize: 30.0),
        ),
        const BoslukOlustur(),
        kayitMailBilgileri(emailController),
        const BoslukOlustur(),
        kayitSifreBilgileri(passwordController),
        const BoslukOlustur(),
        ElevatedButton(
          onPressed: kayitol,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(20.0)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
            backgroundColor: MaterialStateProperty.all(const Color(0xFF0069FE)),
          ),
          child: const Text(Stringler.kayitOl),
        ),
        const BoslukOlustur(),
        //
        //
        //Giriş yapma fonksiyonları
        //
        //
        SizedBox(
          width: double.infinity,
          child: RawMaterialButton(
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
            fillColor: const Color(0xFF0069FE),
            padding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: const Text(
              "Giriş yap",
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        )
      ],
    );
  }

  TextField kayitSifreBilgileri(TextEditingController passwordController) {
    return TextField(
      controller: passwordController,
      obscureText: true, //Parola gizleme fonksiyonu
      decoration: const InputDecoration(
        hintText: "Şifre",
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
      ),
    );
  }

  TextField kayitMailBilgileri(TextEditingController emailController) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: "Email adresi",
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
        ),
      ),
    );
  }
}



/*giriş yapma
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
     */       