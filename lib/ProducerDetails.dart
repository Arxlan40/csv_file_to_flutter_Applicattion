import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadsheet/Webview.dart';

const String kFileName = 'winefav.json';

class ProducerDetail extends StatefulWidget {
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

  ProducerDetail(
      {this.producer,
      this.country,
      this.serial,
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
  _ProducerDetailState createState() => _ProducerDetailState();
}

class _ProducerDetailState extends State<ProducerDetail> {
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
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        elevation: 5,
  
        centerTitle: true,
        title: Text(
          "${widget.producer}",
          style:
              TextStyle(fontSize: 18, fontFamily: "sans", color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 30,
              top: 40,
              child: _favourite
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 40,
                      ),
                    )
                  : serialnumber == widget.serial
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
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
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
            ),
            Column(
              children: [
                // ListTile(
                //   title: Text("Wine Color"),
                //   subtitle: Text(
                //     "${widget.wineColor}",
                //   ),
                // ),
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
                      Text(
                        "${widget.producer}",
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
                        "Country: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: "sans",
                        ),
                      ),
                      Text(
                        "${widget.country}",
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
                        "Wine Region: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "sans",
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${widget.wineRegion}",
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
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "${widget.village}",
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
                          fontFamily: "sans",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(HomePage(
                            url: widget.webAdress,
                          ));
                        },
                        child: Text(
                          "${widget.webAdress}",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: "sans",
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
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
