import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/news_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/news_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).sport;
         return  articleBuilder(list,context);
        });
  }
}
