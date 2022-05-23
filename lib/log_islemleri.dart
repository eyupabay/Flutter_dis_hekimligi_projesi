import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_uygulama_deniyorum/main.dart';

TextField kayitSifreBilgileri(TextEditingController passwordController) =>
    TextField(
      controller: passwordController,
      obscureText: true, //Parola gizleme fonksiyonu
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Şifre",
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
      ),
    );

TextField kayitMailBilgileri(TextEditingController emailController) =>
    TextField(
      textInputAction: TextInputAction.next,
      autofocus: true,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Email adresi",
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.black,
        ),
      ),
    );

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
