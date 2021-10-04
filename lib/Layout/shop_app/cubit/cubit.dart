import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/shop_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/categories_model.dart';
import 'package:my_first_proj/models/shop_app/change_favorites_model.dart';
import 'package:my_first_proj/models/shop_app/favorite_model.dart';
import 'package:my_first_proj/models/shop_app/home_model.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/modules/shop_app/categories/category_screen.dart';
import 'package:my_first_proj/modules/shop_app/favorites/favorite_screen.dart';
import 'package:my_first_proj/modules/shop_app/products/produts_screen.dart';
import 'package:my_first_proj/modules/shop_app/settings/setting_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);

  int currentIndex = 0 ;

List<Widget>bottomScreen=[
  ProductsScreen(),
  CategoryScreen(),
  FavoriteScreen(),
  SettingScreen(),
  ];

void changeBottom(int index){
  currentIndex = index;
emit(ShopChangeBottomNavState());
}


 HomeModel? homeModel  ;

Map<int,bool>? favorites={};
void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token:token,
    ).then((value)
    {

      homeModel=HomeModel.fromJson(value.data);

      homeModel!.data.products.forEach((element)
      {
        favorites!.addAll({
          element.id: element.in_favorites,
        });
      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      emit(ShopErrorHomeDataState(error));
    });
  }

  CategoriesModel? categoriesModel ;
  void getCategories(){
    DioHelper.getData(
      url: GET_CATEGORY,
      token: token,
    ).then((value){

      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoryState());

    }).catchError((onError){

      print(onError.toString());
      emit(ShopErrorCategoryState());

    });


  }



  late ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productID) {
    favorites![productID] =!favorites![productID]!;

    emit(ShopLoadingGetFavoritesState());

    DioHelper.postData(
        url: FAVORITES,
        data:{
          'product_id':productID
        },
        token: token,
    ).then((value){

      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);

      if (changeFavoritesModel.status==false)
        {
          favorites![productID] =!favorites![productID]!;
        }else
          getFavorites();

  emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    })
        .catchError((onError){

      favorites![productID] =!favorites![productID]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }


  FavoritesModel? favoritesModel ;
  void getFavorites(){

    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value){

      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());

    }).catchError((onError){

      print(onError.toString());
      emit(ShopErrorGetFavoritesState());

    });


  }

  ShopLoginModel? userModel ;
  void getUserModel(){

    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){

      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(userModel!));

    }).catchError((onError){

      print(onError.toString());
      emit(ShopErrorUserDataState());

    });


  }



  void updateUserModel({
    required String name,
    required String email,
    required String phone,
  }){

    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      data: {
        'name':name,
        'email':email,
        'phone':phone,
      },
      url: UPDATE,
      token: token,
    ).then((value){

      userModel=ShopLoginModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((onError){

      print(onError.toString());
      emit(ShopErrorUpdateUserState());

    });


  }



}