import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_loginPage.dart';
import 'package:flutter_uygulama_deniyorum/sayfalar/doktor/loginPage_doktor.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
            primaryColor: Colors.teal[300],
          ),
          iconTheme: IconThemeData(color: Colors.teal[400]),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            primary: Colors.teal[300],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          )),
          inputDecorationTheme: InputDecorationTheme(
              hintStyle:
                  GoogleFonts.nunito(color: Colors.grey[700], fontSize: 15.0),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)))),
          tabBarTheme: const TabBarTheme(
            labelColor: Color.fromARGB(255, 0, 94, 83),
            unselectedLabelColor: Color.fromARGB(103, 0, 121, 107),
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.all(4.0),
          ),
          indicatorColor: Colors.green,
          bottomAppBarTheme:
              const BottomAppBarTheme(shape: CircularNotchedRectangle()),
          backgroundColor: Colors.blue[400],
          textTheme: TextTheme(
              headline2:
                  GoogleFonts.nunito(fontSize: 20.0, color: Colors.black),
              headline4: GoogleFonts.nunito(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              bodyText1: GoogleFonts.nunito(
                  fontSize: 18.0, fontWeight: FontWeight.w400),
              bodyText2: GoogleFonts.nunito(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w200), //Veri ekleme buton teması
              labelMedium: GoogleFonts.nunito(
                  fontSize: 14.0, fontWeight: FontWeight.w600)),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.teal,
          cardColor: Color(0xff53b2d4),
          cardTheme: CardTheme(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0))),
          secondaryHeaderColor: Colors.green[300]),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginTabBar();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
