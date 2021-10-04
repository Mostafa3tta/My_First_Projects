import 'package:my_first_proj/models/shop_app/change_favorites_model.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}



class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String Error;

  ShopErrorHomeDataState(this.Error);
}



class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {}



class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShophangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}




class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}



class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}


class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}