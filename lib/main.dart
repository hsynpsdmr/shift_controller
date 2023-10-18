import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shift_controller/qr_code_scanner.dart';
import 'package:shift_controller/theme/context_extansion.dart';
import 'package:shift_controller/verify_page.dart';
import 'firebase_options.dart';
import 'list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shift',
      home: const SplashScreen(),
      routes: {
        "/qr_code_scanner": (context) => const QRCodeScan(),
        "/verify_page": (context) => const VerifyPage(),
        "/list_page": (context) => const ListPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    wait();
  }

  Future wait() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) {
      if (auth.currentUser == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyPage()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ListPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: context.pmsSize.width / 2, height: context.pmsSize.width / 2, child: Image.asset('assets/images/shift_splash.jpg', fit: BoxFit.cover)),
            Container(height: 20),
            SizedBox(
              height: 5,
              width: context.pmsSize.width / 5,
              child: LinearProgressIndicator(valueColor: const AlwaysStoppedAnimation<Color>(Colors.grey), backgroundColor: Colors.grey[300]),
            ),
          ],
        ),
      ),
    );
  }
}
