// ignore_for_file: use_build_context_synchronously

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yapilacaklarnotlarlisteler/common/mytextformfield.dart';
import 'package:yapilacaklarnotlarlisteler/pages/home_page.dart';
import 'package:yapilacaklarnotlarlisteler/pages/stream_for_signup_page.dart';
import '../common/auth_button.dart';
import '../common/colors.dart';

class SiginPage extends StatefulWidget {
  const SiginPage({super.key});

  @override
  State<SiginPage> createState() => _SiginPageState();
}

class _SiginPageState extends State<SiginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double textFieldHeight = 0;
  bool visiblePassword = true;
  bool _isSigninAuthLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailFocus.addListener(() {
      setState(() {});
    });
    super.initState();
    _passwordFocus.addListener(() {
      setState(() {});
    });
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

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    double currentWidth = MediaQuery.of(context).size.width;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Giriş Sayfası",
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
        body: SafeArea(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: MyGradientColors),
          ),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Center(child: AuthText("Hoş Geldiniz")),
              const SizedBox(height: 10),
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
                      autovalidateMode: autovalidateMode,
                      validator: validatePass,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      obscureText: visiblePassword,
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
                            visiblePassword = !visiblePassword;
                            setState(() {});
                          },
                          child: visiblePassword
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility_off,
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
                  text: "Giriş Yap",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        _isSigninAuthLoading = true;
                      });

                      debugPrint("LOGIN PROCESS"); //
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        debugPrint("LOGIN PROCESS 2");
                        if (userCredential.user != null) {
                          print('Signed in: ${userCredential.user!.uid}');
                          // ignore: use_build_context_synchronously
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Başarılı giriş yaptınız."),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Böyle bir kullanıcı bulunmamaktadır"),
                                    ],
                                  ),
                                );
                              });
                        }
                        Future.delayed(const Duration(milliseconds: 2200), () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        });
                        debugPrint("LOGIN PROCESS 3");
                      } on FirebaseAuthException catch (e) {
                        debugPrint("LOGIN PROCESS 4");
                        debugPrint(e.toString());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Hatalı giriş. Email adresi, şifrenizi kontrol edin."),
                                  ],
                                ),
                              );
                            });
                        debugPrint("LOGIN PROCESS 5");
                        Future.delayed(const Duration(milliseconds: 2400), () {
                          Navigator.of(context).pop();
                        });
                        setState(() {
                          autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    } else {
                      setState(() {
                        debugPrint("LOGIN PROCESS 6");
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                    setState(() {
                      _isSigninAuthLoading = false;
                    });
                  },
                  currentWidth: currentWidth),
              const SizedBox(height: 10),
              Center(
                child: SizedBox(
                  width: currentWidth < 400 ? currentWidth - 20 : 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: AuthText("Şifremi Unuttum"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 26),
              Center(child: AuthText("Hesabınız yok mu?")),
              const SizedBox(height: 10),
              AuthButton(
                  text: "Yeni Hesap Aç",
                  onTap: () {
                    return Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const StreamForSignupPage()));
                  },
                  currentWidth: currentWidth),
              const SizedBox(height: 22),
              Center(child: AuthText("veya")),
              const SizedBox(height: 22),
              AuthButton(
                  text: "Google Hesabımla Giriş Yap",
                  onTap: () async {
                    signInWithGoogle();
                  },
                  currentWidth: currentWidth),
              const SizedBox(height: 40),
            ],
          ),
        )),
      ),
    );
  }
}
