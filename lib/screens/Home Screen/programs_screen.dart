import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:powerlifting_app/utils/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:powerlifting_app/utils/post.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgramScreen extends StatefulWidget {
  @override
  _Program createState() => _Program();
}

class _Program extends State<ProgramScreen> {
  bool textFieldDisplayed = false;
  bool interacts = false;
  TextEditingController progamData = TextEditingController();

  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    posts =
        await RemoteService().getPosts(FirebaseAuth.instance.currentUser?.uid);
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      print(posts);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.red,
            iconSize: 35,
            key: Key('back-cups'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => homeScreen()));
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: Center(
              child: Column(children: <Widget>[

                



            SizedBox(
              height: 20,
            ),
            Row(children: <Widget>[
              SizedBox(width: 300),
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        textFieldDisplayed = !textFieldDisplayed;
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
            ]),
            SizedBox(height: 15),
            Row(children: <Widget>[
              SizedBox(width: 85),
              Visibility(
                visible: textFieldDisplayed,
                child: Container(
                  width: 200,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextField(
                    controller: progamData,
                    style: TextStyle(fontSize: 14, fontFamily: 'Open'),
                    key: Key("emailin-field"),
                    onChanged: (value) {
                      setState(() {
                        if (progamData.text != "" && progamData.text != "")
                            interacts = true;
                          else
                            interacts = false;
                      });
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Visibility(
                visible: textFieldDisplayed,
                child: 
                Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        (!interacts) ? null : RemoteService().createProgram(
                          FirebaseAuth.instance.currentUser?.uid, progamData.text);
                        textFieldDisplayed = false;
                        interacts = false;

                        getData();
                        
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color:(interacts) ? Colors.white : Colors.black,
                      size: 30,
                    )),
              ),
              ),
            ]),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.0),
              child: SingleChildScrollView(
              
                  child: Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: posts == null
                    ? CircularProgressIndicator()
                    : Visibility(
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        visible: isLoaded,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: posts!.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, int index) {
                            return ListTile(
                                title: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              height: 40,
                              width: 150,
                              alignment: Alignment.center,
                              child: Row(children: <Widget>[
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.note_rounded,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  posts![index].name ?? "NULL",
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: 'Open'),
                                ),
                              ]),
                            ));
                          },
                        ),
                      ),
              )),
            )
          ])),
        ));
  }
}
