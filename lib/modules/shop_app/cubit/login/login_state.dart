import '../../models/response_model.dart';

abstract class LoginState{}

class LoginInitialState extends LoginState{}
class LoginLoadState extends LoginState{}
class LoginSuccessState extends LoginState{
 final ResponseModel responseModel;

 LoginSuccessState(this.responseModel);
}
class ChangeIconState extends LoginState{}
class LoginErrorState extends LoginState{
 final String error;

 LoginErrorState({required this.error});
}
