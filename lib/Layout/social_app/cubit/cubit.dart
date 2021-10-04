import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/social_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/login_model.dart';
import 'package:my_first_proj/models/social_app/social_user_model.dart';
import 'package:my_first_proj/modules/shop_app/login_screen/cubit/states.dart';
import 'package:my_first_proj/modules/shop_app/register/cubit/states.dart';
import 'package:my_first_proj/modules/social_app/chats/chats_screen.dart';
import 'package:my_first_proj/modules/social_app/feeds/feeds_screen.dart';
import 'package:my_first_proj/modules/social_app/new_post/new_post_screen.dart';
import 'package:my_first_proj/modules/social_app/settings/setting_screen.dart';
import 'package:my_first_proj/modules/social_app/social_register_screen/cubit/states.dart';
import 'package:my_first_proj/modules/social_app/users/user_screen.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){

      model= SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());

    }).catchError((onError) {
      emit(SocialGetUserErrorState(onError));
    });
  }

  int currentIndex=0;

  List<Widget>screens= [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];
  void changeBottomNav(int index) {
    currentIndex = index;

    if(index==2)
      emit(SocialNewPostState());
    else
    emit(SocialChangeBottomNavState());
  }


  List<String>title= [
    "Home",
    "Chats",
     "",
    "Users",
    "Settings"
  ];


}
