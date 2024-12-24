import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sqflite/sqflite.dart';

import '../local/cache_helper.dart';
import 'AppState.dart';



class AppCubit extends Cubit<AppState>{
  AppCubit():super(AppInitialState());

  static AppCubit get(context)=> BlocProvider.of(context);
  List<Map> tasks =[];
  bool isButtonSheet = false;
  IconData fanIcon = Icons.edit;
  late Database database;
  int currentIndex = 0;
  List<Widget> screens = [
  // NewTaskScreen(),
  // DoneTaskScreen(),
  // ArchiveTaskScreen(),
  ];
  List<String> titles = [
    'New Task',
    'Done Task',
    'Archive Task'
  ];

  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeNavBarBottomState());
  }

  bool isDarkTheme = false;
  void changeThemeMode({bool? darkMode}){
    if(darkMode !=null) {
      isDarkTheme = darkMode;
    } else
      {
        isDarkTheme = !isDarkTheme;
        CacheHelper.setData(key: 'isDark', value: isDarkTheme).then((value) => {
          emit(AppThemeState())
        });
      }
  }

  void createDatabase()  {
    openDatabase('todo.db', version: 1,
        onCreate: (database, version) {
          print('database created');
          database
              .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
              .then((value) {
            print('table Created');
          }).catchError((error) {
            print('error when creating database ${error.toString()}');
          });
        }, onOpen: (database) {
       getDataFromDatabase(database);
          print('database opened');
        }).then((value) {
          database = value;
          emit(AppCreateDatabaseState());
    });
  }

   insertToDatabase(
      {required String title,
        required String time,
        required String date}) async {
     await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO Test( title, date,time,status) VALUES("$title", "$time", "$date","new")')
          .then((value) {
           emit(AppInsertDatabaseState());
            getDataFromDatabase(database);
        print('$value inserted done!');
      }).catchError((error) {});
    });
  }

 void getDataFromDatabase(database) async {
    return await database.rawQuery('SELECT *FROM Test').then((value) {
      tasks = value;
      emit(AppGetDatabaseState());
      print(tasks);
    });
    // print("The tasks is ");
    // print(tasks);
  }

  void updateTaskState (
       String status,
       int id
      ) async {
    database.rawUpdate(
        'UPDATE Test SET status = ? WHERE id = ?',
        ['$status', id]).then((value) => {
          getDataFromDatabase(database),
          emit(AppUpdateDatabaseState()),
    });
  }

  void updateTaskName (
      String name,
      int id
      ) async {
    database.rawUpdate(
        'UPDATE Test SET title = ? WHERE id = ?',
        ['$name', id]).then((value) => {
      getDataFromDatabase(database),
      emit(AppUpdateDatabaseState()),
    });
  }

  void deleteTask (
      int id
      ) async {
    database.rawDelete(
        'DELETE FROM Test WHERE id = ?',
        [id]).then((value) => {
      getDataFromDatabase(database),
      emit(AppDeleteDatabaseState()),
    });
  }
  void ChangeBottomSheetState({required bool bottomState, required  IconData icon}){
    fanIcon=icon;
    isButtonSheet = bottomState;
    emit(AppChangeBottomSheetState());
  }
}