import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/network/end_points.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/models/shop_app/search_model.dart';
import 'package:my_first_proj/modules/shop_app/search/cubit/states.dart';


class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;
  void search(String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text':text,
        }).then((value)
    {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }


}