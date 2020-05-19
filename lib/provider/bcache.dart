import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

/// Model
class Piece {
  String id = Uuid().v1();
  String lot = "default";
  String body;

  Piece({String id, String lot, String body}) {
    if (id != null) this.id = id;
    if (lot != null) this.lot = lot;
    if (body != null) this.body = body;
  }

  factory Piece.fromJson(String lot, String body) {
    return Piece(lot: lot, body: body);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'lot': lot, 'body': body};
  }

  /// Implement toString to make it easier to see information about
  /// each piece when using the print statement.
  @override
  String toString() {
    return 'Piece{id: $id, lot: $lot, body: $body}';
  }
}

class BCache {
  /// @nhancv 10/7/2019: Create api instance
  BCache._private();

  static final BCache instance = BCache._private();

  /// @nhancv 10/7/2019: Database instance
  Future<Database> database;

  /// @nhancv 10/7/2019: Table name
  String _tableName;

  /// @nhancv 10/7/2019: Init database connection
  Future<void> init(
      {databaseName = "bcache_database.db", tableName = 'cache_data'}) async {
    this._tableName = tableName;
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), databaseName),
      // When the database is first created, create a table to store data.
      onCreate: (db, version) {
        // Data types: https://www.sqlite.org/datatype3.html
        return db.execute(
          'CREATE TABLE $_tableName (id TEXT PRIMARY KEY, lot TEXT, body TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  /// @nhancv 10/7/2019: Insert data to database
  Future<void> insert(Piece piece) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the data into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same data is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      _tableName,
      piece.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// @nhancv 10/7/2019: Query data from database
  Future<List<Piece>> query(String lot) async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> results =
        await db.query(_tableName, where: "lot = ?", whereArgs: [lot]);

    // Convert the List<Map<String, dynamic> into a List<Piece>.
    return List.generate(results.length, (i) {
      return Piece(
        id: results[i]['id'],
        lot: results[i]['lot'],
        body: results[i]['body'],
      );
    });
  }

  /// @nhancv 10/7/2019: Query data by id from database
  Future<Piece> queryId(String id) async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id]);

    if (results.length == 0) return null;
    return Piece(
      id: results[0]['id'],
      lot: results[0]['lot'],
      body: results[0]['body'],
    );
  }

  /// @nhancv 10/7/2019: Query data from database
  Future<List<Piece>> queryAll() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> results = await db.query(_tableName);

    // Convert the List<Map<String, dynamic> into a List<Piece>.
    return List.generate(results.length, (i) {
      return Piece(
        id: results[i]['id'],
        lot: results[i]['lot'],
        body: results[i]['body'],
      );
    });
  }

  /// @nhancv 10/7/2019: Update data
  Future<void> update(Piece piece) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given data.
    await db.update(
      _tableName,
      piece.toJson(),
      where: "id = ?",
      whereArgs: [piece.id],
    );
  }

  /// @nhancv 10/7/2019: Remove data by id
  Future<void> delete(String id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the data from the database.
    await db.delete(
      _tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// @nhancv 10/9/2019: Delete data in lot
  Future<void> deleteLot(String lot) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the data from the database.
    await db.delete(
      _tableName,
      where: "lot = ?",
      whereArgs: [lot],
    );
  }

  /// @nhancv 10/9/2019: Delete all
  Future<void> deleteAll() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the data from the database.
    await db.delete(_tableName);
  }

  /// @nhancv 10/7/2019: Execute SQL query
  Future<void> execute(String sql, [List<dynamic> arguments]) async {
    // Get a reference to the database.
    final db = await database;

    // Execute sql with arguments.
    await db.execute(sql, arguments);
  }
}

/// Example
//BCache bCache = BCache.instance;
//await bCache.init();
//
//// Piece instance
//var piece = Piece(
//  lot: "default",
//  body: "body1",
//);
//
//// Insert a piece into the database.
//await bCache.insert(piece);
//
//// Print the list of pieces (only piece for now).
//print(await bCache.query("default"));
//
//// Update piece's body and save it to the database.
//piece.body = "body2";
//await bCache.update(piece);
//
//// Print piece's updated information.
//print(await bCache.query("default"));
//
//// Delete piece from the database.
//await bCache.delete(piece.id);
//
//// Print the list of pieces (empty).
//print(await bCache.query("default"));
//
//// piece2 instance
//var piece2 = Piece(
//  lot: "lot2",
//  body: "body1",
//);
//
//// Insert a piece and piece2 into the database.
//await bCache.insert(piece);
//await bCache.insert(piece2);
//
//// Print all items (default and lot2)
//print(await bCache.queryAll());
//
//// Delete lot2
//await bCache.deleteLot("lot2");
//
//// Print all items (only default lot)
//print(await bCache.queryAll());
//
//// Delete all
//await bCache.deleteAll();
//
//// Print lot2 items
//print(await bCache.query("default"));
