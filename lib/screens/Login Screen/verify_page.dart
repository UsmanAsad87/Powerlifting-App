import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:powerlifting_app/utils/Utils.dart';
import 'dart:async';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailPage createState() => _VerifyEmailPage();
}

class _VerifyEmailPage extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    //user needs to be created before!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? homeScreen()
      : Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.red,
              title:
                  Text('Verify Email', style: TextStyle(color: Colors.white))),
          body: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'A verification email has been sent to your email.',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Open', color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed:
                              canResendEmail ? sendVerificationEmail : null,
                          icon: Icon(Icons.email, size: 32),
                          label: Text('Resend Email',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'open',
                                  color: Colors.white)))),
                  SizedBox(height: 8),
                  SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50)),
                        child: Text('Cancel',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Open',
                                color: Colors.white)),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                      )),
                ],
              )),
        );
}
