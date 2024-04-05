import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:yapilacaklarnotlarlisteler/pages/singin_page.dart';

import 'package:yapilacaklarnotlarlisteler/service/database.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/my_alert_dialog_with_login.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/my_alert_dialog_without_login.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/today_tomorrow_next_week.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool today = true, tomorrow = false, nextweek = false;
  bool suggest = false;
  Stream? todoStream;

  getontheload() async {
    todoStream = await DatabaseMethods().getalltheWork(today
        ? "Today"
        : tomorrow
            ? "Tomorrow"
            : "NextWeek");
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allWork() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          final loginDone = snapshot.hasData && snapshot.data != null;

          return const SizedBox();
        });
  }

  TextEditingController todoController = TextEditingController();
  List<Color> MyGradientColors = [
    const Color(0xff232fda2),
    const Color(0XFF13D8CA),
    const Color(0XFF09ADFE),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "✓&✓",
          style: TextStyle(color: Colors.white, fontFamily: "Lunada"),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyGradientColors),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: MyGradientColors),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Merhaba",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            const Text(
              "Yapılacaklar & Notlar & Listeler",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  today
                      ? const TodayTomorrowNextWeekWidget(time: "Bugün")
                      : GestureDetector(
                          onTap: () async {
                            today = true;
                            tomorrow = false;
                            nextweek = false;
                            await getontheload();
                            setState(() {});
                          },
                          child: Text("Bugün",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14)),
                        ),
                  tomorrow
                      ? const TodayTomorrowNextWeekWidget(time: "Yarın")
                      : GestureDetector(
                          onTap: () async {
                            today = false;
                            tomorrow = true;
                            nextweek = false;
                            await getontheload();
                            setState(() {});
                          },
                          child: Text("Yarın",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14)),
                        ),
                  nextweek
                      ? const TodayTomorrowNextWeekWidget(time: "Gelecek Hafta")
                      : GestureDetector(
                          onTap: () async {
                            today = false;
                            tomorrow = false;
                            nextweek = true;
                            await getontheload();
                            setState(() {});
                          },
                          child: Text("Gelecek Hafta",
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14)),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            allWork(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: const Color(0xFF3DFFE3),
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ); */
        },
        child: Icon(Icons.add, color: Colors.grey[800]),
      ),
    );
  }

  /* Future openBox() => showDialog(
      context: context,
      builder: (context) => loginDone
          ? MyAlertDialogWithLogin(
              todoController: todoController, today: today, tomorrow: tomorrow)
          : MyAlertDialogWithoutLogin(
              todoController: todoController,
              today: today,
              tomorrow: tomorrow)); */

  /* 
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Color(0xFFFFFFFF),
                      ));
                    });
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim());
                } on FirebaseAuthException catch (e) {
                  if (_emailController.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text("Email adresi yanlış."),
                          );
                        });
                  }
                  if (e.code == "user-not-found") {
                    print("user not found");
                    // ignore: use_build_context_synchronously
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text("Email adresi yanlış."),
                          );
                        });
                  } else if (e.code == "wrong-password") {
                    // ignore: use_build_context_synchronously
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text("Şifre yanlış."),
                          );
                        });
                  }
                  //Navigator.pop(context);
                } */
  /* Future.delayed(const Duration(seconds: 1), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HomePage()));
                }); */
}
