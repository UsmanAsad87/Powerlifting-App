import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/main.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:powerlifting_app/screens/Login Screen/signupinfo.dart';
import 'package:powerlifting_app/screens/Login Screen/auth_page.dart';
import 'package:powerlifting_app/utils/Utils.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  TextEditingController emailinData = TextEditingController();
  TextEditingController passinData = TextEditingController();
  TextEditingController confirmpassinData = TextEditingController();
  String emailtext = '';
  String passtext = '';
  bool interacts = false;
  bool pass1Obsecure = true;
  bool pass2Obsecure = true;
  bool passmatch = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailinData.dispose();
    passinData.dispose();
    confirmpassinData.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.red,
            iconSize: 35,
            key: Key('back-cups'),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                "             Email",
                                style: TextStyle(
                                    color: Colors.red, fontFamily: 'Open'),
                              ),
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 46,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Open'),
                              key: Key("emailin-field"),
                              controller: emailinData,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => email != null &&
                                      !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                              onChanged: (value) {
                                setState(() {
                                  if (emailinData.text != "" &&
                                      passinData.text != "")
                                    interacts = true;
                                  else
                                    interacts = false;
                                });
                              },
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                      color: Colors.white, fontFamily: 'Open'),
                                  prefixIcon:
                                      Icon(Icons.mail, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16))),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "             Password",
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'Open'),
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 46,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Open'),
                              key: Key("passin-field"),
                              controller: passinData,
                              obscureText: (pass1Obsecure) ? true : false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null,
                              onChanged: (value) {
                                setState(() {
                                  if (passinData.text != "" &&
                                      emailinData.text != "")
                                    interacts = true;
                                  else
                                    interacts = false;

                                  if (passinData.text != confirmpassinData.text)
                                    passmatch = false;
                                  else {
                                    passmatch = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.white, fontFamily: 'Open'),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pass1Obsecure = !pass1Obsecure;
                                    });
                                  },
                                  icon: (pass1Obsecure)
                                      ? Icon(Icons.vpn_key)
                                      : Icon(Icons.vpn_key_outlined),
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "             Confirm Password",
                            style: TextStyle(
                                color: Colors.red, fontFamily: 'Open'),
                          ),
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                            height: 46,
                            width: 300,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 14, fontFamily: 'Open'),
                              key: Key("confirm-passin-field"),
                              controller: confirmpassinData,
                              obscureText: (pass2Obsecure) ? true : false,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) =>
                                  value != null && value.length < 6
                                      ? 'Enter min. 6 characters'
                                      : null,
                              onChanged: (value) {
                                setState(() {
                                  if (passinData.text != "" &&
                                      emailinData.text != "")
                                    interacts = true;
                                  else
                                    interacts = false;

                                  if (passinData.text != confirmpassinData.text)
                                    passmatch = false;
                                  else {
                                    passmatch = true;
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.white, fontFamily: 'Open'),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      pass2Obsecure = !pass2Obsecure;
                                    });
                                  },
                                  icon: (pass2Obsecure)
                                      ? Icon(Icons.vpn_key)
                                      : Icon(Icons.vpn_key_outlined),
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 35,
                        ),
                        Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextButton(
                                onPressed:
                                    (!interacts && !passmatch) ? null : signUp,
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: (interacts && passmatch)
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: 'Open'),
                                ))),
                        SizedBox(
                          height: 50,
                        ),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontFamily: 'Open'),
                                text: 'Already have an account? ',
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: 'Log In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontFamily: 'Open'))
                            ]))
                      ],
                    ),
                  ))),
        ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailinData.text.trim(), password: passinData.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
