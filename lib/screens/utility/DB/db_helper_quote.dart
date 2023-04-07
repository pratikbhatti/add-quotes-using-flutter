import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelperQuote {
  static DbHelperQuote dbHelperQuote = DbHelperQuote._();

  DbHelperQuote._();

  Database? database;

  ///check Category table
  Future<Database?> checkQuoteDB() async {
    if (database != null) {
      return database;
    } else {
      return await createQuoteDB();
    }
  }

  /// create Quote table
  Future<Database> createQuoteDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'pratikquote.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query1 =
            "CREATE TABLE quote (id INTEGER PRIMARY KEY AUTOINCREMENT,quote_name TEXT,author_name TEXT, select_category TEXT)";
        String query2 =
            "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT,category_name TEXT,category_image BLOB)";

        db.execute(query1);
        db.execute(query2);
      },
    );
  }

  ///insert Quote table
  void insertQuoteData(
      {required String quote_name,
      required String author_name,
      required String select_category}) async {
    database = await checkQuoteDB();
    database!.insert("quote", {
      "quote_name": quote_name,
      "author_name": author_name,
      "select_category ": select_category,
    });
  }

  /// read quote table
  Future<List<Map>> readQuoteData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// delete category table
  Future<void> deleteQuoteData({required int id}) async {
    database = await checkQuoteDB();
    database!.delete("quote", where: "id =? ", whereArgs: [id]);
  }

  /// update category
  Future<void> updateQuoteData({
    required int id,
    required String quote_name,
    required String author_name,
  }) async {
    database = await checkQuoteDB();
    database!.update(
        "quote",
        {
          'quote_name': quote_name,
          'author_name': author_name,
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  /// check Quote table
// Future<Database?> checkQuoteDB() async {
//   if (database != null) {
//     return database;
//   } else {
//     return await createQuoteDB();
//   }
// }

  /// create Quote table
// Future<Database> createQuoteDB() async {
//   Directory directory = await getApplicationDocumentsDirectory();
//   String path = join(directory.path, 'pratik.db');
//   return openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) {
//       String query =
//           "CREATE TABLE quote (id INTEGER PRIMARY KEY AUTOINCREMENT,quote_name TEXT,author_name TEXT,select_category TEXT)";
//       db.execute(query);
//     },
//   );
// }

  ///insert Category table
  void insertCategoryData({required String category_name, String? path}) async {
    database = await checkQuoteDB();

    ///insert image
    Uint8List? data;
    File file = File("$path");
    await file.readAsBytes().then((value) => {
          data = value,
        });
    database!.insert("category", {
      "category_name": category_name,
      "category_image": data,
    });
  }

  /// read category table
  Future<List<Map>> readCategoryData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM category";
    List<Map> dataList = await database!.rawQuery(query);

    return dataList;
  }

  /// delete category table
  Future<void> deleteCategoryData({required int id}) async {
    database = await checkQuoteDB();
    database!.delete("category", where: "id =? ", whereArgs: [id]);
  }

  /// read quotes drop down category
  Future<List<Map>> readQuotesData() async {
    database = await checkQuoteDB();
    String query = "SELECT category_name FROM category";
    List<Map> dataList = await database!.rawQuery(query);
    print("======================");
    return dataList;
  }

  /// update category name
  Future<void> updateCategoryData({
    required int id,
    required String category_name,
  }) async {
    database = await checkQuoteDB();
    database!.update(
        "category",
        {
          'category_name': category_name,
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  /// read home view table
// Future<List<Map>> readHomeViewData(String select_category) async {
//   database = await checkCategoryDB();
//   String query = "SELECT * FROM quote WHERE select_category = '$select_category'";
//   List<Map> dataList = await database!.rawQuery(query);
//   return dataList;
// }
  /// homePage Click View
  Future<List<Map>> readHomeViewData(String select_category) async {
    database = await checkQuoteDB();
    String query =
        "SELECT * FROM quote WHERE select_category = $select_category";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Quote motivation view
  Future<List<Map>> readMotivationViewData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote WHERE select_category = 'motivation'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Quote love view
  Future<List<Map>> readLoveViewData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote WHERE author_name = 'love'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Quote Teaching view
  Future<List<Map>> readTeachingViewData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote WHERE select_category = 'teaching'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Quote Teaching view
  Future<List<Map>> readFriendshipViewData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote WHERE select_category = 'friendship'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Author Swaminarayan view
  Future<List<Map>> readSwaminarayanViewData() async {
    database = await checkQuoteDB();
    String query = "SELECT * FROM quote WHERE select_category = 'swaminarayan'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  /// Author sandeep maheshwari view
  Future<List<Map>> readSandeepMaheshwariData() async {
    database = await checkQuoteDB();
    String query =
        "SELECT * FROM quote WHERE select_category = 'sandeep'";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }
}
