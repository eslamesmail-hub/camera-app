import 'package:camera_app/cubit/cubit.dart';
import 'package:camera_app/screens/home.dart';
import 'package:camera_app/login/login_screen.dart';
import 'package:camera_app/shared/bloc_observer.dart';
import 'package:camera_app/shared/components/constants.dart';
import 'package:camera_app/shared/local/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId');
  print(uId);

  if (uId != null) {
    widget = Home();
  } else {
    widget = CameraLoginScreen();
  }
  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CameraCubit()..loadImageList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Camera app',
        home: startWidget,
      ),
    );
  }
}
