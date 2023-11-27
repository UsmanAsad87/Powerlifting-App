import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/Common/common_widgets/custom_button.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:powerlifting_app/screens/Home%20Screen/update_email_screen.dart';
import 'package:powerlifting_app/screens/Home%20Screen/update_password_screen.dart';
import '../../../Common/common_widgets/custom_text_fields.dart';
import '../../../Common/common_widgets/validator.dart';
import '../../../utils/Utils.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.red,
              iconSize: 35,
              key: Key('back-cups'),
              onPressed: () {
                FocusManager.instance.primaryFocus!.unfocus();
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.black,
          body: Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "My Account",
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Open',
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateEmailScreen()));
                    },
                    buttonText: "Update Email",
                    buttonWidth: 200,
                    backColor: Colors.red,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  UpdatePasswordScreen()));
                    },
                    buttonText: "Update Password",
                    buttonWidth: 200,
                    backColor: Colors.red,
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
