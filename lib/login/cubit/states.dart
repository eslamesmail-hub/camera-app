abstract class CameraLoginStates {}

class CameraLoginInitialState extends CameraLoginStates {}

// email login states
class CameraLoginLoadingState extends CameraLoginStates {}

class CameraLoginSuccessState extends CameraLoginStates {
  final String uId;
  CameraLoginSuccessState(this.uId);
}

class CameraLoginErrorState extends CameraLoginStates {
  final String error;
  CameraLoginErrorState(this.error);
}

class CameraChangePasswordVisibilityState extends CameraLoginStates {}
