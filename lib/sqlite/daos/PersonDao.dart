import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PersonDao {
    Future<Database> getDatabase() async {
        Database db = await openDatabase(
            join(await getDatabasesPath(), "person_database.db")
            onCreate: ((db, version) {
              return db.execute("CREATE TABLE Person(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, address TEXT)")
            }),
            version: 1
        );

        return db;
    }

    Future<List<Person>> readAll() async {
      final db = await getDatabase();
      List<Maps<String, dynamic>> maps = await db.query("Person");
            
      final result = List.generate(maps.length, (index) {
        final id = maps[index]['id'];
        return Person(
          id: int.tryParse(id.toString()),
          firstName: maps[index]['firstName'],
          lastName: maps[index]['lastName'],
          address: maps[index]['address']);          
      });

      return result;
    }

    Future<int> insetPerson(Person person) async {
      final db = await getDatabase();
      return db.insert("Person", person.toMap(), conflictAlgorithm: ConflictAlgotirthm.replace)

    }
}