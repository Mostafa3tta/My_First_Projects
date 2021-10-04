import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/models/social_app/social_user_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/states.dart';
import 'package:my_first_proj/modules/social_app/social_register_screen/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }){
    print('hello');
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
          name: name,
          email: email,
          phone: phone,
          uId: value.user!.uid
      );
    }).catchError((error){
      SocialRegisterErrorState(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  })
  {
    SocialUserModel model=SocialUserModel(
      name:name,
      email:email,
      phone:phone,
      uId:uId,
      cover:'https://image.freepik.com/free-photo/close-up-portrait-nice-cute-adorable-smiling-charming-cheerful-girl-pointing-with-her-index-finger_176532-7923.jpg',
      bio:'write your bio...',
      image:'https://image.freepik.com/free-photo/surprised-male-face-through-paper-hole-emotional-astonished-young-man-wears-yellow-headgear_273609-25550.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }
}