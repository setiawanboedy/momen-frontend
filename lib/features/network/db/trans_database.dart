import 'package:momen/core/usecase/usecase.dart';
import 'package:momen/features/transaction/data/datasource/remote/model/transaction_list_response.dart';
import 'package:momen/features/transaction/data/datasource/remote/model/transaction_response.dart';

import '../../transaction/domain/usecase/post_transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/error/exceptions.dart';

class TransDatabase {

   Database? _database;
  final String tableTrans = 'transaction_table';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('transaction.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textTyp = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableTrans (
        ${TransFields.id} $idType,
        ${TransFields.userID} $integerType,
        ${TransFields.description},
        ${TransFields.category} $textTyp,
        ${TransFields.amount} $integerType
      )
''');
  }

  Future<int> createTrans(TransactionParams params) async {
    final db = await database;

    final id = await db.insert(tableTrans, params.toJson());
    return id;
  }

  Future<TransactionResponse> readTrans(int id) async {
    final db = await database;
    final maps = await db.query(tableTrans,
        columns: TransFields.values,
        where: '${TransFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      final data = Data.fromJson(maps.first);
      return TransactionResponse(data: data);
    } else {
      throw CacheException('ID $id not found');
    }
  }

  Future<TransactionListResponse> getAllTrans(NoParams params) async {
    final db = await database;

    final result = await db.query(tableTrans);
    final data = result.map((json) => Data.fromJson(json)).toList();
    return TransactionListResponse(data: data);
  }

  Future<int> updateTrans(TransactionParams trans) async {
    final db = await database;

    final id = await db.update(
      tableTrans,
      trans.toJson(),
      where: '${TransFields.id} = ?',
      whereArgs: [trans.transID],
    );

    return id;
  }

  Future<int> delete(int transID) async {
    final db = await database;
    final id = await db.delete(
      tableTrans,
      where: '${TransFields.id} = ?',
      whereArgs: [transID],
    );
    return id;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
