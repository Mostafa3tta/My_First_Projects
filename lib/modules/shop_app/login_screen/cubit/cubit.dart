import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {

  ShopLoginCubit() : super(ShopLoginInitialState());


  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userLogin({
  required String email,
  required String password,
    }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email':email,
        'password':password,
      },
    ).then((value) {
      loginModel= ShopLoginModel.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopLoginErrorState(onError.toString()));
    });
  }


}