import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'Detail Screen.dart';
import 'model.dart';

const String kFileName = 'winefav.json';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  File _filePath;

  // First initialization of _json (if there is no json in the file)
  List _json = [];
  String _jsonString;
  bool _fileExists = false;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$kFileName');
  }

  List<Red> reddata;
  bool loading = false;
  void _readJson() async {
    setState(() {
      loading = true;
    });
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
        final fav = jsonDecode(_jsonString);

        print('2.(_readJson) _json: $_json \n - \n');

        List<Red> redlists;

        redlists = fav.map<Red>((json) => Red.fromJson(json)).toList();

        setState(() {
          reddata = redlists;
          loading = false;
        });
      } catch (e) {
        // Print exception errors
        print('Tried reading _file error: $e');
        // If encountering an error, return null
      }
    } else {
      Fluttertoast.showToast(msg: "Nessun elemento nei preferiti");
    }
  }

  @override
  void initState() {
    _readJson();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Stack(
            children: [
              Image(
                image: AssetImage('assets/files/wine.jpg'),
                fit: BoxFit.cover,
                height: 400,
                width: 700,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 25.0),
              //   child: Center(
              //     child: Text(
              //       "PREFERITA",
              //       style: TextStyle(
              //           fontSize: 28,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //           fontFamily: "sans"),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: reddata.length,
                        //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(DetailScreen(
                                fav: true,
                                webAdress: reddata[index].webAddress,
                                wineColor: reddata[index].color,
                                wineRegion: reddata[index].wineRegion,
                                wineType: reddata[index].wineType,
                                country: reddata[index].country,
                                village: reddata[index].village,
                                aging: reddata[index].agingInYears,
                                note: reddata[index].notes,
                                grapeVar: reddata[index].grapeVarieties,
                                producer: reddata[index].producer,
                                suggestedBottle: reddata[index].suggestedBottle,
                                serial: reddata[index].serial,
                              ));
                            },
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // Text(
                                              //   "${reddata[index].color} Wine",
                                              //   style: TextStyle(
                                              //     fontSize: 16,
                                              //   ),
                                              // ),
                                              Text(
                                                reddata[index].producer,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                reddata[index].country,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, right: 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
