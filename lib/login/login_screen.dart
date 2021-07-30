import 'package:camera_app/cubit/cubit.dart';
import 'package:camera_app/screens/home.dart';
import 'package:camera_app/login/cubit/cubit.dart';
import 'package:camera_app/login/cubit/states.dart';
import 'package:camera_app/register/register_screen.dart';
import 'package:camera_app/shared/components/components.dart';
import 'package:camera_app/shared/components/constants.dart';
import 'package:camera_app/shared/local/cache_helper.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CameraLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => CameraLoginCubit(),
      child: BlocConsumer<CameraLoginCubit, CameraLoginStates>(
        listener: (BuildContext context, state) {
          if (state is CameraLoginErrorState) {
            print(state.error);
            Fluttertoast.showToast(
                msg: state.error.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
          if (state is CameraLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              uId = state.uId;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            });
          }
        },
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          'Login now to use our camera app',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(height: height * 0.02),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Password must not be empty';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          isPassword: CameraLoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            CameraLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          suffix: CameraLoginCubit.get(context).suffix,
                        ),
                        SizedBox(height: height * 0.02),
                        ConditionalBuilder(
                          condition: state is! CameraLoginLoadingState,
                          builder: (BuildContext context) {
                            return InkWell(
                              onTap: () {
                                if (formKey.currentState.validate()) {
                                  CameraLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Container(
                                height: 50,
                                color: Colors.blue,
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            );
                          },
                          fallback: (BuildContext context) => Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              child: Text(' '),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CameraRegisterScreen(),
                                    ));
                              },
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        Center(child: Text('Or login with')),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/images/google-signin.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              onPressed: () {
                                CameraLoginCubit.get(context)
                                    .signInWithGoogle()
                                    .then((value) =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false));
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/images/facebook-signin.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              onPressed: () {
                                CameraLoginCubit.get(context)
                                    .signInWithFacebook()
                                    .then((value) =>
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
