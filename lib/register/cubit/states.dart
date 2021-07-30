abstract class CameraRegisterStates {}

class CameraRegisterInitialState extends CameraRegisterStates {}

// login states states
class CameraRegisterLoadingState extends CameraRegisterStates {}

class CameraRegisterSuccessState extends CameraRegisterStates {
  final String uId;
  CameraRegisterSuccessState(this.uId);
}

class CameraRegisterErrorState extends CameraRegisterStates {
  final String error;
  CameraRegisterErrorState(this.error);
}

class CameraRegisterChangePasswordVisibilityState extends CameraRegisterStates {
}
