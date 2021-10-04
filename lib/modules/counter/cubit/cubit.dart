import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/modules/counter/cubit/states.dart';
import 'package:path/path.dart';

class counterCubit extends Cubit<conterStates> {


  counterCubit() : super(counterInialStates());

  static counterCubit get(context)=> BlocProvider.of(context);

  int counter = 0 ;

  void minus () {
    counter --;
    emit(counterMinusState());
  }
  void plus () {
     counter ++;
     emit(counterPlusState());

  }
}
