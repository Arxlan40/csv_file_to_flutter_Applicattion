import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  String data;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readContent() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }

  Future<File> writeContent() async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString("contents");
  }

  @override
  void initState() {
    super.initState();
    writeContent();
    readContent().then((String value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reading and Writing data')),
      body: Center(
        child: Text(
          'Data read from a file: \n $data',
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
//
// // database table and column names
// final String columnwineColor = 'Color';
// final String columnwineType = 'Wine Type';
// final String columncountry = 'Country';
// final String columnwineRegion = 'Wine Region';
// final String columnvillage = 'Village';
// final String columngrapeVar = 'Grape Varieties';
// final String columnproducer = 'Producer';
// final String columnaging = 'Aging in Years';
// final String columnsuggestedBottle = 'Suggested Bottle';
// final String columnwebAdress = 'web address';
// final String columnnote = 'Notes';
// final String columnId = 'SerialSerial';
//
// final String name = 'Redwine';
//
// // data model class
// class RedWine {
//   String wineColor;
//   String wineType;
//   String country;
//   String wineRegion;
//   String village;
//   String grapeVar;
//   String producer;
//   String aging;
//   String suggestedBottle;
//   String webAdress;
//   String note;
//   String serial;
//
//   RedWine();
//
//   // convenience constructor to create a Word object
//   RedWine.fromMap(Map<String, dynamic> map) {
//     wineColor = map[columnwineColor];
//     wineType = map[columnwineType];
//     webAdress = map[columnwebAdress];
//     wineRegion = map[columnwineRegion];
//     grapeVar = map[columngrapeVar];
//     suggestedBottle = map[columnsuggestedBottle];
//     note = map[columnnote];
//     aging = map[columnaging];
//     country = map[columncountry];
//     producer = map[columnproducer];
//     village = map[columnvillage];
//     serial = map[columnId];
//   }
//
//   // convenience method to create a Map from this Word object
//   Map<String, dynamic> toMap() {
//     var map = <String, dynamic>{
//       columnvillage: village,
//       columnproducer: producer,
//       columncountry: country,
//       columnaging: aging,
//       columnnote: note,
//       columnsuggestedBottle: suggestedBottle,
//       columngrapeVar: grapeVar,
//       columnwineRegion: wineRegion,
//       columnwebAdress: webAdress,
//       columnwineType: wineType,
//       columnwineColor: wineColor,
//       columnId: serial,
//     };
//     if (serial != null) {
//       map[columnId] = serial;
//     }
//     return map;
//   }
// }
//
// // singleton class to manage the database
// class DatabaseHelper {
//   // This is the actual database filename that is saved in the docs directory.
//   static final _databaseName = "Redwine.db";
//
//   // Increment this version when you need to change the schema.
//   static final _databaseVersion = 1;
//
//   // Make this a singleton class.
//   DatabaseHelper._privateConstructor();
//
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//   // Only allow a single open connection to the database.
//   static Database _database;
//
//   Future<Database> get database async {
//     if (_database != null) return _database;
//     _database = await _initDatabase();
//     return _database;
//   }
//
//   // open the database
//   _initDatabase() async {
//     // The path_provider plugin gets the right directory for Android or iOS.
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, _databaseName);
//     // Open the database. Can also add an onUpdate callback parameter.
//     return await openDatabase(path,
//         version: _databaseVersion, onCreate: _onCreate);
//   }
//
//   // SQL string to create the database
//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//               CREATE TABLE $name (
//                 $columnwineColor TEXT NOT NULL,
//                 $columnaging TEXT NOT NULL,
//                 $columnwineType TEXT NOT NULL,
//                 $columngrapeVar TEXT NOT NULL,
//                 $columnvillage TEXT NOT NULL,
//                 $columnwineRegion TEXT NOT NULL,
//                 $columncountry TEXT NOT NULL,
//                 $columnproducer TEXT NOT NULL,
//                 $columnsuggestedBottle TEXT NOT NULL,
//                 $columnnote TEXT NOT NULL,
//                 $columnwebAdress TEXT NOT NULL,
//                 $columnId TEXT NOT NULL
//               )
//               ''');
//   }
//
//   // Database helper methods:
//
//   Future<int> insert(RedWine word) async {
//     Database db = await database;
//     int id = await db.insert(name, word.toMap());
//     return id;
//   }
//
//   Future<RedWine> queryWord(int id) async {
//     Database db = await database;
//     List<Map> maps = await db.query(name,
//         columns: [
//           columnId,
//           columnwebAdress,
//           columnnote,
//           columnsuggestedBottle,
//           columncountry,
//           columnproducer,
//           columnwineRegion,
//           columngrapeVar,
//           columnaging,
//           columnwineType,
//           columnwineColor,
//           columnvillage
//         ],
//         where: '$columnId = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return RedWine.fromMap(maps.first);
//     }
//     return null;
//   }
//
// // TODO: queryAllWords()
// // TODO: delete(int id)
// // TODO: update(Word word)
// }
