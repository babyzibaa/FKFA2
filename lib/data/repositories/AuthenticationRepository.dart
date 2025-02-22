

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fkfa/screens/LoginScreen.dart';
import 'package:fkfa/screens/VerifyEmailScreen.dart';
import 'package:fkfa/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:fkfa/utils/exceptions/firebase_exceptions.dart';
import 'package:fkfa/utils/exceptions/format_exceptions.dart';
import 'package:fkfa/utils/exceptions/platform_exceptions.dart';
import 'package:fkfa/utils/local_storage/storage_utility.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../NavigationMenu.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;


  /// Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  /// Called from main.dart on app launch

  @override
  void onReady() {
    //FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Function to show Relevant Screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {

        //Initialize User Specific Storage
        await fkfaLocalStorage.init(user.uid);

        // If the user's email is verified, navigate to the main Navigation Menu
        Get.offAll(() => const NavigationMenu());
      } else {
        // If the email is not verified, navigate to the VerifyEmailScreen
        Get.offAll(() => Verifyemailscreen()/*(email: _auth.currentUser?.email)*/);
      }
    } else {
      // local storage
      deviceStorage.writeIfNull("isFirstTime", true);

      // Check if it's the first time for the user launching the app
      deviceStorage.read("isFirstTime") != true
          ? Get.offAll(() => const Loginscreen())
          : Get.offAll(const Loginscreen());
    }
  }

  /* ------------------------ Email and Password sign-in ------------------*/

  /// [EmailAuthentication] Log In
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);

    } on FirebaseAuthException catch (e) {
      throw fkfaFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fkfaFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fkfaFormatException();
    } on PlatformException catch (e) {
      throw fkfaPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [EmailAuthentication] Register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

    } on FirebaseAuthException catch (e) {
      throw fkfaFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fkfaFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fkfaFormatException();
    } on PlatformException catch (e) {
      throw fkfaPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [EmailVerification] - Mail Verification
  Future<void> sendEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw fkfaFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw fkfaFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const fkfaFormatException();
    } on PlatformException catch (e) {
      throw fkfaPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong, Please try again';
    }
  }

  /// [EmailVerification] - Forgot Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

  } on FirebaseAuthException catch (e) {
  throw fkfaFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
  throw fkfaFirebaseException(e.code).message;
  } on FormatException catch (_) {
  throw const fkfaFormatException();
  } on PlatformException catch (e) {
  throw fkfaPlatformException(e.code).message;
  } catch (e) {
  throw 'Something went wrong, Please try again';
  }
}}