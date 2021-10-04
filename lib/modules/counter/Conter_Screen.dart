import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/bloc_observer.dart';
import 'package:my_first_proj/modules/counter/cubit/cubit.dart';
import 'package:my_first_proj/modules/counter/cubit/states.dart';

class conterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => counterCubit() ,
      child: BlocConsumer<counterCubit , conterStates>(
        listener:  (context , state ) {} ,
        builder:  (context , state) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Counter",
                )),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        counterCubit.get(context).minus();
                      },
                      child: Text("Mines")),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      "${counterCubit.get(context).counter}",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        counterCubit.get(context).plus();
                      },
                      child: Text("plus")),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
