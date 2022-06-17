import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hasta_sayfa_bilgileri.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final yemekler = TextEditingController();
final icecekler = TextEditingController();

Future<void> yeIcVeriEkle() async {
  hastaVeriEkle().then((value) => {yemekler.clear(), icecekler.clear()});
}

Future<void> hastaVeriEkle() async {
  if (yemekler.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Yiyecekler")
        .doc()
        .set({
      "KullaniciUID": auth.currentUser!.uid,
      "Yemek": yemekler.text,
      "Saat": DateTime.now().toString()
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı yiyecek verisi ekledi."));
  }

  if (icecekler.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("İçecekler")
        .doc()
        .set({
      "KullaniciUID": auth.currentUser!.uid,
      "İçecek": icecekler.text,
      "Saat": DateTime.now().toString()
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı içecek verisi ekledi."));
  }
}
