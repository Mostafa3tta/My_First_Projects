import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_first_proj/Shared/components/components.dart';
import 'package:my_first_proj/Shared/components/constanse.dart';
import 'package:my_first_proj/Shared/cubit/cubit.dart';
import 'package:my_first_proj/Shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if ( state is appInsertDababaseState)
            Navigator.pop(context);
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              splashColor: Colors.amber,
              onPressed: () async {
                if (cubit.isBottomSheet) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: cubit.titleController.text,
                      time: cubit.timingController.text,
                      date: cubit.dateController.text,);
                    cubit.changeBottomSheetState(
                      icon: Icons.edit,
                      isShow: false,
                    );
                    //cubit.isButtomSheet = false;
                   // cubit.flotingButtonIcon = Icons.edit;
                  }
                }
                else {
                  ScaffoldKey.currentState!.showBottomSheet(
                        (context) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                      onTap: (){},
                                      onChange: (){},
                                      isVaildator: true,
                                      validate: () {},
                                      controller: cubit.titleController,
                                      type: TextInputType.text,
                                      label: "Task Title",
                                      prefix: Icons.title,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                      onChange: (){},
                                      controller: cubit.timingController,
                                      type: TextInputType.datetime,
                                      isVaildator: true,
                                      validate: () {},
                                      label: "Timing Title",
                                      prefix: Icons.lock_clock,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          if (value != null)
                                            cubit.timingController.text = value
                                                .format(context)
                                                .toString();
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultFormField(
                                      onChange: (){},
                                      controller: cubit.dateController,
                                      type: TextInputType.datetime,
                                      isVaildator: true,
                                      validate: () {},
                                      label: "Task Date",
                                      prefix: Icons.calendar_today,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate:
                                              DateTime.parse("2022-01-01"),
                                        ).then((value) {
                                          if (value != null)
                                            cubit.dateController.text =
                                                DateFormat.yMMMd()
                                                    .format(value);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        elevation: 20,
                      ).closed.then((value) {cubit.changeBottomSheetState(icon: Icons.edit, isShow: false,);});
                  cubit.changeBottomSheetState(
                    icon: Icons.add,
                    isShow: true,
                  );
                }
              },
              child: Icon(
                cubit.floatingButtonIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archived",
                ),
              ],
            ),
            body: state is !getDataBaseLodingState
                ? cubit.screens[cubit.currentIndex]
                : Center(child: CircularProgressIndicator.adaptive()),
          );
        },
      ),
    );
  }
}
