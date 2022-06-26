import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final yemekler = TextEditingController();
final icecekler = TextEditingController();
final gorevler = TextEditingController();

String tarihGun = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

String saatBilgisi = DateFormat("HH:mm").format(DateTime.now());
String gunBilgisi = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
/* "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"; */

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
      "Yemek": yemekler.text.toUpperCase(),
      "Gün": gunBilgisi,
      "Saat": saatBilgisi
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı $gunBilgisi tarihinde yiyecek verisi ekledi."));
  }

  if (icecekler.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("İçecekler")
        .doc()
        .set({
      "KullaniciUID": auth.currentUser!.uid,
      "İçecek": icecekler.text.toUpperCase(),
      "Gün": gunBilgisi,
      "Saat": saatBilgisi
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı $gunBilgisi tarihinde içecek verisi ekledi."));
  }
}
