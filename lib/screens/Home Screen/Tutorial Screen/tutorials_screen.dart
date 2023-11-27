import 'package:flutter/material.dart';
import 'package:powerlifting_app/screens/Home Screen/home_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlifting_app/utils/Utils.dart';
import 'package:flutter/services.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _Tutorial createState() => _Tutorial();
}

class _Tutorial extends State<TutorialScreen> {
  YoutubeVids temp = new YoutubeVids();
  @override
  void initState() {
    super.initState();

    temp.populateTitleAuthor();
    temp.populateData();
  }

  @override
  void dispose() {
    //gets rid of squat controllers
    for (int i = 0; i < temp.squat.length; i++) {
      temp.squat[i].pause();
      temp.squat[i].dispose();
    }
    //gets rid of bench controllers
    for (int i = 0; i < temp.bench.length; i++) {
      temp.bench[i].pause();
      temp.bench[i].dispose();
    }
    //gets rid of deadlift controllers
    for (int i = 0; i < temp.Deadlift.length; i++) {
      temp.bench[i].pause();
      temp.Deadlift[i].dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
          return true;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(
              "Tutorial Page",
              key: Key('tutcheck'),
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Open', fontSize: 30),
            ),
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.red,
              iconSize: 35,
              key: Key('back-cups'),
              onPressed: () {
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
            ),
          ),
          body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 600,
                    child: ListView(children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            'Squat Tutorials',
                            key: Key('Squat'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontFamily: 'Open'),
                          )),
                      for (int i = 0; i < temp.squat.length; i++) ...[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: temp.squat[i],
                                    showVideoProgressIndicator: true,
                                    bottomActions: [],
                                  ),
                                  builder: (context, player) {
                                    return Column(
                                      children: <Widget>[
                                        player,
                                        if (temp.squatDataTitle.isNotEmpty &&
                                            i < temp.squatDataTitle.length)
                                          Text(temp.squatDataTitle[i],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontFamily: 'Open')),
                                        Text(
                                            'Author: ${temp.squatDataAuthor[i]}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontFamily: 'Open')),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  })),
                        ),
                      ],
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            'Bench Tutorials',
                            key: Key('Bench'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontFamily: 'Open'),
                          )),
                      for (int i = 0; i < temp.bench.length; i++) ...[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: temp.bench[i],
                                    showVideoProgressIndicator: true,
                                    bottomActions: [],
                                  ),
                                  builder: (context, player) {
                                    return Column(
                                      children: <Widget>[
                                        player,
                                        if (temp.benchDataTitle.isNotEmpty &&
                                            i < temp.benchDataTitle.length)
                                          Text(temp.benchDataTitle[i],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontFamily: 'Open')),
                                        Text(
                                            'Author: ${temp.benchDataAuthor[i]}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontFamily: 'Open')),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  })),
                        ),
                      ],
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Text(
                            'Deadlift Tutorials',
                            key: Key('Deadlift'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontFamily: 'Open'),
                          )),
                      for (int i = 0; i < temp.Deadlift.length; i++) ...[
                        Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: YoutubePlayerBuilder(
                                  player: YoutubePlayer(
                                    controller: temp.Deadlift[i],
                                    showVideoProgressIndicator: true,
                                    bottomActions: [],
                                  ),
                                  builder: (context, player) {
                                    return Column(
                                      children: <Widget>[
                                        player,
                                        if (temp.deadliftTitle.isNotEmpty &&
                                            i < temp.deadliftTitle.length)
                                          Text(temp.deadliftTitle[i],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontFamily: 'Open')),
                                        Text(
                                            'Author: ${temp.deadliftAuthor[i]}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontFamily: 'Open')),
                                        SizedBox(height: 10),
                                      ],
                                    );
                                  })),
                        ),
                      ]
                    ]),
                  ),
                ],
              )),
        ));
  }
}
