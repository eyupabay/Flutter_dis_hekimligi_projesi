import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final yemek = TextEditingController();
final icecek = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

/* var doktorMailiOgren = StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('Hastalar')
        .doc(auth.currentUser?.email)
        .snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Text("Loading");
      }
      var userDocument = snapshot.data;
      return Text(userDocument!["doktorMaili"]);
    });
 */

Query gorevlerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("Gorevler")
    .orderBy("Saat", descending: true);

Query yiyeceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("Yiyecekler")
    .orderBy("Saat", descending: true);

Query iceceklerRef = FirebaseFirestore.instance
    .collection("Hastalar")
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection("İçecekler")
    .orderBy("Saat", descending: true);

class HastaBilgileriOkuma extends StatefulWidget {
  HastaBilgileriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  late Query<Object?> okunacakBilgi;
  late String okunacakBilgiKlasoru;

  @override
  State<HastaBilgileriOkuma> createState() => _HastaBilgileriOkumaState();
}

class _HastaBilgileriOkumaState extends State<HastaBilgileriOkuma> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.okunacakBilgi.snapshots(),
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
                    child: ListTile(
                      title: Text(
                          listofDocsSnap[index]
                              .get(widget.okunacakBilgiKlasoru),
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text(listofDocsSnap[index].get("Saat"),
                          style: Theme.of(context).textTheme.bodyText2),
                      trailing: IconButton(
                          onPressed: () async {
                            await listofDocsSnap[index].reference.delete();
                          },
                          icon: const Icon(CupertinoIcons.trash_fill)),
                    ),
                  );
                }),
          );
        });
  }
}

class HastaGorevleriOkuma extends StatefulWidget {
  HastaGorevleriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  late Query<Object?> okunacakBilgi;
  late String okunacakBilgiKlasoru;

  @override
  State<HastaGorevleriOkuma> createState() => _HastaGorevleriOkumaState();
}

class _HastaGorevleriOkumaState extends State<HastaGorevleriOkuma> {
  bool gorevYapildiMi = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.okunacakBilgi.snapshots(),
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
                    child: ListTile(
                      title: Text(
                          listofDocsSnap[index]
                              .get(widget.okunacakBilgiKlasoru),
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text(
                        listofDocsSnap[index].get("Saat"),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          gorevYapildiMi =
                              listofDocsSnap[index].get("yapildi") as bool;

                          if (gorevYapildiMi == false) {
                            listofDocsSnap[index]
                                .reference
                                .update({"yapildi": true});
                          } else {
                            listofDocsSnap[index]
                                .reference
                                .update({"yapildi": false});
                          }
                          setState(() {
                            gorevYapildiMi = !gorevYapildiMi;
                          });
                        },
                        icon: Icon(
                            (listofDocsSnap[index].get("yapildi") as bool ==
                                    false)
                                ? CupertinoIcons.app
                                : CupertinoIcons.checkmark_square),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}

class DoktordanHastaBilgileriOkuma extends StatefulWidget {
  DoktordanHastaBilgileriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  late Query<Object?> okunacakBilgi;
  late String okunacakBilgiKlasoru;

  @override
  State<DoktordanHastaBilgileriOkuma> createState() =>
      _DoktordanHastaBilgileriOkumaState();
}

class _DoktordanHastaBilgileriOkumaState
    extends State<DoktordanHastaBilgileriOkuma> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.okunacakBilgi.snapshots(),
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
                    child: ListTile(
                      title: Text(
                          listofDocsSnap[index]
                              .get(widget.okunacakBilgiKlasoru),
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text(listofDocsSnap[index].get("Saat"),
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  );
                }),
          );
        });
  }
}

class DoktordanGorevleriOkuma extends StatefulWidget {
  DoktordanGorevleriOkuma({
    Key? key,
    required this.okunacakBilgi,
    required this.okunacakBilgiKlasoru,
  }) : super(key: key);

  late Query<Object?> okunacakBilgi;
  late String okunacakBilgiKlasoru;

  @override
  State<DoktordanGorevleriOkuma> createState() =>
      _DoktordanGorevleriOkumaState();
}

class _DoktordanGorevleriOkumaState extends State<DoktordanGorevleriOkuma> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.okunacakBilgi.snapshots(),
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
                    child: ListTile(
                      title: Text(
                          listofDocsSnap[index]
                              .get(widget.okunacakBilgiKlasoru),
                          style: Theme.of(context).textTheme.bodyText1),
                      subtitle: Text(listofDocsSnap[index].get("Saat"),
                          style: Theme.of(context).textTheme.bodyText2),
                      trailing: IconButton(
                          onPressed: () async {
                            await listofDocsSnap[index].reference.delete();
                          },
                          icon: const Icon(CupertinoIcons.trash)),
                    ),
                  );
                }),
          );
        });
  }
}
