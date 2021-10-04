import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        return AppCubit.get(context).newTasks.length>0?
        ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).newTasks[index], context),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount:AppCubit.get(context).newTasks.length,
        ):
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.menu,
              color: Colors.grey,
              size: 60.0,
              ),
              Text(
                "مافيش تاسكات جديده وتم تفعيل وضع الباندا مؤقتا",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ) ,
              )
            ],
          ),
        );
      },
    );
  }
}
