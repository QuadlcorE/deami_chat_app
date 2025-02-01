import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'The user information is invalid.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect. Please try again.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid. Please check and try again.';
          break;
        case 'network-request-failed':
          errorMessage = 'A network error occurred. Please check your internet connection.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many failed login attempts. Please try again later.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
          // errorMessage = e.code.toString();
      }
      throw errorMessage; // Throw a custom exception with a detailed message
    } catch (e) {
      // Handle other exceptions
      // throw 'An unexpected error occured. Please try again.';
      throw e.toString();
    }
  }

  // Sign up
  Future<UserCredential> signUpWithEmailandPassword (String email, password ) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth errors
      String errorMessage;
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid. Please check and try again.';
          break;
        case 'network-request-failed':
          errorMessage = 'A network error occurred. Please check your internet connection.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many failed login attempts. Please try again later.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }
      throw errorMessage;
      // throw Exception(e.code);
    } catch (e) {
      // Handle other exceptions
      throw e.toString();
    }
  }

  // Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  // Error
}
