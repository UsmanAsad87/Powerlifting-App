import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/Common/common_widgets/custom_button.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import '../../../Common/common_widgets/custom_text_fields.dart';
import '../../../Common/common_widgets/validator.dart';
import '../../../utils/Utils.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  Account createState() => Account();
}

class Account extends State<UpdatePasswordScreen> {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final oldController = TextEditingController();
  bool isLoading = false;
  bool passObscure = true;
  bool passObscure2 = true;
  bool passObscure3 = true;

  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    passController.dispose();
    oldController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  update() async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (formKey.currentState!.validate()) {
      if (passController.text != confirmPassController.text) {
        Utils.showToast(msg: "Your New Password Doesn't matches",textColor: Colors.red);
        return;
      }
      setState(() {
        isLoading = true;
      });
      bool success = await updatePassword(
        currentPassword: oldController.text.trim(),
        newPassword: passController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });
      if (success) {
        Utils.showToast(msg: "Password Updated successfully");
      }
    }
  }

  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      var user = _auth.currentUser!;
      var credentials = EmailAuthProvider.credential(
          email: _auth.currentUser!.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credentials);
      await _auth.currentUser!.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      Utils.showSnackBar(e.message);
      return false;
    } catch (e, stackTrace) {
      Utils.showSnackBar(e.toString());
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
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
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Update Password Screen",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Open',
                                fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          controller: oldController,
                          hintText: 'Enter old password',
                          label: 'Old Password',
                          validatorFn: sectionValidator,
                          obscure: passObscure,
                          tailingIcon: passObscure == false
                              ? InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      passObscure = !passObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color: Colors.black45,
                                    size: 20,
                                  ))
                              : InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      passObscure = !passObscure;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                        ),
                        CustomTextField(
                          controller: passController,
                          hintText: 'Enter new password',
                          label: 'New Password',
                          validatorFn: passValidator,
                          obscure: passObscure2,
                          tailingIcon: passObscure2 == false
                              ? InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      passObscure2 = !passObscure2;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color: Colors.black45,
                                    size: 20,
                                  ))
                              : InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      passObscure2 = !passObscure2;
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                        ),
                        CustomTextField(
                          controller: confirmPassController,
                          hintText: 'Confirm new password',
                          label: 'Confirm Password',
                          validatorFn: passValidator,
                          obscure: passObscure3,
                          tailingIcon: passObscure3 == false
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      passObscure3 = !passObscure3;
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  child: Icon(
                                    CupertinoIcons.eye,
                                    color: Colors.black45,
                                    size: 20,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      passObscure3 = !passObscure3;
                                    });
                                  },
                                  splashColor: Colors.transparent,
                                  child: Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.black,
                                    size: 20,
                                  )),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onPressed: update,
                          buttonText: "Update Password",
                          buttonWidth: 200,
                          isLoading: isLoading,
                          backColor: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }
}
