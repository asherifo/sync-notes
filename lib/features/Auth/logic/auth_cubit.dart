import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_sign_in/google_sign_in.dart' ;
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Email Sign Up
  Future signUp({required String userEmail, required String userPass}) async {
    emit(AuthLoading());

    try {
      await auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMsg: e.message ?? "Something went wrong"));
    }
  }

  /// Email Login
  Future login({required String userEmail, required String userPass}) async {
    emit(AuthLoading());

    try {
      await auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPass,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMsg: e.message ?? "Something went wrong"));
    }
  }

  /// SignIn With Google

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

      await googleSignIn.signIn();

      final GoogleSignInAccount? googleUser =
      await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthInitial());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await auth.signInWithCredential(credential);

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(errorMsg: e.message ?? 'Authentication failed'));
    } catch (e) {
      emit(AuthError(errorMsg: e.toString()));
    }
  }

  /// Logout
 Future<void> logout()async{
    await googleSignIn.signOut();
    await auth.signOut();
    emit(AuthInitial());
 }

}
