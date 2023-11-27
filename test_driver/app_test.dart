// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  late FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Happy Paths', () {
    test("login successful", () async {
      final emailbtn = find.byValueKey('emailin-field');
      final passbtn = find.byValueKey('passin-field');
      final loginbtn = find.byValueKey('login');
      await driver.tap(emailbtn);
      await driver.enterText('aaronramirez879@yahoo.com');
      await driver.tap(passbtn);
      await driver.enterText('Test12345!');
      await driver.tap(loginbtn);

      final signoutbtn = find.byValueKey('Sign-Out');
      expect(await driver.getText(signoutbtn), 'Sign Out');
    });

    test("tutorial screen happy paths", () async {
      final tutorialbtn = find.byValueKey('tut');
      await driver.tap(tutorialbtn);

      final Squatpage = find.byValueKey('Squat');
      expect(
        await driver.getText(Squatpage),
        'Squat Tutorials',
      );

      final Benchpage = find.byValueKey('Bench');
      expect(
        await driver.getText(Benchpage),
        'Bench Tutorials',
      );

      final Deadliftpage = find.byValueKey('Deadlift');
      expect(
        await driver.getText(Deadliftpage),
        'Deadlift Tutorials',
      );

      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
    });

    test("program screen happy paths", () async {
      final programbtn = find.byValueKey('program');
      await driver.tap(programbtn);

      final checkpage = find.byValueKey('programcheck');

      expect(await driver.getText(checkpage), 'Programs');
      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
    });

    test("record screen happy paths", () async {
      final recordbtn = find.byValueKey('recordbtn');
      await driver.tap(recordbtn);

      final checkpage = find.byValueKey('recordcheck');
      await driver.tap(checkpage);

      await Future.delayed(Duration(seconds: 2));
      await driver.tap(checkpage);

      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
      await driver.tap(backbtn);
    });

    test("convert screen happy paths", () async {
      final convertbtn = find.byValueKey('weightconvertbtn');
      await driver.tap(convertbtn);

      final checkpage = find.byValueKey('convertcheck');

      expect(await driver.getText(checkpage), 'Weight Converter');
      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
    });

    test("account screen happy paths", () async {
      final accountbtn = find.byValueKey('Accountbtn');
      await driver.tap(accountbtn);

      final checkpage = find.byValueKey('Accountcheck');

      expect(await driver.getText(checkpage), 'My Account');
      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
      final signoutbtn = find.byValueKey('Sign-Out');
      await driver.tap(signoutbtn);
    });

    test("Forgot Password successful", () async {
      final Forgotbtn = find.byValueKey('Forgot');
      await driver.tap(Forgotbtn);
      final emailbtn = find.byValueKey('emailin-field');
      await driver.tap(emailbtn);
      await driver.enterText('aaronramirez879@yahoo.com');

      final resetbtn = find.byValueKey('Reset');
      await driver.tap(resetbtn);

      final loginbtn = find.byValueKey('logintxt');

      expect(await driver.getText(loginbtn), 'Login');
    });
  });

  group('Sad Paths', () {
    test("login unsuccessful", () async {
      final emailbtn = find.byValueKey('emailin-field');
      final passbtn = find.byValueKey('passin-field');
      final loginbtn = find.byValueKey('logintxt');
      await driver.tap(emailbtn);
      await driver.enterText('aaronramirez879@yahoo.com');
      await driver.tap(passbtn);
      await driver.enterText('Test122222');
      await driver.tap(loginbtn);

      expect(await driver.getText(loginbtn), 'Login');
    });

    test("Forgot Password unsuccessful", () async {
      final Forgotbtn = find.byValueKey('Forgot');
      await driver.tap(Forgotbtn);
      final emailbtn = find.byValueKey('emailin-field');
      await driver.tap(emailbtn);
      await driver.enterText('aaronramirez333@yahoo.com');

      final resetbtn = find.byValueKey('Reset');
      await driver.tap(resetbtn);

      final resettxt = find.byValueKey('resetbutton');
      expect(await driver.getText(resettxt), 'Reset Password');

      final backbtn = find.byValueKey('back-cups');
      await driver.tap(backbtn);
    });
  });
}
