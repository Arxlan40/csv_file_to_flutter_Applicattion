import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadsheet/Webview.dart';
import 'package:get/get.dart';
import 'package:spreadsheet/model.dart';

const String kFileName = 'winefav.json';

class DetailScreen extends StatefulWidget {
  String wineColor;
  String wineType;
  String country;
  String wineRegion;
  String village;
  String grapeVar;
  String producer;
  String aging;
  String suggestedBottle;
  String webAdress;
  String note;
  String addnote;
  String serial;

  bool fav;

  DetailScreen(
      {this.producer,
      this.serial,
      this.country,
      this.suggestedBottle,
      this.wineRegion,
      this.wineType,
      this.village,
      this.fav,
      this.aging,
      this.grapeVar,
      this.note,
      this.addnote,
      this.webAdress,
      this.wineColor});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List _json = [];
  String serialnumber;
  String _jsonString;
  bool _favourite = false;
  File _filePath;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  bool _fileExists = false;

  void _readJson() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var _serial = localStorage.getString(widget.serial);
    setState(() {
      serialnumber = _serial;
    });
    print("${_serial}adssdasdasda");
    // Initialize _filePath
    _filePath = await _localFile;

    // 0. Check whether the _file exists
    _fileExists = await _filePath.exists();
    print('0. File exists? $_fileExists');

    // If the _file exists->read it: update initialized _json by what's in the _file
    if (_fileExists) {
      try {
        //1. Read _jsonString<String> from the _file.
        _jsonString = await _filePath.readAsString();
        print('1.(_readJson) _jsonString: $_jsonString');

        //2. Update initialized _json by converting _jsonString<String>->_json<Map>
        _json = jsonDecode(_jsonString);
        print('2.(_readJson) _json: $_json \n - \n');
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    }
  }

  void _writeJson() async {
    // Initialize the local _filePath
    //final _filePath = await _localFile;

    //1. Create _newJson<Map> from input<TextField>
    List _newJson = [
      {
        "Color": widget.wineColor,
        'Potential Ageing Years': widget.aging,
        "Wine Type": widget.wineType,
        "Grape Variety": widget.grapeVar,
        "Village": widget.village,
        "Wine Region": widget.wineRegion,
        "Country": widget.country,
        "Producer": widget.producer,
        "Suggested Bottle": widget.suggestedBottle,
        "Web Address": widget.webAdress,
        "Notes": widget.note,
        "Additional Notes": widget.addnote,
        "Serial": widget.serial,
      }
    ];
    print('1.(_writeJson) _newJson: $_newJson');

    //2. Update _json by adding _newJson<Map> -> _json<Map>
    _json.addAll(_newJson);
    print('2.(_writeJson) _json(updated): $_json');

    //3. Convert _json ->_jsonString
    _jsonString = jsonEncode(_json);
    print('3.(_writeJson) _jsonString: $_jsonString\n - \n');

    //4. Write _jsonString to the _filePath
    _filePath.writeAsString(_jsonString);
  }

  @override
  void initState() {
    _readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight / 1.2),
        child: widget.wineColor == "redcount" || widget.wineColor == "redgrap"
            ? Image.asset(
                'assets/files/redwine.jpeg',
                fit: BoxFit.fitWidth,
              )
            : Image.asset(
                'assets/files/whitewine.jpeg',
                fit: BoxFit.fitWidth,
              ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 30,
              top: 40,
              child: widget.fav
                  ? SizedBox()
                  : _favourite
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 40,
                          ),
                        )
                      : serialnumber == widget.serial
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 40,
                              ),
                            )
                          : IconButton(
                              onPressed: () async {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();

                                setState(() {
                                  _favourite = true;
                                });

                                localStorage.setString(
                                    widget.serial, widget.serial);

                                _writeJson();
                                final file = await _localFile;
                                _fileExists = await file.exists();
                                Fluttertoast.showToast(
                                    msg: "Aggiunto ai preferiti");
                              },
                              icon: Icon(
                            Icons.favorite_outline,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Producer: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "sans"),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.producer}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: "sans"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Type of Wine: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "sans"),
                      ),
                      Text(
                        "${widget.wineType != null ? widget.wineType : ""}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "sans"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Grape Variety: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans",
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.grapeVar != null ? widget.grapeVar : ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "sans",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Country: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "sans",
                        ),
                      ),
                      Text(
                        "${widget.country != null ? widget.country : ""}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: "sans",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Wine Region: ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "sans",
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "${widget.wineRegion != null ? widget.wineRegion : ""}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: "sans",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Village: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans",
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.village != null ? widget.village : ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontFamily: "sans",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recommended Bottle: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans",
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.suggestedBottle != null ? widget.suggestedBottle : ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "sans",
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Potential Ageing Years : ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${widget.aging != null ? widget.aging : ""}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "sans",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Note: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.note != null ? widget.note : ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "sans",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Web Address: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "sans",
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Get.to(HomePage(
                              url: widget.webAdress,
                            ));
                          },
                          child: Text(
                            "${widget.webAdress != null ? widget.webAdress : ""}",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "sans",
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 15),
                  child: Row(
                    children: [
                      Text(
                        "Additional Note: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.addnote != null ? widget.addnote : ""}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "sans",
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
