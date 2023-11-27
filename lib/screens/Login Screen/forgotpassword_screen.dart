import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:powerlifting_app/main.dart';
import 'package:powerlifting_app/screens/Login Screen/login_screen.dart';
import 'package:powerlifting_app/utils/Utils.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreen createState() => _ForgotScreen();
}

class _ForgotScreen extends State<ForgotScreen> {
  TextEditingController emailinData = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool interacts = false;

  @override
  void dispose() {
    emailinData.dispose();
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
                        Icon(Icons.lock_outline, color: Colors.red, size: 100),
                        SizedBox(height: 50),
                        Text("Password Change Request",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Open',
                                fontSize: 20)),
                        SizedBox(height: 15),
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
                                  if (emailinData.text != "")
                                    interacts = true;
                                  else
                                    interacts = false;
                                });
                              },
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                      borderRadius: BorderRadius.circular(16)),
                                  errorStyle: TextStyle(
                                      color: Colors.white, fontFamily: 'Open'),
                                  prefixIcon:
                                      Icon(Icons.mail, color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16))),
                            )),
                        SizedBox(height: 30),
                        Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: TextButton(
                                key: Key('Reset'),
                                onPressed: (!interacts) ? null : resetPassword,
                                child: Text(
                                  'Reset Password',
                                  key: Key('resetbutton'),
                                  style: TextStyle(
                                      color: (!interacts)
                                          ? Colors.black
                                          : Colors.white,
                                      fontFamily: 'Open'),
                                ))),
                      ],
                    ),
                  ))),
        ));
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailinData.text.trim());
      Utils.showSnackBar('Passsword Reset Email Sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
