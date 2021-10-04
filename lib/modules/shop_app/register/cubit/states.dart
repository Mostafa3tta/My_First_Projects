import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/login_screen.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error ;

  ShopRegisterErrorState(this.error);

}