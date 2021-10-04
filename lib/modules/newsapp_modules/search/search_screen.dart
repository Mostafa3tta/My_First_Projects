import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Layout/news_app/cubit/cubit.dart';
import 'package:my_first_proj/Layout/news_app/cubit/states.dart';
import 'package:my_first_proj/Shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var SearchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsState>(
      listener: (context,state){},
      builder: (context,state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  onTap: (){},
                  controller: SearchController,
                  type: TextInputType.text,
                  isVaildator: true,
                  validate: (){},
                  onChange: (value){
                    NewsCubit.get(context).getSearch(value);

                  },
                  label: 'Search',
                  prefix: Icons.search,
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
