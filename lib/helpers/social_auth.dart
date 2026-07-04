import 'dart:developer';

import 'package:barkbridgeai/helpers/loading_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthHelper {
  static final _auth = FirebaseAuth.instance;
  static final _googleSignIn = GoogleSignIn();

  /// Common success handler
  static Future<void> _handleLoginSuccess({
    required User? user,
    required String token,
    String? userName,
    required Future<void> Function(User user, String token)? onSuccess,
    Future<void> Function(User user, String token, String userName)?
    onSuccessWithName,
  }) async {
    if (user == null) return;

    debugPrint("✅ Login Success");
    debugPrint("👤 Name: ${user.displayName}");
    debugPrint("📧 Email: ${user.email}");
    debugPrint("🆔 UID: ${user.uid}");

    if (onSuccessWithName != null) {
      await onSuccessWithName(user, token, userName ?? '');
    } else if (onSuccess != null) {
      await onSuccess(user, token);
    }
  }

  /// Apple Sign-In
  static Future<UserCredential?> signInWithApple({
    //required BuildContext context,
    required Future<void> Function(User user, String token, String userName)?
    onSuccess,
  }) async {
    try {
      debugPrint("🍎 Starting Apple Sign-In...");

      final apple = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      debugPrint("✅ Apple credential obtained");
      debugPrint("📧 Email: ${apple.email}");
      debugPrint("👤 Full Name: ${apple.givenName} ${apple.familyName}");

      if (apple.identityToken == null) {
        throw Exception(
          "Identity token is null - Apple Sign-In capability may not be enabled",
        );
      }

      final credential = OAuthProvider("apple.com").credential(
        idToken: apple.identityToken!,
        accessToken: apple.authorizationCode,
      );

      final userCredential = await _auth
          .signInWithCredential(credential)
          .waitingForFutureWithoutBg();

      log("UserCredential: $userCredential");

      String? getName() {
        if (apple.givenName == null && apple.familyName == null) {
          return null;
        } else if (apple.givenName == null) {
          return apple.familyName;
        } else if (apple.familyName == null) {
          return apple.givenName;
        } else {
          return '${apple.givenName} ${apple.familyName}';
        }
      }

      await _handleLoginSuccess(
        user: userCredential.user,
        token: apple.identityToken ?? '',
        userName: getName(),
        onSuccess: null,
        onSuccessWithName: onSuccess,
      );

      return userCredential;
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint(
        "❌ Apple Sign-In Authorization Error: ${e.code} - ${e.message}",
      );
      if (e.code == AuthorizationErrorCode.unknown) {
        debugPrint(
          "⚠️ Error 1000: Check that 'Sign in with Apple' capability is enabled in Xcode",
        );
        debugPrint(
          "⚠️ Also verify the Bundle ID matches your Apple Developer account",
        );
      }
      return null;
    } catch (e) {
      debugPrint("❌ Apple Sign-In Error: $e");
      return null;
    }
  }

  /// Apple Sign-In
  // static Future<UserCredential?> signInWithApple({
  //   //required BuildContext context,
  //   required Future<void> Function(User user, String token)? onSuccess,
  // }) async {
  //   try {
  //     final apple = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName
  //       ],
  //     );

  //     final credential = OAuthProvider("apple.com").credential(
  //       idToken: apple.identityToken,
  //       accessToken: apple.authorizationCode,
  //     );

  //     final userCredential = await _auth
  //         .signInWithCredential(credential)
  //         .waitingForFutureWithoutBg();
  //     log("UserCredential: $userCredential");
  //     await _handleLoginSuccess(
  //       user: userCredential.user,
  //       token: apple.identityToken ?? '',
  //       onSuccess: onSuccess,
  //     );

  //     return userCredential;
  //   } catch (e) {
  //     debugPrint("❌ Apple Sign-In Error: $e");
  //     return null;
  //   }
  // }

  /// Google Sign-In
  static Future<UserCredential?> signInWithGoogle({
    required Future<void> Function(User user, String token)? onSuccess,
  }) async {
    try {
      final googleUser = await _googleSignIn
          .signIn()
          .waitingForFutureWithoutBg();
      if (googleUser == null) return null;

      final auth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      await _handleLoginSuccess(
        user: userCredential.user,
        token: auth.accessToken ?? '',
        onSuccess: onSuccess,
      );

      return userCredential;
    } catch (e) {
      debugPrint("❌ Google Sign-In Error: $e");
      return null;
    }
  }

  /// Sign Out
  static Future<bool> signOut({
    required Future<void> Function()? onSuccess,
  }) async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();

      debugPrint("✅ Sign Out Success");

      if (onSuccess != null) await onSuccess();

      return true;
    } catch (e) {
      debugPrint("❌ Sign Out Error: $e");
      return false;
    }
  }
}
