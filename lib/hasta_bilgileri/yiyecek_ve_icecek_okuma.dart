import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final yemek = TextEditingController();
final icecek = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

Query yiyeceklerRef = FirebaseFirestore.instance
    .collection("Musteriler")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("Yiyecekler")
    .orderBy("Saat", descending: true);

Query iceceklerRef = FirebaseFirestore.instance
    .collection("Musteriler")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("İçecekler")
    .orderBy("Saat", descending: true);

Future<void> veriEkle() async {
  if (yemek.text != "") {
    FirebaseFirestore.instance
        .collection("Musteriler")
        .doc(auth.currentUser!.email)
        .collection("Yiyecekler")
        .doc()
        .set({
      "KullaniciUID": auth.currentUser!.uid,
      "Yemek": yemek.text,
      "Saat": DateTime.now().toString()
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı yiyecek verisi ekledi."));
  }

  if (icecek.text != "") {
    FirebaseFirestore.instance
        .collection("Musteriler")
        .doc(auth.currentUser!.email)
        .collection("İçecekler")
        .doc()
        .set({
      "KullaniciUID": auth.currentUser!.uid,
      "İçecek": icecek.text,
      "Saat": DateTime.now().toString()
    }).whenComplete(() => print(
            "${auth.currentUser!.email} kullanıcısı içecek verisi ekledi."));
  }
}

class yiyecekleriOkuma extends StatelessWidget {
  const yiyecekleriOkuma({
    Key? key,
    required this.yiyeceklerRef,
  }) : super(key: key);

  final Query<Object?> yiyeceklerRef;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: yiyeceklerRef
            .snapshots(), //yiyeceklerRef değişkenindeki tüm verileri çek
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            //Veri çekilene kadar dönen çarkta loading ekranı ver
            return const CircularProgressIndicator();
          }
          List<DocumentSnapshot> listofDocsSnap = snapshot.data!.docs;
          //Hedefte gösterdiğimiz verilerin dökümanlarını dinle
          return Flexible(
            child: ListView.builder(
                //Ekranda verileri listelemesi için yapı oluşturucu
                itemCount: listofDocsSnap
                    .length, //Verilerin uzunluğu(listede veri kadar kaplayacak uzunluk)
                itemBuilder: (context, index) {
                  return Card(
                    //Kart şeklinde gözükmesi için
                    color: Theme.of(context).cardColor,
                    elevation: 2.0,
                    child: ListTile(
                      //Liste oluşturulsun ve istediğimiz gibi aşağı kaydırabilelim
                      title: Text(
                        listofDocsSnap[index].get("Yemek"),
                        //  Yiyecekleri dinlemek istediğimiz için veritabanında dökümanların her bir
                        //indeksindeki ".get()" fonksiyonu ile istediğimiz alandaki veriyi çekiyoruz.
                        style:
                            const TextStyle(fontSize: 14.0, letterSpacing: 1.2),
                      ),
                      subtitle: Text(listofDocsSnap[index].get("Saat")),
                      trailing: IconButton(
                          onPressed: () async {
                            await listofDocsSnap[index].reference.delete();
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  );
                }),
          );
        });
  }
}

class icecekleriOkuma extends StatelessWidget {
  const icecekleriOkuma({
    Key? key,
    required this.iceceklerRef,
  }) : super(key: key);

  final Query<Object?> iceceklerRef;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: iceceklerRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            return const CircularProgressIndicator();
          }
          List<DocumentSnapshot> listofDocsSnap = snapshot.data!.docs;
          return Flexible(
            child: ListView.builder(
              itemCount: listofDocsSnap.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).cardColor,
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(
                      listofDocsSnap[index].get("İçecek"),
                      style: const TextStyle(fontSize: 14, letterSpacing: 1.2),
                    ),
                    subtitle: Text(listofDocsSnap[index].get("Saat")),
                    trailing: IconButton(
                        onPressed: () async {
                          await listofDocsSnap[index].reference.delete();
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            ),
          );
        });
  }
}