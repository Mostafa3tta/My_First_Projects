import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/news_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/network/remote/dio_helper.dart';
import 'package:my_first_proj/modules/newsapp_modules/search/search_screen.dart';
import 'cubit/cubit.dart';

class NewsLayout extends  StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit , NewsState>(
      listener: (context,state){} ,
      builder: (context,state){
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context,SearchScreen());
                  },
                  icon: Icon(Icons.search),
              ),
              IconButton(
                  onPressed: (){
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.curentIndex,
            onTap: (index){
              cubit.changeBottomBar(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.screen[cubit.curentIndex],
        );
      },
    );
  }
}


