import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/social_app/social_login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {

  SocialLoginCubit() : super(SocialLoginInitialState());


  static SocialLoginCubit get(context) => BlocProvider.of(context);


  void userLogin({
  required String email,
  required String password,
    }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLoginErrorState(onError.toString()));
    });
  }


}