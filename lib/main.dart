import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_loginPage.dart';
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
          tabBarTheme: const TabBarTheme(
              labelColor: Color(0xff00796B),
              unselectedLabelColor: Color(0xffb2dfdb),
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.all(4.0)),
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
