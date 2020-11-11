import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'localstorage.dart';

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
  bool fav;

  DetailScreen(
      {this.producer,
      this.country,
      this.suggestedBottle,
      this.wineRegion,
      this.wineType,
      this.village,
      this.fav,
      this.aging,
      this.grapeVar,
      this.note,
      this.webAdress,
      this.wineColor});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List _json = [];

  String _jsonString;

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
        'Aging in Years': widget.aging,
        "Wine Type": widget.wineType,
        "Grape Varieties": widget.grapeVar,
        "Village": widget.village,
        "Wine Region": widget.wineRegion,
        "Country": widget.country,
        "Producer": widget.producer,
        "Suggested Bottle": widget.suggestedBottle,
        "web address": widget.webAdress
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
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Color(0xFF44281d),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  "Wine Created By ${widget.country}",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Text(
                "${widget.wineColor} Wine",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              )
            ],
          ),
          title: widget.fav ? SizedBox(): ListTile(
              trailing: IconButton(
            onPressed: () async {
              _writeJson();
              final file = await _localFile;
              _fileExists = await file.exists();
              Fluttertoast.showToast(msg: "Aggiunto ai preferiti");
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("Wine Color"),
              subtitle: Text(
                "${widget.wineColor}",
              ),
            ),
            ListTile(
              title: Text("Wine Type"),
              subtitle: Text(
                "${widget.wineType}",
              ),
            ),
            ListTile(
              title: Text("Country"),
              subtitle: Text(
                "${widget.country}",
              ),
            ),
            ListTile(
              title: Text("Wine Region"),
              subtitle: Text(
                "${widget.wineRegion}",
              ),
            ),
            ListTile(
              title: Text("Village"),
              subtitle: Text(
                "${widget.village}",
              ),
            ),
            ListTile(
              title: Text("Grape Varieties"),
              subtitle: Text(
                "${widget.grapeVar}",
              ),
            ),
            ListTile(
              title: Text("Producer"),
              subtitle: Text(
                "${widget.producer}",
              ),
            ),
            ListTile(
              title: Text("Aging in Years"),
              subtitle: Text(
                "${widget.aging}",
              ),
            ),
            ListTile(
              title: Text("Suggested Bottle"),
              subtitle: Text(
                "${widget.suggestedBottle}",
              ),
            ),
            ListTile(
              title: Text("Web Address"),
              subtitle: Text(
                "${widget.webAdress != null ? widget.webAdress : "Not Found"}",
              ),
            ),
            ListTile(
              title: Text("Note"),
              subtitle: Text(
                "${widget.note != null ? widget.note : "Not Found"}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
