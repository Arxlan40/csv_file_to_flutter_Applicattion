import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spreadsheet/Producermodel.dart';
import 'package:get/get.dart';

import 'ProducerDetails.dart';
class ProducerList extends StatefulWidget {
  @override
  _ProducerListState createState() => _ProducerListState();
}

class _ProducerListState extends State<ProducerList> {
  bool loading = false;
  TextEditingController textcontroller = new TextEditingController();

  Future<String> _loadFromAssetwhite() async {
    return await rootBundle.loadString("assets/files/producer.json");
  }

  Future getdata() async {
    // try {
    setState(() {
      loading = true;
    });
    List<ProducerModel> prodlists;

    String jsonString = await _loadFromAssetwhite();
    print(jsonString);
    final whitejsonResponse = jsonDecode(jsonString);

    prodlists = whitejsonResponse["Sheet1"]
        .map<ProducerModel>((json) => ProducerModel.fromJson(json))
        .toList();

    setState(() {
      prouducers = prodlists;
      loading = false;
    });

    // } catch (e) {
    // }
  }

  List<ProducerModel> _searchResult = [];

  List<ProducerModel> prouducers;

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

         prouducers.forEach((userDetail) {
            if (userDetail.producer.toLowerCase().contains(text.toLowerCase()) )
              _searchResult.add(userDetail);
          });
         setState(() {});
  }

  @override
  void initState() {
    _loadFromAssetwhite();
    getdata();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Stack(
              children: [
                Image(
                  image: AssetImage('assets/files/pic.jpg'),
                  fit: BoxFit.cover,
                  height: 400,
                  width: 700,
                ),
                Center(
                  child: Text(
                    "LE AZIENDE",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "sans"),
                  ),
                ),
              ],
            ),
          )),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          TextField(
            controller: textcontroller,
            onChanged: onSearchTextChanged,
            decoration: new InputDecoration(
                prefixIcon: new Icon(Icons.search,
                    color: Colors.grey),
                hintText: "Search...",
                hintStyle: new TextStyle(
                    color: Colors.grey)),
          ),
          _searchResult.length != 0 ||
              textcontroller.text
                  .trim()
                  .toLowerCase()
                  .isNotEmpty
              ? ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: _searchResult.length,
              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (BuildContext context,
                  index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(ProducerDetail(
                      fav: false,
                      webAdress:
                      _searchResult[index]
                          .webAddress,
                      wineRegion:
                      _searchResult[index]
                          .wineRegion,
                      country:
                      _searchResult[index]
                          .country,
                      village:
                      _searchResult[index]
                          .village,
                      producer:
                      _searchResult[index]
                          .producer,
                       ));
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  top: 10.0,
                                  left: 10),
                              child: Container(
                                padding: EdgeInsets
                                    .only(
                                    left:
                                    5),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: <
                                      Widget>[
                                    Text(
                                      _searchResult[index].producer,
                                      style:
                                      TextStyle(
                                        fontSize:
                                        16,
                                      ),
                                    ),
                                   ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                top: 20.0,
                                right: 10),
                            child: Icon(
                              Icons
                                  .arrow_forward_ios,
                              color:
                              Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              })
              : ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: prouducers.length,
              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
              scrollDirection: Axis.vertical,
              itemBuilder:
                  (BuildContext context,
                  index) {
                return InkWell(
                  onTap: () {
                    Get.to(ProducerDetail(
                      fav: false,
                      webAdress: prouducers[index]
                          .webAddress,
                      wineRegion: prouducers[index]
                          .wineRegion,
                      country: prouducers[index]
                          .country,
                      producer: prouducers[index]
                          .producer,
                      village: prouducers[index].village,
                       ));
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                  top: 10.0,
                                  left: 10),
                              child: Container(
                                padding: EdgeInsets
                                    .only(
                                    left:
                                    5),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: <
                                      Widget>[
                                    Text(prouducers[index]
                                        .producer,
                                      style:
                                      TextStyle(
                                        fontSize:
                                        16,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets
                                .only(
                                top: 20.0,
                                right: 10),
                            child: Icon(
                              Icons
                                  .arrow_forward_ios,
                              color:
                              Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
