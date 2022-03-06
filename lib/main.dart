import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_fire/screens/HomePage.dart';
import 'package:flutter_fire/screens/SignUpPage.dart';
import 'package:flutter_fire/services/Auth_Service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  checkLogin() async {
    String? tokne = await authClass.getToken();
    print("tokne");
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}







// ***************************************************
// Future main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp( MyApp());
// }
//
// class MyApp extends StatelessWidget {
//
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//    MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           print('${snapshot.error}');
//         }
//
//         // Once complete, show your application
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Flutter Demo',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//             home: RouteBasedOnAuth(),
//             // home: HomePage(),
//           );
//         }
//
//         // Otherwise, show something whilst waiting for initialization to complete
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//     Text('Welcome'),
//     MaterialButton(child: Text('Sign out'),
//       color: Colors.blue,
//       onPressed: (){},
//     )
//           ],
//         ),
//       ),
//     );
//   }
//   }



//******************************************************

