import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uygulama_deniyorum/models/ustPanel_loginPage.dart';

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
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: EdgeInsets.all(4.0)),
          bottomAppBarTheme:
              const BottomAppBarTheme(shape: CircularNotchedRectangle()),
          backgroundColor: Colors.blue[400],
          textTheme: TextTheme(
              headline4: const TextStyle(color: Colors.black),
              bodyText1: const TextStyle(color: Colors.black),
              labelMedium: TextStyle(color: Colors.blue[700])),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.red,
          cardColor: Colors.blue[200],
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
