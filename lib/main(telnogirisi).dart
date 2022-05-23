// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_uygulama_deniyorum/profil_ekrani.dart';
// import 'package:flutter_uygulama_deniyorum/veri_ekleme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueGrey,
//         title: const Text("Diş hekimliği Uygulaması"),
//         centerTitle: true,
//       ),
//       body: FutureBuilder(
//         future: _initializeFirebase(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return const LoginPage();
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   //Giris fonksiyonları
//   static Future<User?> telnosifreGiris() async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '+90 531 860 83 55',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         debugPrint("Doğrulama kodu yanlış.");
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         debugPrint("Kod gönderildi.");
//         try {
//           String smsCode = '123456';

//           // Create a PhoneAuthCredential with the code
//           PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: verificationId, smsCode: smsCode);

//           // Sign the user in (or link) with the credential
//           await _auth.signInWithCredential(credential);
//         } catch (e) {
//           debugPrint("Kod hata. $e");
//         }
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         debugPrint("Kod zaman aşımına uğradı.");
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //textfield controller
//     TextEditingController _phoneController = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Diş Sağlığı Uygulaması",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.black, fontSize: 50.0),
//           ),
//           const Text(
//             "Kullanıcı Girişi",
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.red, fontSize: 30.0),
//           ),
//           const SizedBox(
//             height: 25.0,
//           ),
//           TextField(
//             controller: _phoneController,
//             keyboardType: TextInputType.phone,
//             decoration: const InputDecoration(
//                 hintText: "Telefon No",
//                 prefixIcon: Icon(
//                   Icons.phone_android,
//                   color: Colors.black,
//                 )),
//           ),
//           const SizedBox(
//             height: 25.0,
//           ),
//           Container(
//             width: double.infinity,
//             child: RawMaterialButton(
//               onPressed: () async {
//                 User? user = await telnosifreGiris();
//                 print(user);
//                 if (user != null) {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       builder: (context) => const ProfilEkrani()));
//                   //Profil Ekranı olusturuyoruz.
//                 }
//               },
//               fillColor: const Color(0xFF0069FE),
//               elevation: 0.0,
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0)),
//               child: const Text(
//                 "Giris yap",
//                 style: TextStyle(color: Colors.white, fontSize: 18.0),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class _auth {
//   static signInWithCredential(PhoneAuthCredential credential) {}
// }
