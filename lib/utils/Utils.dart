import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_data_api/models/video_data.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:powerlifting_app/screens/Home Screen/Tutorial Screen/tutorials_screen.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:powerlifting_app/utils/post.dart';
import 'package:http/http.dart' as http;

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;
    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showToast(
      {required String msg,
      Color? textColor,
      Color? backgroundColor,
      bool long = false}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.white,
      textColor: textColor ?? Colors.black,
      fontSize: 12,
    );
  }
}

class YoutubeVids {
  String datatemp = "";
  List<String> Squaturls = [];
  List<String> Deadlifturls = [];
  List<String> Benchurls = [];

  List<YoutubePlayerController> squat = [];
  List<String> squatDataTitle = [];
  List<String> squatDataAuthor = [];
  List<YoutubePlayerController> bench = [];
  List<String> benchDataTitle = [];
  List<String> benchDataAuthor = [];
  List<YoutubePlayerController> Deadlift = [];
  List<String> deadliftTitle = [];
  List<String> deadliftAuthor = [];

  late YoutubePlayerController _ytController;

  void populateTitleAuthor() {
    squatDataTitle.add('How to Squat Properly (STEP BY STEP)');
    squatDataAuthor.add('Squat University');
    benchDataTitle.add('How to: Bench Press');
    benchDataAuthor.add('Squat University');
    deadliftTitle.add('How to Deadlift: 3 STEPS!)');
    deadliftAuthor.add('Squat University');
  }

  Future<void> populateData() async {
    Squaturls.add('https://www.youtube.com/shorts/8060FZiT5TA');
    Deadlifturls.add('https://www.youtube.com/shorts/PKsWnUXcYSQ');
    Benchurls.add('https://www.youtube.com/shorts/9SdwTIG6hJY');

    for (int i = 0; i < Squaturls.length; i++) {
      //Inserts Data into squat controllers
      String _id = YoutubePlayer.convertUrlToId(Squaturls[i])!;

      _ytController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
        ),
      );
      squat.add(_ytController);
    }
    //Inserts data into bench controllers
    for (int i = 0; i < Benchurls.length; i++) {
      String _id = YoutubePlayer.convertUrlToId(Benchurls[i])!;

      YoutubePlayerController _ytController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
        ),
      );
      bench.add(_ytController);
    }

    //Inserts data into deadlift controllers
    for (int i = 0; i < Deadlifturls.length; i++) {
      String _id = YoutubePlayer.convertUrlToId(Deadlifturls[i])!;
      YoutubePlayerController _ytController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
        ),
      );
      Deadlift.add(_ytController);
    }
  }
}

class converterTools {
  static double convert1(String inputvalue, var conversion1, var pounds) {
    pounds = double.tryParse(inputvalue);
    if (pounds == null) return 0;
    if (pounds <= 0) {
      throw ArgumentError();
    }
    conversion1 = pounds / 2.20462;
    return conversion1;
  }

  static double convert2(String inputvalue, var conversion2, var kilograms) {
    kilograms = double.tryParse(inputvalue);
    if (kilograms <= 0) {
      throw ArgumentError();
    }
    conversion2 = kilograms * 2.20462;
    return conversion2;
  }
}

class RemoteService {
  Future<List<Post>?> getPosts(String? uid) async {
    var client = http.Client();

    var uri = Uri.parse('http://api.3eam.net/powerlifting/$uid');
    try {
      var response = await client.get(uri);

      if (response.statusCode == 200) {
        var json = response.body;
        // Parse the JSON and return the result
        return postFromJson(json);
      } else {
        // Handle non-200 status codes here
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that might occur during the HTTP request
      print('Error during HTTP request: $e');
    } finally {
      // Make sure to close the client to free up resources
      client.close();
    }
  }

  Future<bool?> createProgram(String? uid, String Name) async {
    var client = http.Client();

    var uri = Uri.parse('http://api.3eam.net/powerlifting/user/create');
    try {
      var response = await client.post(uri,
          headers: {"Content-type": "application/json"},
          body: jsonEncode({"UserId": '$uid', "name": '$Name'}));

      if (response.statusCode == 200) {
        var json = response.body;
        // Parse the JSON and return the result
        return true;
      } else {
        // Handle non-200 status codes here
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Handle any exceptions that might occur during the HTTP request
      print('Error during HTTP request: $e');
    } finally {
      // Make sure to close the client to free up resources
      client.close();
    }


  }

  Stream<List<Post>?> getPostsStream(String? userId) {
    // Implement your logic to get posts using streams
    // Replace the following line with your actual implementation
    // This is just a placeholder.
    return Stream.fromFuture(getPosts(userId));
    }
}
