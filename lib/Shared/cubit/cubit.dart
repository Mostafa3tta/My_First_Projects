import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_proj/Shared/cubit/states.dart';
import 'package:my_first_proj/Shared/network/local/cache_helper.dart';
import 'package:my_first_proj/modules/todo_tasks/archived_tasks/archived_tasks_screen.dart';
import 'package:my_first_proj/modules/todo_tasks/done_tasks/done_tasks_screen.dart';
import 'package:my_first_proj/modules/todo_tasks/new_tasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(appInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  late Database database;
  var titleController = TextEditingController();
  var timingController = TextEditingController();
  var dateController = TextEditingController();
  int currentIndex = 0;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    "New Tasks Screen",
    "Done Screen",
    "Archived Screen",
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(appChangeBottomNabBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database is created');
        database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('table is created');
        }).catchError((error) {
          print('error when create Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataBase(database);
        print('database is opened');
      },
    ).then((value) {
      database = value;
      emit(appCreateDababaseState());
    });
  }

  insertToDatabase({
    required String? title,
    required String? time,
    required String? date,
  }) async {
    await database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfully');

        emit(appInsertDababaseState());

        getDataBase(database);
      }).catchError((error) {
        print('error when inserted row in Table ${error.toString()}');
      });
    });
  }

  void getDataBase(database)
  {
    emit(getDataBaseLodingState());

    newTasks=[];
    doneTasks=[];
    archivedTasks=[];

    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element) {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);

      });

      emit(appgetDababaseState());
    });
  }

  void updateDatabase({
  required String status,
  required int id,
}) async {
     database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id]
    ).then((value){
       getDataBase(database);
      emit(appUpdateDababaseState());
     });
  }

  void deleteDatabase({required int id})
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){
      getDataBase(database);
      emit(appDeleteDababaseState());
    });
  }

  bool isBottomSheet = false ;
  IconData floatingButtonIcon = Icons.edit ;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    floatingButtonIcon = icon;
    emit(changeButtomSheetStates());
  }

  bool isDark=false;

  void changeAppMode({bool? fromShared})
  {
    if(fromShared!=null) {
      isDark = fromShared;
      emit(AppChangeModeStates());
    }else {
      isDark = !isDark;
      CashHelper.putBoolData(key: 'isDark', value: isDark).then((value) =>
          emit(AppChangeModeStates()));
    }
  }
}
