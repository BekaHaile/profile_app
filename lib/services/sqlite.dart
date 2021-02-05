import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user.dart';

//Creates a connection with a sqlite database and provides the functionalities
//to write, read, update and delete data on the database.
class Sqlite {
  static Database _db;
  static const String TABLE = 'User';
  static const String DB_NAME = 'user.db';

  static const String ID = 'id';
  static const String FIRSTNAME = 'firstName';
  static const String CITY = 'city';
  static const String USERNAME = 'userName';
  static const String PASSWORD = 'password';
  static const String PHONENUMBER = 'phoneNumber';
  static const String BANKNAME = 'bankName';
  static const String ACCOUNTNUMBER = 'accountNumber';

//A getter for the database that returns a name to the database if it already exists or
//calls a method to create a new one if one doesn't exist.
  Future<Database> get db async {
    if (_db != null)
      return _db;
    else {
      _db = await initDb();
      return _db;
    }
  }

/*
 * initDb:
 * Creates a database if a database has not been created yet.
 *
 * Arguments: none
 *
 * Return value: Future<Database>.
 *
 */
  Future<Database> initDb() async {
    // io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    io.Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    String path = join(appDocPath, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

/*
 * _onCreate:
 * Executes an sqlite statement to create a table in the database.
 *
 * Arguments:
 * -- db: the databse on which the table is to be created.
 * -- version: version of the database.
 *
 * Return value: none.
 *
 */
  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY, $FIRSTNAME TEXT, $CITY TEXT, $USERNAME TEXT, $PASSWORD TEXT, $PHONENUMBER TEXT, $BANKNAME TEXT, $ACCOUNTNUMBER TEXT )");
  }

/*
 * save:
 * Executes an sqlite statement to save a user into database.
 *
 * Arguments:
 * -- user: the user object to be saves to be saved to the database.
 *
 * Return value: Future<User>.
 *
 */
  Future<User> save(User user) async {
    var dbClient = await db;
    User userData = await getUsers();
    if (userData != null)
      update(user);
    else {
      try {
        await dbClient.insert(TABLE, user.toMap());
        print('data has been saved');
      } catch (e) {
        print(e);
      }
    }
    return user;
  }

/*
 * save:
 * Executes an sqlite statement to read list of users from the database.
 *
 * Arguments: none
 *
 * Return value: Future<List<User>>.
 *
 */
  Future<User> getUsers() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [
      ID,
      FIRSTNAME,
      CITY,
      USERNAME,
      PASSWORD,
      PHONENUMBER,
      BANKNAME,
      ACCOUNTNUMBER
    ]);

    List<User> users = [];

    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromMap(maps[i]));
      }
    }

    return users[0];
  }

/*
 * delete:
 * Executes an sqlite statement to delete a user from the database.
 *
 * Arguments: 
 * -- id: id of the user to be deleted
 *
 * Return value: Future<int>.
 *
 */
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

/*
 * update:
 * Executes an sqlite statement to update a users info that has already been written to the database.
 *
 * Arguments:
 * -- user: the user object to be updated.
 *
 * Return value: Future<int>.
 *
 */
  Future<int> update(User user) async {
    final dbClient = await db;
    try {
      return await dbClient
          .update(TABLE, user.toMap(), where: 'id = ?', whereArgs: [0]);
    } catch (e) {
      print(e);
      return null;
    }
  }

/*
 * close:
 * Closes the connection to the database.
 *
 * Arguments: none.
 *
 * Return value: none.
 *
 */
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
