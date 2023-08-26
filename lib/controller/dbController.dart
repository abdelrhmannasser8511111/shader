import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

import '../model/resala.dart';
import '../view/widget/commonWidgit.dart';
import 'dataRepo.dart';

// Database? db ;
// fun ()async{
//   db=await sqlite3.;
//   db?.execute("CREATE TABLE A ,CREATE TABLE B");
// }
class SqlHelper {
  static late final Database database;

  SqlHelper() {}

  //createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  static Future<void> _createTables(Database database) async {
    await database.execute("""CREATE TABLE moshtry(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        phonNumb INTEGER,
        notice TEXT
      )
      """);
    await database.execute("""CREATE TABLE mwared(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT NOT NULL UNIQUE,
        address TEXT,
        phonNumb INTEGER,
        credit REAL,
        notice TEXT
      )
      """);
    await database.execute("""CREATE TABLE resala(
        resalaId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        status TEXT,
        nameofmwared TEXT,
        resalaDescription TEXT,
        nawloon REAL,
        catCount INTEGER,
        ctegoriesDetails TEXT,
        mwaredId INTEGER,
        totalCountOfBoxes INTEGER,
        TotalNetWeight REAL,
        amola REAL
      )
      """);
    await database.execute("""CREATE TABLE sellingData(
        sellingProcessId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        resalName TEXT,
        amola REAL,
        calculationMethod TEXT,
        bwabaValue REAL,
        totalAfterBwaba REAL,
        sellingPrice REAL,
        gettenMoney REAL,
        remainningofTotalMoney REAL,
        numbOfBox INTEGER,
        weight REAL,
        customerName TEXT,
        date TEXT,
        resalaNumberForTheDay INTEGER,
        resalaId INTEGER,
        notice TEXT,
        categoryFresala TEXT
      )
      """);
  }

  static chekDb() async {
    var databaseFactory = databaseFactoryFfi;
    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();
    print("appDocumentsDir${appDocumentsDir}");

    //Create path for database
    String dbPath = p.join(appDocumentsDir.path, "databases", "shader.db");

    database = await databaseFactory.openDatabase(dbPath,
        options:await OpenDatabaseOptions(
            version: 1,
            onCreate: (db, version) async {
              print("Database created tables");

              await _createTables(db);
            },
            onOpen: (_) async{
              print("Database is open");

            },
          ));
    print(
        'database.getVersion() ${database.getVersion().then((value) => debugPrint("${value}"))}');
    database.isOpen?await allDataGet():null;
  }


  static Future createItem(
      {required String TableNameAsWrittenINDB, required var modelData}) async {
    // final db = await SQLHelper.db();

    // final data = {'title': title, 'description': descrption};
try{
      final id = await database.insert(
          TableNameAsWrittenINDB, modelData.toJson(),
          conflictAlgorithm: ConflictAlgorithm.fail);
      print("iiiidd${id}");
      // print(
      //     "${await SqlHelper.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB)}");
      // return id;
      // SqlHelper.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB);

      // print("test${await SqlHelper.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB)}");
      // print("test${await bloc.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB)}");

      if(id is int && id !=0 ){
        await bloc.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB);
      return id;
    }else return id;}
    catch(v){
  return v;
    }
  }

