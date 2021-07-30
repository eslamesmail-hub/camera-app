import 'package:camera_app/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class CameraLoginCubit extends Cubit<CameraLoginStates> {
  CameraLoginCubit() : super(CameraLoginInitialState());

  static CameraLoginCubit get(context) => BlocProvider.of(context);

  // email login
  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(CameraLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(CameraLoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(CameraLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(CameraChangePasswordVisibilityState());
  }

  // google signIn
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      emit(CameraLoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(CameraLoginErrorState(error.toString()));
    });
  }

  // facebook login
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.toString());
    return await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      emit(CameraLoginSuccessState(value.user.uid));
    }).catchError((error) {
      emit(CameraLoginErrorState(error.toString()));
    });
  }
}
