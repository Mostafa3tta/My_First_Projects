import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context,state){},
      builder: (context,state) {
        return AppCubit.get(context).newTasks.length>0?
        ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).archivedTasks[index], context),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
          itemCount:AppCubit.get(context).archivedTasks.length,
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
                "🤦‍♂️ حتي الارشيف مافهوش حاجه يا بائس لا فوق كده عايزين شغل",
                style: TextStyle(
                  fontSize: 14.0,
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
