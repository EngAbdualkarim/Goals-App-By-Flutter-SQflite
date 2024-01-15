import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goalsappdatabase/layouts/main_layout/cubit/main_states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit() : super(InitSate());

  static MainCubit get(context) => BlocProvider.of(context);
  List<Map> goalsList=[];
  var addTextController=TextEditingController();

  initSql() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''CREATE TABLE Goals
               (id INTEGER PRIMARY KEY, 
               name TEXT)''');
    });
  }

  getData() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);
    await database.rawQuery('SELECT * FROM Goals').then((value) {
      goalsList = value;
      emit(GetDataSuccessState());
    }).catchError((onError) {
      emit(GetDataErrorState());
      print(onError.toString());
    });
    database.close();
  }


  inserData(String name)async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);
    await database.rawInsert(
        'INSERT INTO Goals(name) VALUES(?)',
        ['$name']).then((value) {
      emit(InsertDataSuccessState());
    }).catchError((onError) {
      emit(InsertDataErrorState());
      print(onError.toString());
    });
    database.close();
  }

  removeData(int id)async{
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'goals.db');
    Database database = await openDatabase(path);
    await database.rawDelete('DELETE FROM Goals WHERE id = ?', ['$id']).then((value) {
      emit(RemoveDataSuccessState());
    }).catchError((onError) {
      emit(RemoveDataErrorState());
      print(onError.toString());
    });
    database.close();
  }


}
