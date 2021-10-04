import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {

  ShopRegisterCubit() : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? registerModel;

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
    }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value) {
      registerModel= ShopLoginModel.fromJson(value.data);

      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((onError){
      print(onError.toString());
      emit(ShopRegisterErrorState(onError.toString()));
    });
  }


}