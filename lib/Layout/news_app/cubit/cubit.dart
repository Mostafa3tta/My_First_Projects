import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/news_app/cubit/states.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/modules/newsapp_modules/business/business_screen.dart';
import 'package:my_first_proj/modules/newsapp_modules/science/scince_screen.dart';
import 'package:my_first_proj/modules/newsapp_modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsState> {

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int curentIndex = 0;

  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports_esports),
      label: "Sports_",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomBar(int index) {
    curentIndex = index;
    if(index ==0)
      getBusinees();
 else if(index ==1)
      getSports();
    else if(index ==2)
      getScience();
    emit(NewBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusinees () {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category': 'business',
        //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        'apiKey':'cecf2aea930d4c49a036947a49fa46de',
      },
    ).then((value) => {
      business = value.data['articles'],
      print(business.length),
      emit(NewsGetBusinessSuccessState()),
    }).catchError((onError) {
      emit(NewsGetBusinessErrorState(onError.toString()));
      print(onError.toString());
    }
    );
  }
  void getSports () {
    emit(NewsGetSportsLoadingState());

    if (sport.length ==0) {
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category': 'sports',
            //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
            'apiKey':'cecf2aea930d4c49a036947a49fa46de',
          },
        ).then((value) => {
          sport = value.data['articles'],
          print(sport.length),
          emit(NewsGetSportsSuccessState()),
        }).catchError((onError) {
          emit(NewsGetSportsErrorState(onError.toString()));
          print(onError.toString());
        }
        );
      }
    else
      emit(NewsGetSportsSuccessState());

  }
  void getScience () {
    emit(NewsGetScienceLoadingState());

    if(science.length==0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category': 'science',
          //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          'apiKey':'cecf2aea930d4c49a036947a49fa46de',
        },
      ).then((value) => {
        science = value.data['articles'],
        print(science.length),
        emit(NewsGetScienceSuccessState()),
      }).catchError((onError) {
        emit(NewsGetScienceErrorState(onError.toString()));
        print(onError.toString());
      }
      );
    }
    else
      emit(NewsGetScienceSuccessState());
  }

  void getSearch (String value) {
    emit(NewsGetSearchLoadingState());
    search=[];
    if(science.length==0) {
      DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$value',
          //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
          'apiKey':'cecf2aea930d4c49a036947a49fa46de',
        },
      ).then((value) => {
        search = value.data['articles'],
        print(search.length),
        emit(NewsGetSearchSuccessState()),
      }).catchError((onError) {
        emit(NewsGetSearchErrorState(onError.toString()));
        print(onError.toString());
      }
      );
    }
    else
      emit(NewsGetSearchSuccessState());
  }


}
