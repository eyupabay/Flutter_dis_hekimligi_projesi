import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_uygulama_deniyorum/main.dart';

TextField textGirdileri(
    TextEditingController alinacakBilgi,
    InputDecoration dekorasyon,
    bool isAutofocus,
    TextInputAction ilerleme,
    bool isObscureText) {
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
    border: OutlineInputBorder(),
    hintText: "Şifre",
    prefixIcon: Icon(
      Icons.lock,
      color: Colors.black,
    ),
  );
}

InputDecoration girisMailDekorasyonu() {
  return const InputDecoration(
    border: OutlineInputBorder(),
    hintText: "Email adresi",
    prefixIcon: Icon(
      Icons.mail,
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
