// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'dart:convert';
//
// const String kFileName = 'winefav.json';
// const InputDecoration kInputDecoration = InputDecoration(
//   border: OutlineInputBorder(),
//   labelText: 'Label Text',
// );
// const TextStyle kInputTextStyle = TextStyle(
//   fontSize: 22,
//   color: Colors.blue,
// );
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   TextEditingController _controllerKey, _controllerValue;
//   bool _fileExists = false;
//   File _filePath;
//
//   // First initialization of _json (if there is no json in the file)
//   List _json = [];
//   String _jsonString;
//
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   Future<File> get _localFile async {
//     final path = await _localPath;
//     return File('$path/$kFileName');
//   }
//
//   void _writeJson(String key, dynamic value) async {
//     // Initialize the local _filePath
//     //final _filePath = await _localFile;
//
//     //1. Create _newJson<Map> from input<TextField>
//     List _newJson = [
//       {
//         "Color": "wineColor",
//         'Aging in Years': "aging",
//         "Wine Type": "wineType",
//         "Grape Varieties": "grapeVar",
//         "Village": "village",
//         "Wine Region": "wineRegion",
//         "Country": "France",
//         "Producer": "producer",
//         "Suggested Bottle": "ss",
//         "web address": "webAdress"
//       }
//     ];
//     print('1.(_writeJson) _newJson: $_newJson');
//
//     //2. Update _json by adding _newJson<Map> -> _json<Map>
//     _json.addAll(_newJson);
//     print('2.(_writeJson) _json(updated): $_json');
//
//     //3. Convert _json ->_jsonString
//     _jsonString = jsonEncode(_json);
//     print('3.(_writeJson) _jsonString: $_jsonString\n - \n');
//
//     //4. Write _jsonString to the _filePath
//     _filePath.writeAsString(_jsonString);
//   }
//
//   void _readJson() async {
//     // Initialize _filePath
//     _filePath = await _localFile;
//
//     // 0. Check whether the _file exists
//     _fileExists = await _filePath.exists();
//     print('0. File exists? $_fileExists');
//
//     // If the _file exists->read it: update initialized _json by what's in the _file
//     if (_fileExists) {
//       try {
//         //1. Read _jsonString<String> from the _file.
//         _jsonString = await _filePath.readAsString();
//         print('1.(_readJson) _jsonString: $_jsonString');
//
//         //2. Update initialized _json by converting _jsonString<String>->_json<Map>
//         _json = jsonDecode(_jsonString);
//         print('2.(_readJson) _json: $_json \n - \n');
//       } catch (e) {
//         // Print exception errors
//         print('Tried reading _file error: $e');
//         // If encountering an error, return null
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Instantiate _controllerKey and _controllerValue
//     _controllerKey = TextEditingController();
//     _controllerValue = TextEditingController();
//     print('0. Initialized _json: $_json');
//     _readJson();
//   }
//
//   @override
//   void dispose() {
//     _controllerKey.dispose();
//     _controllerValue.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Create JSON File'),
//         ),
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Text(
//                 'JSON: ',
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
//                 child: Text(_json.toString()),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 'Add to JSON file',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline4
//                     .copyWith(fontWeight: FontWeight.w700, color: Colors.blue),
//               ),
//               MyInputWidget(
//                 controller: _controllerKey,
//                 label: 'Key',
//               ),
//               MyInputWidget(
//                 controller: _controllerValue,
//                 label: 'Value',
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               RaisedButton(
//                 onPressed: () async {
//                   print(
//                       '0. Input key: ${_controllerKey.text}; Input value: ${_controllerValue.text}\n-\n');
//                   _writeJson(_controllerKey.text, _controllerValue.text);
//                   final file = await _localFile;
//                   _fileExists = await file.exists();
//                   //_fileName = file;
//
//                   setState(() {});
//                   _controllerKey.clear();
//                   _controllerValue.clear();
//                 },
//                 elevation: 25.0,
//                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
//                 //shape: ShapeBorder(),
//                 color: Theme.of(context).primaryColor,
//                 child: Text(
//                   'Add {Key, Value} pair',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14.0),
//                     child: Text(
//                       _fileExists
//                           ? _filePath.toString()
//                           : 'File doesn\'t exist.',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         color: Colors.black38,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class MyInputWidget extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//
//   MyInputWidget({this.controller, this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 40.0,
//         vertical: 15,
//       ),
//       child: TextField(
//         controller: controller,
//         decoration: kInputDecoration.copyWith(labelText: label),
//         style: kInputTextStyle,
//       ),
//     );
//   }
// }
// // import 'dart:io';
// // import 'package:path/path.dart';
// // import 'package:sqflite/sqflite.dart';
// // import 'package:path_provider/path_provider.dart';
// //
// // // database table and column names
// // final String columnwineColor = 'Color';
// // final String columnwineType = 'Wine Type';
// // final String columncountry = 'Country';
// // final String columnwineRegion = 'Wine Region';
// // final String columnvillage = 'Village';
// // final String columngrapeVar = 'Grape Varieties';
// // final String columnproducer = 'Producer';
// // final String columnaging = 'Aging in Years';
// // final String columnsuggestedBottle = 'Suggested Bottle';
// // final String columnwebAdress = 'web address';
// // final String columnnote = 'Notes';
// // final String columnId = 'SerialSerial';
// //
// // final String name = 'Redwine';
// //
// // // data model class
// // class RedWine {
// //   String wineColor;
// //   String wineType;
// //   String country;
// //   String wineRegion;
// //   String village;
// //   String grapeVar;
// //   String producer;
// //   String aging;
// //   String suggestedBottle;
// //   String webAdress;
// //   String note;
// //   String serial;
// //
// //   RedWine();
// //
// //   // convenience constructor to create a Word object
// //   RedWine.fromMap(Map<String, dynamic> map) {
// //     wineColor = map[columnwineColor];
// //     wineType = map[columnwineType];
// //     webAdress = map[columnwebAdress];
// //     wineRegion = map[columnwineRegion];
// //     grapeVar = map[columngrapeVar];
// //     suggestedBottle = map[columnsuggestedBottle];
// //     note = map[columnnote];
// //     aging = map[columnaging];
// //     country = map[columncountry];
// //     producer = map[columnproducer];
// //     village = map[columnvillage];
// //     serial = map[columnId];
// //   }
// //
// //   // convenience method to create a Map from this Word object
// //   Map<String, dynamic> toMap() {
// //     var map = <String, dynamic>{
// //       columnvillage: village,
// //       columnproducer: producer,
// //       columncountry: country,
// //       columnaging: aging,
// //       columnnote: note,
// //       columnsuggestedBottle: suggestedBottle,
// //       columngrapeVar: grapeVar,
// //       columnwineRegion: wineRegion,
// //       columnwebAdress: webAdress,
// //       columnwineType: wineType,
// //       columnwineColor: wineColor,
// //       columnId: serial,
// //     };
// //     if (serial != null) {
// //       map[columnId] = serial;
// //     }
// //     return map;
// //   }
// // }
// //
// // // singleton class to manage the database
// // class DatabaseHelper {
// //   // This is the actual database filename that is saved in the docs directory.
// //   static final _databaseName = "Redwine.db";
// //
// //   // Increment this version when you need to change the schema.
// //   static final _databaseVersion = 1;
// //
// //   // Make this a singleton class.
// //   DatabaseHelper._privateConstructor();
// //
// //   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
// //
// //   // Only allow a single open connection to the database.
// //   static Database _database;
// //
// //   Future<Database> get database async {
// //     if (_database != null) return _database;
// //     _database = await _initDatabase();
// //     return _database;
// //   }
// //
// //   // open the database
// //   _initDatabase() async {
// //     // The path_provider plugin gets the right directory for Android or iOS.
// //     Directory documentsDirectory = await getApplicationDocumentsDirectory();
// //     String path = join(documentsDirectory.path, _databaseName);
// //     // Open the database. Can also add an onUpdate callback parameter.
// //     return await openDatabase(path,
// //         version: _databaseVersion, onCreate: _onCreate);
// //   }
// //
// //   // SQL string to create the database
// //   Future _onCreate(Database db, int version) async {
// //     await db.execute('''
// //               CREATE TABLE $name (
// //                 $columnwineColor TEXT NOT NULL,
// //                 $columnaging TEXT NOT NULL,
// //                 $columnwineType TEXT NOT NULL,
// //                 $columngrapeVar TEXT NOT NULL,
// //                 $columnvillage TEXT NOT NULL,
// //                 $columnwineRegion TEXT NOT NULL,
// //                 $columncountry TEXT NOT NULL,
// //                 $columnproducer TEXT NOT NULL,
// //                 $columnsuggestedBottle TEXT NOT NULL,
// //                 $columnnote TEXT NOT NULL,
// //                 $columnwebAdress TEXT NOT NULL,
// //                 $columnId TEXT NOT NULL
// //               )
// //               ''');
// //   }
// //
// //   // Database helper methods:
// //
// //   Future<int> insert(RedWine word) async {
// //     Database db = await database;
// //     int id = await db.insert(name, word.toMap());
// //     return id;
// //   }
// //
// //   Future<RedWine> queryWord(int id) async {
// //     Database db = await database;
// //     List<Map> maps = await db.query(name,
// //         columns: [
// //           columnId,
// //           columnwebAdress,
// //           columnnote,
// //           columnsuggestedBottle,
// //           columncountry,
// //           columnproducer,
// //           columnwineRegion,
// //           columngrapeVar,
// //           columnaging,
// //           columnwineType,
// //           columnwineColor,
// //           columnvillage
// //         ],
// //         where: '$columnId = ?',
// //         whereArgs: [id]);
// //     if (maps.length > 0) {
// //       return RedWine.fromMap(maps.first);
// //     }
// //     return null;
// //   }
// //
// // // TODO: queryAllWords()
// // // TODO: delete(int id)
// // // TODO: update(Word word)
// // }
