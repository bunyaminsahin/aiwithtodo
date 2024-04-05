import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yapilacaklarnotlarlisteler/pages/home_page.dart';
import 'package:yapilacaklarnotlarlisteler/pages/singin_page.dart';

class MyMainPage extends StatelessWidget {
  const MyMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:
            HomePage() /* StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const SiginPage();
          }
        },
      ), */
        );
  }
}
