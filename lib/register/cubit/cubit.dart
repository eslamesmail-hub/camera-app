import 'package:bloc/bloc.dart';
import 'package:camera_app/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraRegisterCubit extends Cubit<CameraRegisterStates> {
  CameraRegisterCubit() : super(CameraRegisterInitialState());

  static CameraRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    @required String email,
    @required String password,
  }) {
    emit(CameraRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(CameraRegisterSuccessState(value.user.uid));
    }).catchError((error) {
      emit(CameraRegisterErrorState(error.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(CameraRegisterChangePasswordVisibilityState());
  }
}
