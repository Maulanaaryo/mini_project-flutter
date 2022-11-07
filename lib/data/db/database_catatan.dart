import 'package:mini_project_alterra/data/models/movie_review.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelperReview {
  static DatabaseHelperReview? _databaseHelperReview;

  DatabaseHelperReview._internal() {
    _databaseHelperReview = this;
  }

  factory DatabaseHelperReview() =>
      _databaseHelperReview ?? DatabaseHelperReview._internal();

  static Database? _databaseReview;

  Future<Database?> get database async {
    _databaseReview = await _initDb();
    return _databaseReview;
  }

  final String _tblName = "review";

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/review.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT
      );
    ''');
  }

  Future<void> insertReview(ReviewModel reviewModel) async {
    final Database? db = await database;
    await db!.insert(_tblName, reviewModel.toMap());
  }

  Future<List<ReviewModel>> getReview() async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblName);

    return results.map((res) => ReviewModel.fromMap(res)).toList();
  }

  Future<ReviewModel> getReviewById(int id) async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(
      _tblName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => ReviewModel.fromMap(res)).first;
  }

  Future<void> updateReview(ReviewModel reviewModel) async {
    final db = await database;

    await db!.update(
      _tblName,
      reviewModel.toMap(),
      where: 'id = ?',
      whereArgs: [reviewModel.id],
    );
  }

  Future<void> deleteReview(int id) async {
    final db = await database;

    await db!.delete(
      _tblName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
