import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/logging/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_doktor.dart';
import 'package:flutter_uygulama_deniyorum/models/arayuzAltPanel_hasta.dart';
import '../rol_mekanizmasi.dart';
import '../stringler.dart';
import "package:flutter_uygulama_deniyorum/sayfalar/ana_menu(hasta).dart";
import 'package:flutter_uygulama_deniyorum/sayfalar/sign_up_page.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class KararYeri extends StatelessWidget {
  KararYeri({Key? key}) : super(key: key);

  TextEditingController emailController =
      TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı
  TextEditingController passwordController =
      TextEditingController(); //Yazılan Textfield yerine eşitlenecek değişken adı

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    //FutureBuilder olarak değiştir
    //future yerine firebase içerisindeki tüm verileri gezme metodunu ata
    /* return FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          print("StreamBuilder baslatıldı.");
          if (snapshot.hasData && snapshot.data != null) {
            print("snapshot'ların icerisinin bos olmadıgı gozlemlendi.");

            if (snapshot.hasData && snapshot.data != null) {
              var userDoc = snapshot.data();
              var user = userDoc!;
              if (user["role"] == "doktor") {
                print("Doktor giriş yaptı.");
                return const EnAltBarDoktor();
              } else {
                print("Hasta giriş yaptı.");
                return const EnAltBar();
              }
            } else {
              return const Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          return const LoginPage();
        }); */
  }
}
