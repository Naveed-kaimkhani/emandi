import 'dart:io';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:e_mandi/presentation/widgets/no_internet_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
class utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }
  
  

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    String actualDate = formatterDate.format(now);
    return actualDate;
  }

  static String getCurrentTime() {
    var now = DateTime.now();
    var formatterTime = DateFormat('kk:mm');
    String actualTime = formatterTime.format(now);
    return actualTime;
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 5),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        // backgroundColor: const Color.fromARGB(255, 90, 89, 89),
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  static void checkConnectivity(context) {
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      if (connected == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Center(
              child: NoInternetCnnection(),
            ),
          ),
        );
        // return connected;
      }
    });
    // return true;
  }

  

static String get currentUserUid => FirebaseAuth.instance.currentUser!.uid;



  static String getFriendlyErrorMessage(dynamic error) {
    // Check for specific error conditions and return appropriate messages
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'wrong-password':
          return 'Invalid password. Please check your password and try again.';
        case 'user-not-found':
          return 'User not found. Please check your email and try again.';
        default:
          return 'An error occurred. Please try again later.';
      }
    }

    // Handle other types of errors or fallback to a generic message
    return 'An error occurred. Please try again later.';
  }


  static User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  static Future<SharedPreferences> getPreferencesObject() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static Future<void> logOutUser(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('isUser', 0);
    } catch (e) {
      utils.flushBarErrorMessage(e.toString(), context);
    }
  }

  static String getRandomid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
  Future<Uint8List> getByteFromAssets(String path, int widht) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: widht);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }


  // static launchphone(String number, context) async {
  //   Uri phoneUri = Uri.parse("tel:$number");
  //   if (await canLaunch(phoneUri.toString())) {
  //     await launch(phoneUri.toString());
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text("Unable to open"),
  //       ),
  //     );
  //   }
  // }
  // for getting formatted time from milliSecondsSinceEpochs String
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }

  // for getting formatted time for sent & read
  static String getMessageTime(
      {required BuildContext context, required String time}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    final formattedTime = TimeOfDay.fromDateTime(sent).format(context);
    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return formattedTime;
    }

    return now.year == sent.year
        ? '$formattedTime - ${sent.day} ${_getMonth(sent)}'
        : '$formattedTime - ${sent.day} ${_getMonth(sent)} ${sent.year}';
  }

  //get last message time (used in chat user card)
  static String getLastMessageTime(
      {required BuildContext context,
      required String time,
      bool showYear = false}) {
    final DateTime sent = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateTime now = DateTime.now();

    if (now.day == sent.day &&
        now.month == sent.month &&
        now.year == sent.year) {
      return TimeOfDay.fromDateTime(sent).format(context);
    }

    return showYear
        ? '${sent.day} ${_getMonth(sent)} ${sent.year}'
        : '${sent.day} ${_getMonth(sent)}';
  }

  //get formatted last active time of user in chat screen
  static String getLastActiveTime(
      {required BuildContext context, required String lastActive}) {
    final int i = int.tryParse(lastActive) ?? -1;

    //if time is not available then return below statement
    if (i == -1) return 'Last seen not available';

    DateTime time = DateTime.fromMillisecondsSinceEpoch(i);
    DateTime now = DateTime.now();

    String formattedTime = TimeOfDay.fromDateTime(time).format(context);
    if (time.day == now.day &&
        time.month == now.month &&
        time.year == time.year) {
      return 'Last seen today at $formattedTime';
    }

    if ((now.difference(time).inHours / 24).round() == 1) {
      return 'Last seen yesterday at $formattedTime';
    }

    String month = _getMonth(time);

    return 'Last seen on ${time.day} $month on $formattedTime';
  }

  // get month name from month no. or index
  static String _getMonth(DateTime date) {
    switch (date.month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sept';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return 'NA';
  }

 
}

