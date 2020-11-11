// // import 'dart:io';
// //
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:search_widget/search_widget.dart';
// // import 'dart:convert';
// //
// // import 'model.dart';
// //
// // // Sets a platform override for desktop to avoid exceptions. See
// // // https://flutter.dev/desktop#target-platform-override for more info.
// //
// // class MyApps extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Search ',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blueGrey,
// //       ),
// //       debugShowCheckedModeBanner: false,
// //       home: HomePage(),
// //     );
// //   }
// // }
// //
// // class HomePage extends StatefulWidget {
// //   @override
// //   _HomePageState createState() => _HomePageState();
// // }
// //
// // class _HomePageState extends State<HomePage> {
// //   Future<String> _loadFromAsset() async {
// //     return await rootBundle.loadString("assets/files/data2.json");
// //   }
// //
// //   bool loading = false;
// //
// //   List<Red> list;
// //
// //   Red _selectedItem;
// //
// //   bool _show = true;
// //
// //   @override
// //   void initState() {
// //     _loadFromAsset();
// //     getdata();
// //     super.initState();
// //   }
// //
// //   Future getdata() async {
// //     // try {
// //     setState(() {
// //       loading = true;
// //     });
// //     List<Red> lists;
// //
// //     String jsonString = await _loadFromAsset();
// //     final jsonResponse = jsonDecode(jsonString);
// //     print(jsonResponse["Sheet1"]);
// //     lists = jsonResponse["Sheet1"].map<Red>((json) => Red.fromJson(json)).toList();
// //     setState(() {
// //       list = lists;
// //       loading = false;
// //     });
// //     // } catch (e) {
// //     // }
// //   }
// //
// //   String drop = "Country";
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Search"),
// //       ),
// //       body: loading
// //           ? CircularProgressIndicator()
// //           : SingleChildScrollView(
// //         padding: const EdgeInsets.symmetric(vertical: 16),
// //         child: Column(
// //           children: <Widget>[
// //
// //             const SizedBox(
// //               height: 16,
// //             ),
// //          Padding(
// //            padding: const EdgeInsets.only(left:20.0),
// //            child: Row(children: [   Text("Select Query for Search:   "),
// //
// //              DropdownButton(
// //                focusColor: Colors.blue,
// //                hint: Text(drop),
// //                //text shown on the button (optional)
// //                elevation: 3,
// //                items: <String>[
// //                  'Wine Type',
// //                  'Grape Varieties',
// //                  'Village',
// //                  'Wine Region',
// //                  "Country",
// //                  "Producer",
// //                  "Suggested Bottle",
// //                  "web address"
// //                ]
// //                    .map((String val) =>
// //                    DropdownMenuItem<String>(
// //                      value: val,
// //                      child: Text(val),
// //                    ))
// //                    .toList(),
// //                onChanged: (value) {
// //                  setState(() {
// //                    drop = value;
// //                  });
// //                },
// //              ),],),
// //          ),
// //             if (_show)
// //               SearchWidget<Red>(
// //                 dataList: list,
// //                 hideSearchBoxWhenItemSelected: false,
// //                 listContainerHeight:
// //                 MediaQuery
// //                     .of(context)
// //                     .size
// //                     .height / 4,
// //                 queryBuilder: (query, list) {
// //                   return list
// //                       .where(
// //                           (item) =>item.producer
// //                       // drop == "Country" ? item.country : drop ==
// //                       //     "Wine Type" ? item.wineType : drop ==
// //                       //     "Grape Varieties" ? item.grapeVarieties : drop ==
// //                       //     "Village" ? item.village : drop ==
// //                       //     "Wine Region" ? item.wineRegion : drop ==
// //                       //     "Producer" ? item.producer : drop ==
// //                       //     "Suggested Bottle" ? item.suggestedBottle :
// //                       // item.webAddress
// //
// //                           .toLowerCase()
// //                           .contains(query.toLowerCase()))
// //                       .toList();
// //                 },
// //                 popupListItemBuilder: (item) {
// //                   return PopupListItemWidget(item,drop);
// //                 },
// //                 selectedItemBuilder: (selectedItem, deleteSelectedItem) {
// //                   return SelectedItemWidget(
// //                       selectedItem, deleteSelectedItem);
// //                 },
// //                 // widget customization
// //                 noItemsFoundWidget: NoItemsFound(),
// //                 textFieldBuilder: (controller, focusNode) {
// //                   return MyTextField(controller, focusNode);
// //                 },
// //                 onItemSelected: (item) {
// //                   setState(() {
// //                     _selectedItem = item;
// //                   });
// //                 },
// //               ),
// //             const SizedBox(
// //               height: 32,
// //             ),
// //
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class SelectedItemWidget extends StatelessWidget {
// //   const SelectedItemWidget(this.selectedItem, this.deleteSelectedItem);
// //
// //   final Red selectedItem;
// //   final VoidCallback deleteSelectedItem;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(
// //         vertical: 2,
// //         horizontal: 4,
// //       ),
// //       child: Row(
// //         children: <Widget>[
// //           Expanded(
// //             child: Padding(
// //               padding: const EdgeInsets.only(
// //                 left: 16,
// //                 right: 16,
// //                 top: 8,
// //                 bottom: 8,
// //               ),
// //               child:
// //               SingleChildScrollView(
// //                 scrollDirection: Axis.vertical,
// //
// //                 child: SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //
// //                   child: DataTable(
// //                     // sortColumnIndex: 1,
// //                     // sortAscending: true,
// //
// //                     columns: const <DataColumn>[
// //                       DataColumn(
// //                         label: Text(
// //                           'Color',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Aging in Years',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Wine Type',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Grape Varieties',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Village',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Wine Region',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Country',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Producer',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Suggested Bottle',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Notes',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                       DataColumn(
// //                         label: Text(
// //                           'Web address',
// //                           style: TextStyle(fontStyle: FontStyle.italic),
// //                         ),
// //                       ),
// //                     ],
// //                     rows:  <DataRow>[
// //                       DataRow(
// //                         cells: <DataCell>[
// //                           DataCell(Text(selectedItem.color != null ? selectedItem.color : "" )),
// //                           DataCell(Text(selectedItem.agingInYears != null ? selectedItem.agingInYears : "")),
// //                           DataCell(Text(selectedItem.wineType != null ? selectedItem.wineType : "")),
// //                           DataCell(Text(selectedItem.grapeVarieties != null ? selectedItem.grapeVarieties : "")),
// //                           DataCell(Text(selectedItem.village != null ? selectedItem.village : "")),
// //                           DataCell(Text(selectedItem.wineRegion != null ? selectedItem.wineRegion : "")),
// //                           DataCell(Text(selectedItem.country != null ? selectedItem.country : "")),
// //                           DataCell(Text(selectedItem.producer != null ? selectedItem.producer : "")),
// //                           DataCell(Text(selectedItem.suggestedBottle != null ? selectedItem.suggestedBottle : "")),
// //                           DataCell(Text(selectedItem.notes != null ? selectedItem.notes : "")),
// //
// //                           DataCell(Text(selectedItem.webAddress)),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //           // IconButton(
// //           //   icon: Icon(Icons.delete_outline, size: 22),
// //           //   color: Colors.grey[700],
// //           //   onPressed: deleteSelectedItem,
// //           // ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // class MyTextField extends StatelessWidget {
// //   const MyTextField(this.controller, this.focusNode);
// //
// //   final TextEditingController controller;
// //   final FocusNode focusNode;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //       child: TextField(
// //         controller: controller,
// //         focusNode: focusNode,
// //         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
// //         decoration: InputDecoration(
// //           enabledBorder: const OutlineInputBorder(
// //             borderSide: BorderSide(
// //               color: Color(0x4437474F),
// //             ),
// //           ),
// //           focusedBorder: OutlineInputBorder(
// //             borderSide: BorderSide(color: Theme
// //                 .of(context)
// //                 .primaryColor),
// //           ),
// //           suffixIcon: Icon(Icons.search),
// //           border: InputBorder.none,
// //           hintText: "Search here...",
// //           contentPadding: const EdgeInsets.only(
// //             left: 16,
// //             right: 20,
// //             top: 14,
// //             bottom: 14,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class NoItemsFound extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: <Widget>[
// //         Icon(
// //           Icons.folder_open,
// //           size: 24,
// //           color: Colors.grey[900].withOpacity(0.7),
// //         ),
// //         const SizedBox(width: 10),
// //         Text(
// //           "No Items Found",
// //           style: TextStyle(
// //             fontSize: 16,
// //             color: Colors.grey[900].withOpacity(0.7),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// //
// // class PopupListItemWidget extends StatelessWidget {
// //   const PopupListItemWidget(this.item,this.drop);
// //
// //   final Red item;
// //   final String drop;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.all(12),
// //       child: Text(
// //         drop == "Country" ? item.country : drop ==
// //             "Wine Type" ? item.wineType : drop ==
// //             "Grape Varieties" ? item.grapeVarieties : drop ==
// //             "Village" ? item.village : drop ==
// //             "Wine Region" ? item.wineRegion : drop ==
// //             "Producer" ? item.producer : drop ==
// //             "Suggested Bottle" ? item.suggestedBottle :
// //         item.webAddress,
// //         style: const TextStyle(fontSize: 16),
// //       ),
// //     );
// //   }
// // }
// // ListView.builder(
// // shrinkWrap: true,
// // physics: ScrollPhysics(),
// // itemCount: 20,
// // //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
// // scrollDirection: Axis.vertical,
// // itemBuilder: (BuildContext context, index) {
// // return Column(
// // children: [
// // Row(
// // crossAxisAlignment: CrossAxisAlignment.start,
// // children: <Widget>[
// // Expanded(
// // child: Padding(
// // padding: const EdgeInsets.only(
// // top: 10.0, left: 10),
// // child: Container(
// // padding: EdgeInsets.only(left: 5),
// // child: Column(
// // mainAxisAlignment:
// // MainAxisAlignment.center,
// // crossAxisAlignment:
// // CrossAxisAlignment.start,
// // children: <Widget>[
// // Text(
// // "France",
// // style: TextStyle(
// // fontSize: 16,
// // ),
// // ),
// // Text(
// // "Red Wine",
// // style: TextStyle(
// // fontSize: 14,
// // color: Colors.grey),
// // ),
// // ],
// // ),
// // ),
// // ),
// // ),
// // Padding(
// // padding: const EdgeInsets.only(
// // top: 20.0, right: 10),
// // child: Icon(
// // Icons.arrow_forward_ios,
// // color: Colors.grey,
// // ),
// // ),
// // ],
// // ),
// // Divider(),
// // ],
// // );
// // });
//
//
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
//
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
