import 'dart:collection';
import 'dart:io';
import 'package:camera_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery/image_gallery.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraCubit extends Cubit<CameraStates> {
  CameraCubit() : super(CameraInitialState());

  static CameraCubit get(context) => BlocProvider.of(context);

  // open camera and save image to gallery
  Future<File> captureAndSaveImage({int index}) async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage == null) return null;
    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null)
        return File(pickedImage.path).copy('${directory.path}/name.png');
    } catch (e) {
      return null;
    }
  }

  // show gallery images
  Map<dynamic, dynamic> allImageInfo = HashMap();
  List allImage = [];
  Future<void> loadImageList() async {
    Map<dynamic, dynamic> allImageTemp;
    allImageTemp = await FlutterGallaryPlugin.getAllImages;

    allImage = allImageTemp['URIList'] as List;
  }
}
