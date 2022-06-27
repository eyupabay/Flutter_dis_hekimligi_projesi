import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hastaKaydet.dart';
import 'package:flutter_uygulama_deniyorum/main.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hastaProfil.dart';

TextField textGirdileri(
    {required TextEditingController alinacakBilgi,
    required InputDecoration dekorasyon,
    required bool isAutofocus,
    required TextInputAction ilerleme,
    required bool isObscureText}) {
  return TextField(
    textInputAction: TextInputAction.next,
    obscureText: isObscureText,
    autofocus: isAutofocus,
    controller: alinacakBilgi,
    keyboardType: TextInputType.emailAddress,
    decoration: dekorasyon,
  );
}

InputDecoration girisSifreDekorasyonu() {
  return const InputDecoration(
    hintText: "Şifre",
    prefixIcon: Icon(
      CupertinoIcons.lock,
      color: Colors.black,
    ),
  );
}

InputDecoration girisMailDekorasyonu() {
  return const InputDecoration(
    hintText: "Email adresi",
    prefixIcon: Icon(
      CupertinoIcons.mail,
      color: Colors.black,
    ),
  );
}

class CikisYap extends StatelessWidget {
  const CikisYap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      },
      icon: const Icon(Icons.logout_sharp),
    );
  }
}

class HastaEklemeButonu extends StatelessWidget {
  const HastaEklemeButonu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const KayitEtHasta()));
      },
      icon: const Icon(CupertinoIcons.person_add),
    );
  }
}

class HastaProfilDetaylari extends StatelessWidget {
  const HastaProfilDetaylari({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HastaninProfilDetaylari()));
      },
      icon: const Icon(CupertinoIcons.gear),
    );
  }
}
