
abstract class AuthState {}

class InitialAuthState extends AuthState{}
class ShowPasswordState extends AuthState{}
class AgreeTermsState extends AuthState{}
class LoginLoadingState extends AuthState{}
class LoginSuccessState extends AuthState{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends AuthState{
  final String error;
  LoginErrorState(this.error);
}


class CreateUserSuccessState extends AuthState{
  final String uId;
  CreateUserSuccessState(this.uId);
}
class CreateUserErrorState extends AuthState{
  final String error;
  CreateUserErrorState(this.error);
}


class RegisterLoadingState extends AuthState{}
class RegisterErrorState extends AuthState{
  final String error;
  RegisterErrorState(this.error);
}


class ResetPasswordLoadingState extends AuthState{}
class ResetPasswordSuccessState extends AuthState{}
class ResetPasswordErrorState extends AuthState{
  final String error;
  ResetPasswordErrorState(this.error);
}

class GetUserDataLoadingState extends AuthState{}
class GetUserDataSuccessState extends AuthState{}
class GetUserDataErrorState extends AuthState{}
