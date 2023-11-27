import 'package:flutter/material.dart';

class SignupInfo extends StatefulWidget {
  @override
  _Info createState() => _Info();
}

class _Info extends State<SignupInfo> {
  TextEditingController emailupData = TextEditingController();

  @override
  void dispose() {
    emailupData.dispose();
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
                Container(
                  child: Text(
                    "Email",
                    style: TextStyle(color: Colors.red, fontFamily: 'Open'),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                    height: 46,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextField(
                      style: TextStyle(fontSize: 14, fontFamily: 'Open'),
                      key: Key("emailup-field"),
                      controller: emailupData,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                    )),
              ],
            ),
          )),
        ));
  }
}