// Read all items (journals)
  static Future<List<Map<String, dynamic>>> getData(
      {required String TableNameAsWrittenInDB}) async {
    // final db = await SQLHelper.db();

    final tableData = await database.query(TableNameAsWrittenInDB);
    // print("tableData${tableData}");
    return tableData;
  }

  // Read a single item by id
  static Future<List<Map<String, dynamic>>> getItem(
      {required int id, required String TableNameAsWrittenInDB}) async {
    // final db = await SQLHelper.db();
    return database.query(TableNameAsWrittenInDB,
        where: TableNameAsWrittenInDB == 'mwared' ||
            TableNameAsWrittenInDB == 'moshtry'
            ? "id = ?"
            : TableNameAsWrittenInDB == 'resala'
            ? "resalaId = ?"
            : TableNameAsWrittenInDB == 'sellingData'
            ? 'sellingProcessId = ?'
            : null, whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future updateItem(
      {required String TableNameAsWrittenINDB,
      required var modelData,required int id,
      required BuildContext context}) async {
    // final db = await SQLHelper.db();

    // final data = {
    //   'title': title,
    //   'description': descrption,
    //   'createdAt': DateTime.now().toString()
    // };
    // try {} catch (err) {}
    try{
    final result = await database.update(
        TableNameAsWrittenINDB, modelData.toJson(),
        where: TableNameAsWrittenINDB == 'mwared' ||
                TableNameAsWrittenINDB == 'moshtry'
            ? "id = ?"
            : TableNameAsWrittenINDB == 'resala'
                ? "resalaId = ?"
                : TableNameAsWrittenINDB == 'sellingData'
                    ?
        "sellingProcessId = ?"
                    : null,
        whereArgs: [id]);
    print("result ${result}");

    if (result is int && result !=0) {
      TableNameAsWrittenINDB == 'resala'?categoriesTableDetails.clear():null;
      print("updateDoneWithValue $result");
      await bloc.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB);
      Navigator.of(context).pop();
      return snackBar(context: context, content: 'تمت العمليه بنجاح');
    } else {
      errDialog(context: context, err: result.toString());

    }}catch(err){
      errDialog(context: context, err: err.toString());
    }
  }

  // Delete
  static Future<Object> deleteItem(
      {required String TableNameAsWrittenINDB, required List<int> id}) async {
    print("id$id");
    // final db = await SQLHelper.db();

    final db = await database.delete(TableNameAsWrittenINDB,
        where: TableNameAsWrittenINDB == 'mwared' ||
            TableNameAsWrittenINDB == 'moshtry'
            ? 'id IN (${List.filled(id.length, '?').join(',')})'
            : TableNameAsWrittenINDB == 'resala'
            ? 'resalaId IN (${List.filled(id.length, '?').join(',')})'
            : TableNameAsWrittenINDB == 'sellingData'
            ? 'sellingProcessId IN (${List.filled(id.length, '?').join(',')})'//'sellingProcessId = ?'
            : null,

        whereArgs: id);
    print("deleted resbonse is $db");

    if (db is int && db != 0) {
      await bloc.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB);
    } else {
      return db;
    }
    return db;
    //   try {
    //     final db =   await database.delete(TableNameAsWrittenINDB, where: "id = ?", whereArgs: id);
    //     print("dddddddddddbbbbbbbbbb$db");
    //
    //     if(db==1){
    //       bloc.getData(TableNameAsWrittenInDB: TableNameAsWrittenINDB);
    //     }else{
    //       return db;
    //     }
    //     return db;
    //   } catch (err) {
    //     debugPrint("Something went wrong when deleting an item: $err");
    //     return err;
    //
    //   }
  }

//Delete Table
  static Future<void> deletetable(
      {required String TableNameAsWrittenINDB}) async {
    // final db = await SQLHelper.db();
    try {
      await database.delete(TableNameAsWrittenINDB);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // add new column in specific table
  static void alterTable() async {
    await database.execute("ALTER TABLE resala ADD endworld TEXT");
  }

//change column name in table
  static void cangeNameOfColumn() async {
    await database.execute("ALTER TABLE resala RENAME COLUMN resalaId TO id");
  }
// ALTER TABLE tmp_table_name RENAME TO orig_table_name;  sql command to change Table name

//  static void _onUpgrade(Database db, int oldVersion, int newVersion) {
//     print("Database created tables");
//     if (oldVersion < newVersion) {
//       db.execute("ALTER TABLE resala ADD COLUMN newCol TEXT;");
//     }
//   }
}

