import 'package:camera_app/cubit/cubit.dart';
import 'package:camera_app/cubit/states.dart';
import 'package:camera_app/login/login_screen.dart';
import 'package:camera_app/screens/image_gallery.dart';
import 'package:camera_app/shared/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraCubit, CameraStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Home Screen'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => CameraCubit.get(context)
                        .captureAndSaveImage()
                        .then((value) =>
                            CameraCubit.get(context).loadImageList()),
                    child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Text(
                          'Open Camera',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ImageGalley())),
                    child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Text(
                          'Open Gallery',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      CacheHelper.removeData(key: 'uId').then((value) {
                        if (value)
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraLoginScreen()),
                              (route) => false);
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.blue,
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
