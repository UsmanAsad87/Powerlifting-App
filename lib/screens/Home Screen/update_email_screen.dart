import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/Common/common_widgets/custom_button.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import '../../../Common/common_widgets/custom_text_fields.dart';
import '../../../Common/common_widgets/validator.dart';
import '../../../utils/Utils.dart';

class UpdateEmailScreen extends StatefulWidget {
  const UpdateEmailScreen({Key? key}) : super(key: key);

  @override
  Account createState() => Account();
}

class Account extends State<UpdateEmailScreen> {
  final emailController = TextEditingController();
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  @override
  void initState() {
    emailController.text = user.email!;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  update() async {
    FocusManager.instance.primaryFocus!.unfocus();
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      bool success = await updateEmail(
          newEmail: emailController.text.trim());

      setState(() {
        isLoading = false;
      });
      if (success) {
        Utils.showToast(msg: "Email Updated successfully");
      }
    }
  }

  Future<bool> updateEmail({
    required String newEmail,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      // Check if the new email is already associated with another account
      var methods = await _auth.fetchSignInMethodsForEmail(newEmail);

      if (methods.isNotEmpty) {
        // Email is already in use by another account
        Utils.showSnackBar('Email is already in use by another user.');
        return false;
      }

      // Update the email if it's not in use
      await _auth.currentUser!.updateEmail(newEmail);
      Utils.showSnackBar('Email updated successfully.');
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      return false;
    } catch (e) {
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
                            "Update Email Screen",
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
                          controller: emailController,
                          hintText: 'Enter Email',
                          label: 'New Email Address',
                          validatorFn: emailValidator,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          onPressed: update,
                          buttonText: "Update Email",
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
