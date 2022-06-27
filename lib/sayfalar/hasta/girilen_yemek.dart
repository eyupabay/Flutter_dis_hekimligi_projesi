import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/AltNavigationHasta.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class GirilenYemekSayfasi extends StatefulWidget {
  const GirilenYemekSayfasi({Key? key}) : super(key: key);

  @override
  State<GirilenYemekSayfasi> createState() => _GirilenYemekSayfasiState();
}

class _GirilenYemekSayfasiState extends State<GirilenYemekSayfasi> {
  DateTime? _chosenDateTime;

  void _showDatePicker(context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        dateOrder: DatePickerDateOrder.dmy,
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        maximumYear: DateTime.now().year,
                        minimumYear: DateTime.now().year - 1,
                        maximumDate: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),
                  CupertinoButton(
                    child: const Text('SEÇ'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    String secilenTarih =
        "${_chosenDateTime?.day}-${_chosenDateTime?.month.toString().padLeft(2, "0")}-${_chosenDateTime?.year}";
    return Scaffold(
      appBar: ustBar(
        context: context,
        textYazisi: "Yemek bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarHasta()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          CupertinoButton(
            padding: EdgeInsetsDirectional.zero,
            child: const Text('Tarihlere filtrele'),
            onPressed: () => _showDatePicker(context),
          ),
          Text(_chosenDateTime != null
              ? "${_chosenDateTime?.day}-${_chosenDateTime?.month.toString().padLeft(2, "0")}-${_chosenDateTime?.year}"
              : 'Herhangi bir tarih seçilmedi.'),
          HastaBilgileriOkuma(
              okunacakBilgi: FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(auth.currentUser?.email)
                  .collection("Yiyecekler")
                  .where("Gün", isEqualTo: secilenTarih),
              okunacakBilgiKlasoru: "Yemek"),
        ]),
      ),
    );
  }
}
