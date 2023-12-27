

abstract class AppStates{}

class InitialState extends AppStates{}
class ShowPasswordState extends AppStates{}
class AgreeTermsState extends AppStates{}
class LoginLoadingState extends AppStates{}
class LoginSuccessState extends AppStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends AppStates{
  final String error;
  LoginErrorState(this.error);
}


class CreateUserSuccessState extends AppStates{
  final String uId;
  CreateUserSuccessState(this.uId);
}
class CreateUserErrorState extends AppStates{
  final String error;
  CreateUserErrorState(this.error);
}


class RegisterLoadingState extends AppStates{}
class RegisterErrorState extends AppStates{
  final String error;
  RegisterErrorState(this.error);
}


class ResetPasswordLoadingState extends AppStates{}
class ResetPasswordSuccessState extends AppStates{}
class ResetPasswordErrorState extends AppStates{
  final String error;
  ResetPasswordErrorState(this.error);
}

class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{}

class GetAllProductsLoadingState extends AppStates{}
class GetAllProductsSuccessState extends AppStates{}
class GetAllProductsErrorState extends AppStates{}

class GetProductsLoadingState extends AppStates{}
class GetProductsSuccessState extends AppStates{}
class GetProductsErrorState extends AppStates{}


class GetMyProductsLoadingState extends AppStates{}
class GetMyProductsSuccessState extends AppStates{}
class GetMyProductsErrorState extends AppStates{}

class DeleteMyProductsLoadingState extends AppStates{}
class DeleteMyProductsSuccessState extends AppStates{}
class DeleteMyProductsErrorState extends AppStates{}

class ChangeScreenState extends AppStates{}
class ChangeGenderState extends AppStates{}
class ChangeCategoryState extends AppStates{}

class StepCancelState extends AppStates{}
class StepContinueState extends AppStates{}
class StepTappedState extends AppStates{}

class UpdateUserLoadingState extends AppStates{}
class UpdateUserSuccessState extends AppStates{}
class UpdateUserErrorState extends AppStates{
  final String error;
  UpdateUserErrorState(this.error);
}

class PickedProfileImageSuccessState extends AppStates{}
class PickedProfileImageErrorState extends AppStates{}

class PickedProductImagesSuccessState extends AppStates{}
class PickedProductImagesErrorState extends AppStates{}


class UploadProfileImageLoadingState extends AppStates{}
class UploadProfileImageSuccessState extends AppStates{}
class UploadProfileImageErrorState extends AppStates{}


class RemoveImageFromListState extends AppStates{}


class UploadProductImagesLoadingState extends AppStates{}
class UploadProductImagesSuccessState extends AppStates{}
class UploadProductImagesErrorState extends AppStates{}


class postProductLoadingState extends AppStates{}
class postProductSuccessState extends AppStates{}
class postProductErrorState extends AppStates{
  final String error;
  postProductErrorState(this.error);
}

class UploadMessageImagesLoadingState extends AppStates{}


class sendMessageLoadingState extends AppStates{}
class sendMessageSuccessState extends AppStates{}
class sendMessageErrorState extends AppStates{
  final String error;
  sendMessageErrorState({required this.error,});
}

class getMessageSuccessState extends AppStates{}
class getMessageErrorState extends AppStates{
  final String error;
  getMessageErrorState({required this.error,});
}


class getMessageImageSuccessState extends AppStates{}
class getMessageImageErrorState extends AppStates{
  final String error;
  getMessageImageErrorState({required this.error,});
}
class removeMessageImageSuccessState extends AppStates{}



class getAllUsersLoadingState extends AppStates{}
class getAllUsersSuccessState extends AppStates{}
class getAllUsersErrorState extends AppStates{
  final String error;
  getAllUsersErrorState({required this.error,});
}


class sendNotificationSuccessState extends AppStates{}
class sendNotificationErrorState extends AppStates{
  final String error;
  sendNotificationErrorState({required this.error,});
}