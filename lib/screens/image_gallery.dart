import 'package:camera_app/cubit/cubit.dart';
import 'package:camera_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class ImageGalley extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraCubit, CameraStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = CameraCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Image Gallery'),
          ),
          body: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: model.allImage.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.file(
                        File(model.allImage[index].toString()),
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.80,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
