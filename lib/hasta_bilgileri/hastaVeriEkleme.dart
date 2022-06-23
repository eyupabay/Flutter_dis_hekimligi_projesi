import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hasta_listesi.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final yemekler = TextEditingController();
final icecekler = TextEditingController();
final gorevler = TextEditingController();

String tarihGun = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
String gunVeSaat =
    "${DateFormat("yyyy-MM-dd").format(DateTime.now())}  ${DateFormat("HH:mm").format(DateTime.now())}";

Future<void> yeIcVeriEkle() async {
  hastaVeriEkle().then((value) => {yemekler.clear(), icecekler.clear()});
}

Future<void> gorevYaz() async {
  doktorGorevVer().then((value) => {gorevler.clear()});
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
      "Saat": gunVeSaat
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
      "Saat": gunVeSaat
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı içecek verisi ekledi."));
  }
}

Future<void> doktorGorevVer() async {
  if (gorevler.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(tiklanilanHasta)
        .collection("Gorevler")
        .doc()
        .set({"gorev": gorevler.text, "Saat": tarihGun}).whenComplete(
            () => print("$tiklanilanHasta kullanıcısına görev verisi ekledi."));
  }
}
