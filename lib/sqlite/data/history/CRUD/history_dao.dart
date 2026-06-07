import 'package:sqflite/sqflite.dart';
import '../../../data/database_helper.dart';
import 'package:un_ride/repository/repository.dart';

class HistoryDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // 1. Insertar nueva tarea
  Future<int> insert(ClientPost post) async {
    final db = await _dbHelper.database;

    // final modifiedPost = post.copyWith(
    //   travelDate: post.travelDate?.toIso8601String(),
    // );

    print('🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢🐢$post');
    return await db.insert(
      'ur_history',
      post.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 2. Obtener todas las tareas (ordenadas por fecha)
  Future<List<ClientPost>> findAll() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ur_history',
      // orderBy: 'fechaCreacion DESC',
    );

    return List.generate(maps.length, (i) {
      return ClientPost.fromMap(maps[i]);
    });
  }

  // 3. Obtener tarea por id
  Future<ClientPost?> findById(String userId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'ur_history',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return ClientPost.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // 4. Actualizar tarea existente
  Future<int> update(ClientPost post) async {
    final db = await _dbHelper.database;
    return await db.update(
      'ur_history',
      post.toMap(),
      where: 'userId = ?',
      whereArgs: [post.userId],
    );
  }

  // 5. Eliminar tarea por id
  Future<int> delete(String userId) async {
    final db = await _dbHelper.database;
    return await db.delete(
      'ur_history',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  // // 6. Contar tareas por estado (ejemplo de consulta con filtro)
  // Future<int> count(int completada) async {
  //   final db = await _dbHelper.database;
  //   final result = Sqflite.firstIntValue(
  //     await db.rawQuery('SELECT COUNT(*) FROM tarea WHERE completada = ?', [
  //       completada,
  //     ]),
  //   );
  //   return result ?? 0;
  // }
}
