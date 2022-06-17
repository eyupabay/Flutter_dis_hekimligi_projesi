import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/hasta_bilgileri/hastaVeriEkleme.dart';
import 'yiyecek_ve_icecek_okuma.dart';

TextField hastaVeriAvcisi(
    {required TextEditingController eklenecekVeri,
    required InputDecoration veriDekorasyonu}) {
  return TextField(
      controller: eklenecekVeri,
      keyboardType: TextInputType.text,
      decoration: veriDekorasyonu);
}

InputDecoration yiyecekDekorasyonu() {
  return const InputDecoration(
    hintText: "Yediğiniz yiyecek",
    prefixIcon: Icon(Icons.food_bank, color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}

InputDecoration icecekDekorasyonu() {
  return const InputDecoration(
    hintText: "İçtiğiniz içecek",
    prefixIcon: Icon(Icons.local_drink, color: Colors.black),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  );
}
