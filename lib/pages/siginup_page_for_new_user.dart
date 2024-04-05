// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../common/auth_button.dart';
import '../common/colors.dart';
import '../common/mytextformfield.dart';
import 'stream_for_signup_page.dart';

class SignupPageForNewUser extends StatefulWidget {
  const SignupPageForNewUser({super.key});

  @override
  State<SignupPageForNewUser> createState() => _SignupPageForNewUserState();
}

class _SignupPageForNewUserState extends State<SignupPageForNewUser> {
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
  UserCredential? userCredential;

  @override
  void initState() {
    super.initState();
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email adresinizi yazın.';
    }
    if (!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
        .hasMatch(value)) {
      return 'Doğru email adresi yazın.';
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

    return Container(
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
                  width: currentWidth < 400 ? currentWidth - 20 : 400,
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
                  width: currentWidth < 400 ? currentWidth - 20 : 400,
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
                  width: currentWidth < 400 ? currentWidth - 20 : 400,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      hintText: "  Şifre",
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 15),
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
                      errorStyle: const TextStyle(color: Colors.white),
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
                  width: currentWidth < 400 ? currentWidth - 20 : 400,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      hintText: "  Şifre Tekrarı",
                      hintStyle:
                          const TextStyle(color: Colors.white, fontSize: 15),
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
                      errorStyle: const TextStyle(color: Colors.white),
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
                    UserCredential userCredential = FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim())
                        as UserCredential;
                    debugPrint("SIGNUP PROCESS 2");
                    Future.delayed(const Duration(seconds: 3), () async {
                      await userCredential.user!.sendEmailVerification();
                      debugPrint("SIGNUP PROCESS 3");
                      const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Lütfen email adresinizi onaylayın."),
                              ],
                            ),
                          );
                        });
                    userCredential.user!.reload();
                    debugPrint("SIGNUP PROCESS 4");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "auth/email-already-in-use") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${_emailController.text} adresi kullanılmaktadır."),
                                ],
                              ),
                            );
                          });
                    } else if (e.code == "wrong-password") {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Şifre Hatalı"),
                                ],
                              ),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //"Lütfen kayıt bilgilerinizi kontrol edin."
                                  Text(e.toString()),
                                ],
                              ),
                            );
                          });
                    }
                  }
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
    );
  }
}
