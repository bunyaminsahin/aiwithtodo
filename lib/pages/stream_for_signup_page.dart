// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yapilacaklarnotlarlisteler/pages/siginup_page_for_new_user.dart';
import 'package:yapilacaklarnotlarlisteler/pages/home_page.dart';

import '../common/auth_button.dart';
import '../common/colors.dart';
import '../common/mytextformfield.dart';

class StreamForSignupPage extends StatefulWidget {
  const StreamForSignupPage({super.key});
  @override
  State<StreamForSignupPage> createState() => _StreamForSignupPageState();
}

class _StreamForSignupPageState extends State<StreamForSignupPage> {
  Stream<User?> get userChanges => FirebaseAuth.instance.userChanges();

  // deneme yanilma, 100% çalıştıktan sonra get i değiştir bakalım ne olacak?
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  double textFieldHeight = 0;
  bool visiblePassword1 = true;
  bool visiblePassword2 = true;
  //UserCredential? userCredential;
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    }

    if (!isEmailVerified &&
        _formKey.currentState != null &&
        _formKey.currentState!.validate()) {
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
    _nameFocus.addListener(() {
      setState(() {});
    });
    _emailFocus.addListener(() {
      setState(() {});
    });
    _passwordFocus.addListener(() {
      setState(() {});
    });
    _passwordConfirmFocus.addListener(() {
      setState(() {});
    });
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified == true) {
      await FirebaseFirestore.instance.collection("users").add({
        "useremail": _emailController.text.trim(),
        "username": _nameController.text.trim(),
        "userpassword": _passwordController.text.trim()
      }).whenComplete(() => timer?.cancel());
      debugPrint("isEmailVerified has been changed to true");
      timer?.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      debugPrint("isEmailVerified has been changed to true 2");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    timer?.cancel();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email adresinizi yazın.';
    }
    if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(value)) {
      return 'Doğru bir email adresi yazın.';
    }
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifrenizi yazın.";
    }
    if (value.length < 6) {
      return "Şifreniz en az 6 karakterden oluşmalıdır.";
    }
    return null;
  }

  String? validatePassConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return "Şifrenizi tekrar yazın.";
    }
    if (value != _passwordController.text.trim()) {
      return "Girilen şifreler aynı olmalıdır.";
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "İsminizi yazın.";
    }
    if (value.length < 3) {
      return "İsminiz en az 3 karakterden oluşmalıdır.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, AsyncSnapshot<User?> snapshot) {
            //User? user = snapshot.data; //active olmadı.
            //if(snapshot.hasData){
            //return HomePage();
            //}else {
            //retrun SignupPage();}}

            if (userChanges.isBroadcast) {
              debugPrint(
                  "ConnectionState.active: ${ConnectionState.active.toString()}");
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "Kayıt Sayfası",
                    style: TextStyle(
                      color: Colors.white, //fontFamily: "Lunada"
                    ),
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
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        const SizedBox(height: 10),
                        Center(child: AuthText("Tekrar Hoş Geldiniz")),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  currentWidth < 400 ? currentWidth - 20 : 400,
                              child: MyTextFormField(
                                autovalidateMode: autovalidateMode,
                                validator: validateName,
                                focusNode: _nameFocus,
                                controller: _nameController,
                                icon: Icons.person,
                                hintText: "  İsim",
                                keyboardType: TextInputType.name,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  currentWidth < 400 ? currentWidth - 20 : 400,
                              child: MyTextFormField(
                                autovalidateMode: autovalidateMode,
                                validator: validateEmail,
                                focusNode: _emailFocus,
                                controller: _emailController,
                                icon: Icons.mail,
                                hintText: "  Email",
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  currentWidth < 400 ? currentWidth - 20 : 400,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validatePass,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                obscureText: visiblePassword1,
                                focusNode: _passwordFocus,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: _passwordFocus.hasFocus
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255),
                                  ),
                                  hintText: "  Şifre",
                                  hintStyle: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  suffix: InkWell(
                                    onTap: () {
                                      visiblePassword1 = !visiblePassword1;
                                      setState(() {});
                                    },
                                    child: visiblePassword1
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width:
                                  currentWidth < 400 ? currentWidth - 20 : 400,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: validatePassConfirm,
                                cursorColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
                                obscureText: visiblePassword2,
                                focusNode: _passwordConfirmFocus,
                                controller: _passwordConfirmController,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: _passwordFocus.hasFocus
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(
                                            255, 255, 255, 255),
                                  ),
                                  hintText: "  Şifre Tekrarı",
                                  hintStyle: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  suffix: InkWell(
                                    onTap: () {
                                      visiblePassword2 = !visiblePassword2;
                                      setState(() {});
                                    },
                                    child: visiblePassword2
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                          ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          text: "Kaydol",
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              debugPrint("SIGNUP PROCESS 1");
                              try {
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim());
                                debugPrint("SIGNUP PROCESS 2");
                                await FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                                debugPrint("SIGNUP PROCESS 3");
                                Future.delayed(const Duration(seconds: 2), () {
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  );
                                  FirebaseAuth.instance.currentUser!.reload();
                                  debugPrint("SIGNUP PROCESS 4");
                                  setState(() {
                                    isEmailVerified = FirebaseAuth
                                        .instance.currentUser!.emailVerified;
                                  });
                                }).whenComplete(() => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Lütfen email adresinizi onaylayın.")
                                            ]),
                                      );
                                    }));
                              } on FirebaseAuthException catch (e) {
                                if (e.code == "email-already-in-use") {
                                  //e.code == "auth/email-already-in-use"
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "${_emailController.text} adresi kullanılmaktadır."),
                                            ],
                                          ),
                                        );
                                      });
                                  setState(() {});
                                  debugPrint(
                                      "Eemail already using: ${e.toString()}");
                                } else if (e.code == "wrong-password") {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Şifre Hatalı"),
                                            ],
                                          ),
                                        );
                                      });
                                  setState(() {});
                                  debugPrint("wrong password: ${e.toString()}");
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                e.message ?? e.toString(),
                                                softWrap: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                  debugPrint(e.toString());
                                }
                              }
                            } else if (!isEmailVerified) {
                              debugPrint("SIGNUP PROCESS 5");

                              debugPrint("SIGNUP PROCESS 6");
                              try {
                                FirebaseAuth.instance.currentUser!.reload();
                              } catch (e) {
                                print("Error: $e");
                              }

                              debugPrint("SIGNUP PROCESS 7");
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          currentWidth: currentWidth,
                        ),
                        const SizedBox(height: 22.2),
                        Center(
                          child: AuthText("veya"),
                        ),
                        const SizedBox(height: 22),
                        AuthButton(
                          text: "Google Hesabımla Giriş Yap",
                          onTap: () async {},
                          currentWidth: currentWidth,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container(
              child: const Text("Error has been occured."),
            );
          })),
    );
  }
}

Widget MyTextField(
    double currentWidth,
    FocusNode focusNode,
    TextEditingController controller,
    IconData icon,
    String text,
    TextInputType textInputType) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: currentWidth,
        child: TextField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          focusNode: focusNode,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon,
                color: focusNode.hasFocus
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(255, 255, 255, 255)),
            hintText: text,
            hintStyle: const TextStyle(color: Colors.white, fontSize: 15),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
          ),
          keyboardType: textInputType,
        ),
      ),
    ],
  );
}

Widget AuthText(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
  );
}
