import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
  CREATE TABLE meal (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  mealTime TEXT,
  name TEXT,
  kiloCaloriesBurnt TEXT,
  time TEXT,
  ingredients TEXT,
  preparation TEXT
  )
  ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'meal.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> addMeal(
      String mealTime,
      String name,
      String kiloCaloriesBurnt,
      String time,
      List ingredients,
      String preparation) async {
    final db = await SQLHelper.db();
    final data = {
      'mealTime': mealTime,
      'name': name,
      'kiloCaloriesBurnt': kiloCaloriesBurnt,
      'time': time,
      'ingredients': ingredients,
      'preparation': preparation
    };
    return await db.insert('meal', data);
  }

  static Future<List<Map<String, dynamic>>> getMeal(
      String mealTime,
      String name,
      String kiloCaloriesBurnt,
      String time,
      String ingredients,
      String preparation,
      String imageController) async {
    final db = await SQLHelper.db();
    return db.query('meal');
  }
}
