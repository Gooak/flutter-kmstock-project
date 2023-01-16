import 'package:get/get.dart';
import '../User/repository/user_repository.dart';
import '../model/model.dart';

class AuthController extends GetxController{

  static AuthController get to => Get.find();

  Rx<KmUser> user = KmUser().obs;

  Future<KmUser?> loginUser(String uid)async{
    var userData = await UserRepository.loginUserByUid(uid);
    if(userData != null){
      user(userData);
      return userData;
    }
    else
      {
        user.value.uid = null;
        return userData;
      }

  }

  void signup(KmUser signupuser) async{
    var result = await UserRepository.signup(signupuser);
    //return result;
    if(result){
      user(signupuser);
    }
  }
}