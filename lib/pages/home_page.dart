import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yapilacaklarnotlarlisteler/common/colors.dart';
import 'package:yapilacaklarnotlarlisteler/pages/singin_page.dart';

import 'package:yapilacaklarnotlarlisteler/widgets/my_alert_dialog_with_login.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/my_alert_dialog_without_login.dart';
import 'package:yapilacaklarnotlarlisteler/widgets/task_widget.dart';

import '../common/auth_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool showAdding = true;
  late final AnimationController _animationController = AnimationController(
      duration: const Duration(milliseconds: 1300), vsync: this)
    ..repeat(reverse: showAdding);
  late final Animation<double> _floatAnimation =
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  TextEditingController todoController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
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
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xFFFFFFFF),
                        ));
                      });
                  await FirebaseAuth.instance.signOut();
                  Future.delayed(const Duration(milliseconds: 1300), () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SiginPage()));
                  });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Color(0xFFFFFFFF),
                  size: 20,
                ))
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyGradientColors),
          ),
          child: ListView(
            children: [
              const Center(
                  child: AuthText(text: "Yapılacaklar & Notlar & Listeler")),
              Center(
                child: SizedBox(
                  width: currentWidth < 400 ? currentWidth - 10 : 400,
                  height: MediaQuery.of(context).size.height,
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.forward) {
                        setState(() {
                          showAdding = true;
                        });
                      }
                      if (notification.direction == ScrollDirection.reverse) {
                        setState(() {
                          showAdding = false;
                        });
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const TaskWidget();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return deciderdFloat(const MyAlertDialogWithLogin());
              } else {
                return deciderdFloat(const MyAlertDialogWithouLogin());
              }
            })));
  }

  Widget deciderdFloat(Widget alertDialog) {
    return Visibility(
      visible: showAdding,
      child: FadeTransition(
        opacity: _floatAnimation,
        child: FloatingActionButton(
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 0, 156, 187),
          onPressed: () {
            setState(() {
              showAdding = true;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return alertDialog;
                });
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
