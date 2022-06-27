import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/log_islemleri.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/hastaProfil.dart';

import 'package:intl/intl.dart';
import 'package:flutter_uygulama_deniyorum/models/altNavigationDoktor.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/gorev_ver.dart';
import '../../logging/firebaseBilgileriOkuma.dart';
import 'package:flutter_uygulama_deniyorum/models/ustAppBar.dart';

class HastaVeriSayfasi extends StatefulWidget {
  var tiklanilanHasta;
  HastaVeriSayfasi({Key? key, this.tiklanilanHasta}) : super(key: key);

  @override
  State<HastaVeriSayfasi> createState() => _HastaVeriSayfasiState();
}

class _HastaVeriSayfasiState extends State<HastaVeriSayfasi> {
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
        textYazisi: "Hasta bilgileri",
        basIkon: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => NavigationBarDoktor()));
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
        aksiyon: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HastaninProfilDetaylari(
                        tiklanilanHasta: widget.tiklanilanHasta,
                      )));
            },
            icon: const Icon(CupertinoIcons.gear),
          )
        ],
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
          DoktordanHastaBilgileriOkuma(
              okunacakBilgi: FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(widget.tiklanilanHasta)
                  .collection("Yiyecekler")
                  .where("Gün", isEqualTo: secilenTarih),
              okunacakBilgiKlasoru: "Yemek"),
          const Divider(
            height: 20,
          ),
          DoktordanHastaBilgileriOkuma(
              okunacakBilgi: FirebaseFirestore.instance
                  .collection("Hastalar")
                  .doc(widget.tiklanilanHasta)
                  .collection("İçecekler")
                  .where("Gün", isEqualTo: secilenTarih),
              okunacakBilgiKlasoru: "İçecek"),
          CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => gorevVer(
                      tiklanilanHasta: widget.tiklanilanHasta,
                    ),
                  ),
                );
              },
              child: Text(
                "Atanan görevler",
                style: Theme.of(context).textTheme.bodyText1,
              )),
        ]),
      ),
    );
  }
}
