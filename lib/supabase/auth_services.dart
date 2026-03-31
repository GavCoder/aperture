import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  //Sign Up to Supabase
  Future<String> signUp(
    String email,
    String password,
  ) async {
    String res = 'some error occured!';

    try {
      final authRes = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final usr = authRes.user;

      if (usr == null) {
        res = 'sign up failed!';
      } else {
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  //Sign In From Supabase
  Future<String> signIn(
    String email,
    String password,
  ) async {
    String res = 'some error occured!';

    try {
      final authRes = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final usr = authRes.user;

      if(usr == null){
        res = 'failed to sign in. User Does not Exist!';
      }
      else{
        res = 'success';
      }

    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  //Sign Out From Supabase
  Future<String> signOut() async {
    String res = 'some error occured!';

    try {
      await supabase.auth.signOut();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // Sends a password reset email.
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'http://localhost:3000', // must match dashboard
      );
    } on AuthException catch (e) {
      throw _mapError(e.message);
    } catch (_) {
      throw 'Something went wrong. Please try again.';
    }
  }

  // Called after the user lands back in the app and enters a new password.
  Future<void> updatePassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } on AuthException catch (e) {
      throw _mapError(e.message);
    } catch (_) {
      throw 'Failed to update password. Please try again.';
    }
  }

  String _mapError(String message) {
    if (message.contains('rate limit')) {
      return 'Too many attempts. Please wait a moment.';
    }
    if (message.contains('invalid')) {
      return 'Please enter a valid email address.';
    }
    return message;
  }

}
