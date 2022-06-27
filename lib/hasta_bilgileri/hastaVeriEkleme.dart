import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final yemekler = TextEditingController();
final icecekler = TextEditingController();
final gorevler = TextEditingController();

final isim = TextEditingController();
final soyisim = TextEditingController();
final yas = TextEditingController();
final sikayet = TextEditingController();
final telefon = TextEditingController();

String tarihGun = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();

String saatBilgisi = DateFormat("HH:mm").format(DateTime.now());
String gunBilgisi = DateFormat("dd-MM-yyyy").format(DateTime.now()).toString();
/* "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"; */

Future<void> yeIcVeriEkle() async {
  hastaVeriEkle().then((value) => {yemekler.clear(), icecekler.clear()});
}

Future<void> profilSet() async {
  profilBilgileriSet().then((value) => {
        isim.clear(),
        soyisim.clear(),
        yas.clear(),
        sikayet.clear(),
        telefon.clear()
      });
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

Future<void> profilBilgileriSet() async {
  if (isim.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Bilgiler")
        .doc("Bilgilerim")
        .update({"İsim": isim.text}).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı tarihinde isim verisi ekledi."));
  }

  if (soyisim.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Bilgiler")
        .doc("Bilgilerim")
        .update({
      "Soyisim": soyisim,
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı tarihinde soyisim verisi ekledi."));
  }

  if (yas.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Bilgiler")
        .doc("Bilgilerim")
        .update({
      "Yaş": yas,
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı tarihinde yaş verisi ekledi."));
  }
  if (sikayet.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Bilgiler")
        .doc("Bilgilerim")
        .update({
      "Şikayet": sikayet,
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı tarihinde şikayet verisi ekledi."));
  }
  if (telefon.text != "") {
    FirebaseFirestore.instance
        .collection("Hastalar")
        .doc(auth.currentUser!.email)
        .collection("Bilgiler")
        .doc("Bilgilerim")
        .update({
      "Telefon": telefon,
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı tarihinde telefon verisi ekledi."));
  }
}
