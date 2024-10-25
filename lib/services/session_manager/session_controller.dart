import 'dart:convert'; // Importing dart:convert for JSON encoding and decoding

import 'package:e_mandi/domain/entities/user.dart';
import 'package:e_mandi/services/storage/local_storage.dart';
import 'package:flutter/material.dart'; // Importing Flutter material library

/// A singleton class for managing user session data.
class SessionController {
  /// Instance of [LocalStorage] for accessing local storage.
  final LocalStorage sharedPreferenceClass = LocalStorage();

  /// Singleton instance of [SessionController].
  static final SessionController _session = SessionController._internal();

  /// Flag indicating whether the user is logged in or not.
  static bool? isLogin;

  // / Model representing the user data.
  // static UserModel user = UserModel();

  /// Private constructor for creating the singleton instance of [SessionController].
  SessionController._internal() {
    // Initialize default values
    isLogin = false;
  }

  //In Dart, a factory constructor is a special kind of constructor that can return an instance of the class,
  // potentially a cached or pre-existing instance, instead of always creating a new one.
  // It's defined using the factory keyword.
  // This is useful for implementing patterns like singletons or when you want to control instance creat
  //
  /// Factory constructor for accessing the singleton instance of [SessionController].
  factory SessionController() {
    return _session;
  }

  /// Saves user data into the local storage.
  ///
  /// Takes a [user] object as input and saves it into the local storage.
  Future<void> saveUserInPreference(UserModel user) async {
    sharedPreferenceClass.setValue('token', jsonEncode(user.toMap(user)));
    // Storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  /// Retrieves user data from the local storage.
  ///
  /// Retrieves user data from the local storage and assigns it to the session controller
  /// to be used across the app.
  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');

      if (userData.isNotEmpty) {
        // SessionController.user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
