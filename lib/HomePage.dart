import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spreadsheet/model.dart';
import 'package:spreadsheet/suggestedbottle.dart';
import 'package:tabbar/tabbar.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  String type;
  String title;
  String country;
  MyHomePage({this.type, this.title, this.country});

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = PageController();
  TextEditingController textcontroller = new TextEditingController();
  TextEditingController textcontrollerwhite = new TextEditingController();

  List<Red> reddata;
  List<Red> whitedata;

  bool loading = false;
  void _filter(List<Red> item) {
    final ids = reddata.map((e) => e.wineType).toSet();
    final idsw = whitedata.map((e) => e.wineType).toSet();

    setState(() {
      widget.type == "redcount"
          ? reddata =
              item.where((value) => value.country == widget.country).toList()
          : widget.type == "whitecount"
              ? whitedata = item
                  .where((value) => value.country == widget.country)
                  .toList()
              : SizedBox();
      widget.type == "redgrap" || widget.type == "redcount"
          ? reddata.retainWhere((x) => ids.remove(x.wineType))
          : widget.type == "whitegrap" || widget.type == "whitecount"
              ? whitedata.retainWhere((x) => idsw.remove(x.wineType))
              : SizedBox();
    });
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    widget.type == "redgrap"
        ? reddata.forEach((userDetail) {
            if (userDetail.country.toLowerCase().contains(text.toLowerCase()) ||
                userDetail.grapeVarieties
                    .toLowerCase()
                    .contains(text.toLowerCase()))
              _searchResult.add(userDetail);
          })
        : reddata.forEach((userDetail) {
            if (userDetail.country.toLowerCase().contains(text.toLowerCase()) ||
                userDetail.wineType.toLowerCase().contains(text.toLowerCase()))
              _searchResult.add(userDetail);
          });
    setState(() {});
  }

  onSearchTextChangedwhite(String text) async {
    _searchResultwhite.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    widget.type == "whitegrap"
        ? whitedata.forEach((userDetail) {
            if (userDetail.country.toLowerCase().contains(text.toLowerCase()) ||
                userDetail.grapeVarieties
                    .toLowerCase()
                    .contains(text.toLowerCase()))
              _searchResultwhite.add(userDetail);
          })
        : whitedata.forEach((userDetail) {
            if (userDetail.country.toLowerCase().contains(text.toLowerCase()) ||
                userDetail.wineType.toLowerCase().contains(text.toLowerCase()))
              _searchResultwhite.add(userDetail);
          });
    setState(() {});
  }

  Future<String> _loadFromAssetwhite() async {
    return await rootBundle.loadString("assets/files/white.json");
  }

  Future<String> _loadFromAssetred() async {
    return await rootBundle.loadString("assets/files/data2.json");
  }

  Future getdata() async {
    try {
      setState(() {
        loading = true;
      });
      List<Red> redlists;
      List<Red> whitelists;

      String jsonString = await _loadFromAssetred();
      String whitejsonString = await _loadFromAssetwhite();
      print(jsonString);
      final jsonResponse = jsonDecode(jsonString);
      final whitejsonResponse = jsonDecode(whitejsonString);

      print(jsonResponse["Sheet1"]);
      redlists = jsonResponse["Sheet1"]
          .map<Red>((json) => Red.fromJson(json))
          .toList();
      whitelists = whitejsonResponse["Sheet1"]
          .map<Red>((json) => Red.fromJson(json))
          .toList();

      setState(() {
        reddata = redlists;
        whitedata = whitelists;
        loading = false;
      });
      widget.type == "redgrap" || widget.type == "redcount"
          ? _filter(reddata)
          : _filter(whitedata);
    } catch (e) {}
  }

  List<Red> _searchResult = [];
  List<Red> _searchResultwhite = [];

  @override
  void initState() {
    _loadFromAssetwhite();
    _loadFromAssetred();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: widget.type == "LE AZIENDE"
            ? PreferredSize(
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
                      Center(
                        child: Text(
                          "${widget.type}",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: "sans"),
                        ),
                      ),
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(kToolbarHeight),
                    child: TabbarHeader(
                      controller: controller,
                      backgroundColor: Colors.transparent,
                      tabs: [
                        Tab(
                          child: Text(
                            "Red Wine",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                            child: Text("White Wine",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                  ),
                ))
            : PreferredSize(
                preferredSize: Size.fromHeight(300),
                child: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  elevation: 1,
                  backgroundColor: Colors.white,
                  flexibleSpace: Stack(
                    children: [
                      Center(
                        child: Image(
                          image: widget.type == "redgrap"
                              ? AssetImage('assets/files/red.png')
                              : widget.type == "redcount"
                                  ? AssetImage("assets/files/red.png")
                                  : AssetImage("assets/files/white.png"),
                          // fit: BoxFit.fill,
                          // height: 600,
                          // width: 700,
                        ),
                      ),
                    ],
                  ),
                )),
        backgroundColor: Colors.white,
        body: loading
            ? Center(child: CircularProgressIndicator())
            : widget.type == "redgrap"
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: reddata.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(Suggestedbottle(
                            country: widget.country,
                            winetype: reddata[index].wineType,
                            type: widget.type,
                            title: widget.title,
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
                                          Text(
                                            reddata[index].wineType,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          // Text(
                                          //   reddata[index].village,
                                          //   style: TextStyle(
                                          //       fontSize: 14,
                                          //       color: Colors.grey),
                                          // ),
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
                : widget.type == "whitegrap"
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: whitedata.length,
                        //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(Suggestedbottle(
                                country: widget.country,
                                winetype: whitedata[index].wineType,
                                type: widget.type,
                                title: widget.title,
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
                                              Text(
                                                whitedata[index].wineType,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
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
                    : widget.type == "redcount"
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: reddata.length,
                            //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(Suggestedbottle(
                                    country: widget.country,
                                    winetype: reddata[index].wineType,
                                    type: widget.type,
                                    title: widget.title,
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  widget.type == "I VINI"
                                                      ? Text(
                                                          "Wine Producer: ${reddata[index].producer}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey))
                                                      : SizedBox(),
                                                  Text(
                                                    widget.type == "LE AZIENDE"
                                                        ? reddata[index]
                                                            .wineRegion
                                                        : widget.type ==
                                                                "I VINI"
                                                            ? reddata[index]
                                                                .country
                                                            : reddata[index]
                                                                .wineType,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
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
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: whitedata.length,
                            //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(Suggestedbottle(
                                    type: widget.type,
                                    country: widget.country,
                                    title: widget.title,
                                    winetype: whitedata[index].wineType,
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  widget.type == "I VINI"
                                                      ? Text(
                                                          "Wine Producer: ${whitedata[index].producer}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.grey))
                                                      : SizedBox(),
                                                  Text(
                                                    widget.type == "LE AZIENDE"
                                                        ? whitedata[index]
                                                            .wineRegion
                                                        : widget.type ==
                                                                "I VINI"
                                                            ? whitedata[index]
                                                                .country
                                                            : whitedata[index]
                                                                .wineType,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),
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
                            }));
  }
}
