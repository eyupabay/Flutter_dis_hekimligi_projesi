import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_uygulama_deniyorum/main.dart';
import 'package:flutter_uygulama_deniyorum/profil_sayfasi.dart';
import 'ana_menu(hasta).dart';

class DoktorPanel extends StatefulWidget {
  const DoktorPanel({Key? key}) : super(key: key);

  @override
  DoktorPanelState createState() => DoktorPanelState();
}

class DoktorPanelState extends State<DoktorPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text(
          "Ana Sayfa",
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: const Icon(Icons.logout_sharp),
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
              //Hasta isimleri çekilecek.
              stream: hastalarRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }
                List<DocumentSnapshot> listofDocsSnap = snapshot.data!.docs;
                return Flexible(
                  child: ListView.builder(
                      itemCount: listofDocsSnap.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.indigo.shade100,
                          elevation: 2.0,
                          child: ListTile(
                            title: Text(
                              (listofDocsSnap[index].data() as Map)["Email"],
                              style: const TextStyle(
                                  fontSize: 14.0, letterSpacing: 1.2),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  StreamBuilder(
                                      stream: yiyeceklerRef.snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              hastaSnapshot) {
                                        if (hastaSnapshot.data == null) {
                                          return const CircularProgressIndicator();
                                        }
                                        List<DocumentSnapshot> yemeklistofdocs =
                                            hastaSnapshot.data!.docs;
                                        return Flexible(
                                          child: ListView.builder(
                                              itemCount: yemeklistofdocs.length,
                                              itemBuilder: (context, index) {
                                                return Card(
                                                  color: Colors.indigo.shade100,
                                                  elevation: 2.0,
                                                  child: ListTile(
                                                    title: Text(
                                                      yemeklistofdocs[index]
                                                          .get("Yemek"),
                                                      style: const TextStyle(
                                                          fontSize: 14.0,
                                                          letterSpacing: 1.2),
                                                    ),
                                                    subtitle: Text(
                                                        yemeklistofdocs[index]
                                                            .get("Saat")),
                                                  ),
                                                );
                                              }),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.navigate_next)),
                          ),
                        );
                      }),
                );
              }),
        ],
      ),
      bottomNavigationBar: enAltBar(context),
    );
  }

  int _selectedIndex = 0;

  List widgetOptions = [
    HomePage(),
    ProfilPage(),
  ];

  void _onItemTapped(
    int index,
  ) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Query yiyeceklerRef = FirebaseFirestore.instance
      .collection("Musteriler")
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection("Yiyecekler")
      .orderBy("Saat", descending: true);

  Query hastalarRef = FirebaseFirestore.instance.collection("Musteriler");
}
