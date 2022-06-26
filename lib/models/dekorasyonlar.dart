import 'package:flutter/material.dart';

TextField hastaVeriAvcisi(
    {required TextEditingController eklenecekVeri,
    required InputDecoration veriDekorasyonu}) {
  return TextField(
      controller: eklenecekVeri,
      keyboardType: TextInputType.text,
      decoration: veriDekorasyonu);
}

TextField doktorGorevAvcisi(
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
  );
}

InputDecoration gorevDekorasyonu() {
  return const InputDecoration(
    hintText: "Atamak istediğiniz görev",
    prefixIcon: Icon(Icons.call_missed_outgoing_outlined, color: Colors.black),
  );
}

InputDecoration icecekDekorasyonu() {
  return const InputDecoration(
    hintText: "İçtiğiniz içecek",
    prefixIcon: Icon(Icons.local_drink, color: Colors.black),
  );
}

class AnaEkrangif extends StatelessWidget {
  const AnaEkrangif({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(bottom: 10),
      child: Image.asset('assets/images/tooth.gif'),
    );
  }
}
