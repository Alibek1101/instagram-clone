

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/auth/splash.dart';
import 'package:untitled/page/main_page.dart';

import 'auth/sign_in.dart';
import 'auth/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC3zSAe1CNG-mjxu6N2w6etZi9qG1kHdzw",
            authDomain: "instagram2-da1b1.firebaseapp.com",
            projectId: "instagram2-da1b1",
            storageBucket: "instagram2-da1b1.appspot.com",
            messagingSenderId: "211680867090",
            appId: "1:211680867090:web:d2f996d562e492ac51f9cb",
            measurementId: "G-YFPSPVDWJ8"
        ));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyCJq38h_zyE_iSrqVxeinAV92rPAcWeRTE',
          appId: '1:211680867090:android:58873f485b646dc551f9cb',
          messagingSenderId: 'messagingSenderId',
          projectId: 'instagram2-da1b1',
          storageBucket: 'instagram2-da1b1.appspot.com',
        )
    );
  }

  runApp(const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  Splash_Page(),
        routes: {
          Log_In.id:(context)=> Log_In(),
          Sing_Up.id:(context)=> Sing_Up(),
          Home_page.id:(context)=> Home_page()
        }

    );
  }
}