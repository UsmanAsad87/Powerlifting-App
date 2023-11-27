import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/main.dart';
import 'package:powerlifting_app/screens/Home%20Screen/Tutorial%20Screen/tutorials_screen.dart';
import 'package:powerlifting_app/screens/Home%20Screen/programs_screen.dart';
import 'package:powerlifting_app/screens/Home%20Screen/recordsessions_screen.dart';
import 'package:powerlifting_app/screens/Home%20Screen/weightconverter_screen.dart';
import 'package:powerlifting_app/screens/Home Screen/myaccount_screen.dart';

class homeScreen extends StatefulWidget {
  @override
  _home createState() => _home();
}

class _home extends State<homeScreen> {
  TextEditingController emailupData = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

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
                Text(
                  "Hello, Aaron! ",
                  style: TextStyle(
                      fontFamily: 'Open', fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Text(user.email!, style: TextStyle(color: Colors.red)),
                Container(
                    height: 105,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.red, width: 3)),
                    child: Column(
                      children: <Widget>[
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Squat',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.white,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text('440.925',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.red,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0),
                                child: Container(
                                  height: 99.0,
                                  width: 3,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Bench',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.white,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text('300',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.red,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.0),
                                child: Container(
                                  height: 99.0,
                                  width: 3,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text('Deadlift',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.white,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Text('500 LB',
                                      style: TextStyle(
                                          fontFamily: 'Open',
                                          color: Colors.red,
                                          fontSize: 20)),
                                  SizedBox(height: 5),
                                  Icon(
                                    Icons.fitness_center,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        key: Key('tut'),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TutorialScreen()));
                            },
                            icon: const Icon(Icons.book),
                            iconSize: 40)),
                    SizedBox(width: 50),
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                            key: Key("program"),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProgramScreen()));
                            },
                            icon: Icon(Icons.computer),
                            iconSize: 40)),
                    SizedBox(width: 50),
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                          key: Key('recordbtn'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecordScreen()));
                          },
                          icon: Icon(Icons.camera_alt),
                          iconSize: 40,
                        )),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    SizedBox(width: 45),
                    Text(
                      'Tutorials',
                      style: TextStyle(fontFamily: 'open', color: Colors.white),
                    ),
                    SizedBox(width: 48),
                    Text(
                      'Programs',
                      style: TextStyle(fontFamily: 'open', color: Colors.white),
                    ),
                    SizedBox(width: 50),
                    Text(
                      'Record',
                      style: TextStyle(fontFamily: 'open', color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 50),
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                          key: Key('weightconvertbtn'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ConvertScreen()));
                          },
                          icon: Icon(Icons.fitness_center),
                          iconSize: 40,
                        )),
                    SizedBox(width: 50),
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        child: IconButton(
                          key: Key('Accountbtn'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AccountScreen()));
                          },
                          icon: Icon(Icons.account_box),
                          iconSize: 40,
                        )),
                    SizedBox(width: 50),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    SizedBox(width: 98),
                    Text(
                      '  Weight\nConverter',
                      style: TextStyle(fontFamily: 'open', color: Colors.white),
                    ),
                    SizedBox(width: 44),
                    Text(
                      'Account\n',
                      style: TextStyle(fontFamily: 'open', color: Colors.white),
                    ),
                    SizedBox(width: 60),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => MainPage())));
                        },
                        child: Text(
                          'Sign Out',
                          key: Key('Sign-Out'),
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Open'),
                        ))),
              ],
            ),
          )),
        ));
  }
}
