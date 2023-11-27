import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/main.dart';
import 'package:powerlifting_app/screens/Login Screen/login_screen.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:powerlifting_app/screens/Login Screen/forgotpassword_screen.dart';
import 'package:powerlifting_app/utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController emailinData = TextEditingController();
  TextEditingController passinData = TextEditingController();
  String emailtext = '';
  String passtext = '';
  bool interacts = false;
  bool Obsecure = true;

  @override
  void dispose() {
    emailinData.dispose();
    passinData.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "             Email",
                        style: TextStyle(color: Colors.red, fontFamily: 'Open'),
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
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextField(
                      style: TextStyle(fontSize: 14, fontFamily: 'Open'),
                      key: Key("emailin-field"),
                      controller: emailinData,
                      onChanged: (value) {
                        setState(() {
                          if (emailinData.text != "" && passinData.text != "")
                            interacts = true;
                          else
                            interacts = false;
                        });
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.mail, color: Colors.black),
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
                    style: TextStyle(color: Colors.red, fontFamily: 'Open'),
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
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextField(
                      style: TextStyle(fontSize: 14, fontFamily: 'Open'),
                      key: Key("passin-field"),
                      controller: passinData,
                      obscureText: (Obsecure) ? true : false,
                      onChanged: (value) {
                        setState(() {
                          if (passinData.text != "" && emailinData.text != "")
                            interacts = true;
                          else
                            interacts = false;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              Obsecure = !Obsecure;
                            });
                          },
                          icon: (Obsecure)
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
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextButton(
                        key: Key('login'),
                        onPressed: (!interacts) ? null : signIn,
                        child: Text(
                          'Login',
                          key: Key('logintxt'),
                          style: TextStyle(
                              color: (interacts) ? Colors.white : Colors.black,
                              fontFamily: 'Open'),
                        ))),
                SizedBox(height: 65),
                GestureDetector(
                    child: Text('Forgot Password?',
                        key: Key('Forgot'),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontFamily: 'Open',
                            fontSize: 15)),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotScreen()));
                    }),
                SizedBox(
                  height: 5,
                ),
                RichText(
                    key: const Key('signup'),
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontFamily: 'Open'),
                        text: 'No account? ',
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: 'Sign Up',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontFamily: 'Open')),
                        ]))
              ],
            ),
          )),
        ));
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailinData.text.trim(), password: passinData.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
