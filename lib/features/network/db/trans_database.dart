import 'package:momen/features/transaction/domain/usecase/post_transaction.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/error/exceptions.dart';
import '../../transaction/data/datasource/local/model/transaction_db_model.dart';

class TransDatabase {
  Database? _database;
  final String tableTrans = 'transaction';

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
    const idType = 'INTEGER PRIMARY KEY';
    const textTyp = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableTrans (
        '${TransFields.id}' $idType,
        '${TransFields.userID} $integerType,
        '${TransFields.description} $textTyp,
        '${TransFields.category} $textTyp,
        '${TransFields.amount} $integerType
      )
''');
  }

  Future<int> createTrans(TransactionDBParams params) async {
    final db = await database;

    final id = await db.insert(tableTrans, params.toJson());
    return id;
  }

  Future<TransactionDbResponse> readTrans(int id) async {
    final db = await database;
    final maps = await db.query(tableTrans,
        columns: TransFields.values,
        where: '${TransFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TransactionDbResponse.fromJson(maps.first);
    } else {
      throw CacheException('ID $id not found');
    }
  }

  Future<List<TransactionDbResponse>> readAllTrans() async {
    final db = await database;

    final result = await db.query(tableTrans);
    return result.map((json) => TransactionDbResponse.fromJson(json)).toList();
  }

  Future<TransactionDbResponse> updateTrans(TransactionDbResponse trans) async {
    final db = await database;

    final id = await db.update(
      tableTrans,
      trans.toJson(),
      where: '${TransFields.id} = ?',
      whereArgs: [trans.id],
    );
    return trans.copy(id: id);
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
