import 'dart:convert';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_table/json_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spreadsheet/Detail%20Screen.dart';
import 'package:spreadsheet/model.dart';
import 'package:tabbar/tabbar.dart';
import 'dart:io';

class Suggestedbottle extends StatefulWidget {
  String type;
  String title;
  String winetype;
  String country;

  Suggestedbottle({this.type, this.title, this.winetype, this.country});

  _SuggestedbottleState createState() => _SuggestedbottleState();
}

class _SuggestedbottleState extends State<Suggestedbottle> {
  final controller = PageController();
  TextEditingController textcontroller = new TextEditingController();
  TextEditingController textcontrollerwhite = new TextEditingController();

  List<Red> reddata;
  List<Red> whitedata;

  bool loading = false;
  void _filter(List<Red> item) {
    setState(() {
      // widget.type == "redgrap" || widget.type =="redcount" ?
      // reddata =
      //     item.where((value) => value.country == widget.country).toList(): whitedata =
      //     item.where((value) => value.country == widget.country).toList();
      print(widget.type);
      widget.type == "redcount"
          ? reddata = item
              .where((value) =>
                  value.wineType == widget.winetype &&
                  value.country == widget.country)
              .toList()
          : widget.type == "redgrap"
              ? reddata = item
                  .where((value) => value.wineType == widget.winetype)
                  .toList()
              : widget.type == "whitecount"
                  ? whitedata = item
                      .where((value) =>
                          value.wineType == widget.winetype &&
                          value.country == widget.country)
                      .toList()
                  : whitedata = item
                      .where((value) => value.wineType == widget.winetype)
                      .toList();
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
                userDetail.producer.toLowerCase().contains(text.toLowerCase()))
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
                userDetail.producer.toLowerCase().contains(text.toLowerCase()))
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
    // try {
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
    redlists =
        jsonResponse["Sheet1"].map<Red>((json) => Red.fromJson(json)).toList();
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

    // } catch (e) {
    // }
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
                                  fontSize: 16, fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
              ))
          : PreferredSize(
              preferredSize: Size.fromHeight(250),
              child: AppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: Stack(
                  children: [
                    Image(
                      image: widget.type == "redgrap"
                          ? AssetImage('assets/files/red.jpeg')
                          : widget.type == "redcount"
                              ? AssetImage("assets/files/red.jpeg")
                              : AssetImage("assets/files/white.jpeg"),
                      fit: BoxFit.fill,
                      height: 600,
                      width: 700,
                    ),
                    // Center(
                    //   child: Text(
                    //     "LE AZIENDE",
                    //     style: TextStyle(
                    //         fontSize: 28,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //         fontFamily: "sans"),
                    //   ),
                    // ),
                  ],
                ),
              )),
      backgroundColor: Colors.white,
      body: loading
          ? Center(child: CircularProgressIndicator())
          : widget.type == "redgrap"
              ? Scaffold(
                  body: ListView(
                    children: [
                      // TextField(
                      //   controller: textcontroller,
                      //   onChanged: onSearchTextChanged,
                      //   decoration: new InputDecoration(
                      //       prefixIcon:
                      //       new Icon(Icons.search, color: Colors.grey),
                      //       hintText: "Search...",
                      //       hintStyle: new TextStyle(color: Colors.grey)),
                      // ),
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
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(DetailScreen(
                                      fav: false,
                                      addnote: _searchResult[index].addnote,
                                      webAdress:
                                          _searchResult[index].webAddress,
                                      wineColor: _searchResult[index].color,
                                      wineRegion:
                                          _searchResult[index].wineRegion,
                                      wineType: _searchResult[index].wineType,
                                      country: _searchResult[index].country,
                                      village: _searchResult[index].village,
                                      aging: _searchResult[index].agingInYears,
                                      note: _searchResult[index].notes,
                                      grapeVar:
                                          _searchResult[index].grapeVarieties,
                                      producer: _searchResult[index].producer,
                                      suggestedBottle:
                                          _searchResult[index].suggestedBottle,
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
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      _searchResult[index]
                                                          .producer,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   _searchResult[index]
                                                    //       .village,
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
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: reddata.length,
                              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, index) {
                                return InkWell(
                                  onTap: () {
                                    print("sssssss${widget.type}");
                                    Get.to(DetailScreen(
                                      fav: false,
                                      serial: reddata[index].serial,
                                      addnote: reddata[index].addnote,
                                      webAdress: reddata[index].webAddress,
                                      wineColor: widget.type,
                                      wineRegion: reddata[index].wineRegion,
                                      wineType: reddata[index].wineType,
                                      country: reddata[index].country,
                                      village: reddata[index].village,
                                      aging: reddata[index].agingInYears,
                                      note: reddata[index].notes,
                                      grapeVar: reddata[index].grapeVarieties,
                                      producer: reddata[index].producer,
                                      suggestedBottle:
                                          reddata[index].suggestedBottle,
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
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      reddata[index].producer,
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
                              }),
                    ],
                  ),
                )
              : widget.type == "whitegrap"
                  ? Scaffold(
                      body: ListView(
                        children: [
                          // TextField(
                          //   controller: textcontrollerwhite,
                          //   onChanged: onSearchTextChangedwhite,
                          //   decoration: new InputDecoration(
                          //       prefixIcon:
                          //       new Icon(Icons.search, color: Colors.grey),
                          //       hintText: "Search...",
                          //       hintStyle: new TextStyle(color: Colors.grey)),
                          // ),
                          _searchResultwhite.length != 0 ||
                                  textcontrollerwhite.text
                                      .trim()
                                      .toLowerCase()
                                      .isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: _searchResultwhite.length,
                                  //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(DetailScreen(
                                          fav: false,
                                          addnote:
                                              _searchResultwhite[index].addnote,
                                          webAdress: _searchResultwhite[index]
                                              .webAddress,
                                          wineColor:
                                              _searchResultwhite[index].color,
                                          wineRegion: _searchResultwhite[index]
                                              .wineRegion,
                                          wineType: _searchResultwhite[index]
                                              .wineType,
                                          country:
                                              _searchResultwhite[index].country,
                                          village:
                                              _searchResultwhite[index].village,
                                          aging: _searchResultwhite[index]
                                              .agingInYears,
                                          note: _searchResultwhite[index].notes,
                                          grapeVar: _searchResultwhite[index]
                                              .grapeVarieties,
                                          producer: _searchResultwhite[index]
                                              .producer,
                                          suggestedBottle:
                                              _searchResultwhite[index]
                                                  .suggestedBottle,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 10),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          _searchResultwhite[
                                                                  index]
                                                              .producer,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   _searchResultwhite[
                                                        //   index]
                                                        //       .village,
                                                        //   style: TextStyle(
                                                        //       fontSize: 14,
                                                        //       color:
                                                        //       Colors.grey),
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
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: whitedata.length,
                                  //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, index) {
                                    return InkWell(
                                      onTap: () {
                                        print("sssssss${widget.type}");

                                        Get.to(DetailScreen(
                                          fav: false,
                                          addnote: whitedata[index].addnote,
                                          webAdress:
                                              whitedata[index].webAddress,
                                          wineColor: widget.type,
                                          serial: whitedata[index].serial,
                                          wineRegion:
                                              whitedata[index].wineRegion,
                                          wineType: whitedata[index].wineType,
                                          country: whitedata[index].country,
                                          village: whitedata[index].village,
                                          aging: whitedata[index].agingInYears,
                                          note: whitedata[index].notes,
                                          grapeVar:
                                              whitedata[index].grapeVarieties,
                                          producer: whitedata[index].producer,
                                          suggestedBottle:
                                              whitedata[index].suggestedBottle,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 10),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          whitedata[index]
                                                              .producer,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        // Text(
                                                        //   whitedata[index]
                                                        //       .village,
                                                        //   style: TextStyle(
                                                        //       fontSize: 14,
                                                        //       color:
                                                        //       Colors.grey),
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
                                  }),
                        ],
                      ),
                    )
                  : widget.type == "redcount"
                      ? Scaffold(
                          body: ListView(
                            children: [
                              // TextField(
                              //   controller: textcontroller,
                              //   onChanged: onSearchTextChanged,
                              //   decoration: new InputDecoration(
                              //       prefixIcon: new Icon(Icons.search,
                              //           color: Colors.grey),
                              //       hintText: "Search...",
                              //       hintStyle:
                              //       new TextStyle(color: Colors.grey)),
                              // ),
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
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(DetailScreen(
                                              fav: false,
                                              addnote:
                                                  _searchResult[index].addnote,
                                              webAdress: _searchResult[index]
                                                  .webAddress,
                                              wineColor:
                                                  _searchResult[index].color,
                                              wineRegion: _searchResult[index]
                                                  .wineRegion,
                                              wineType:
                                                  _searchResult[index].wineType,
                                              country:
                                                  _searchResult[index].country,
                                              village:
                                                  _searchResult[index].village,
                                              aging: _searchResult[index]
                                                  .agingInYears,
                                              note: _searchResult[index].notes,
                                              grapeVar: _searchResult[index]
                                                  .grapeVarieties,
                                              producer:
                                                  _searchResult[index].producer,
                                              suggestedBottle:
                                                  _searchResult[index]
                                                      .suggestedBottle,
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // Text(
                                                            //   widget.type ==
                                                            //           "LE AZIENDE"
                                                            //       ? _searchResult[
                                                            //               index]
                                                            //           .producer
                                                            //       : widget.type ==
                                                            //               "I VINI"
                                                            //           ? _searchResult[
                                                            //                   index]
                                                            //               .color
                                                            //           : _searchResult[
                                                            //                   index]
                                                            //               .wineType,
                                                            //   style: TextStyle(
                                                            //     fontSize: 16,
                                                            //   ),
                                                            // ),
                                                            widget.type ==
                                                                    "I VINI"
                                                                ? Text(
                                                                    "Wine Producer: ${_searchResult[index].producer}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .grey))
                                                                : SizedBox(),
                                                            Text(
                                                              widget.type ==
                                                                      "LE AZIENDE"
                                                                  ? _searchResult[
                                                                          index]
                                                                      .wineRegion
                                                                  : widget.type ==
                                                                          "I VINI"
                                                                      ? _searchResult[
                                                                              index]
                                                                          .country
                                                                      : _searchResult[
                                                                              index]
                                                                          .producer,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20.0,
                                                            right: 10),
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
                                      itemCount: reddata.length,
                                      //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(DetailScreen(
                                              fav: false,
                                              addnote: reddata[index].addnote,
                                              webAdress:
                                                  reddata[index].webAddress,
                                              wineColor: widget.type,
                                              wineRegion:
                                                  reddata[index].wineRegion,
                                              wineType: reddata[index].wineType,
                                              country: reddata[index].country,
                                              village: reddata[index].village,
                                              aging:
                                                  reddata[index].agingInYears,
                                              note: reddata[index].notes,
                                              grapeVar:
                                                  reddata[index].grapeVarieties,
                                              producer: reddata[index].producer,
                                              serial: reddata[index].serial,
                                              suggestedBottle: reddata[index]
                                                  .suggestedBottle,
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 10),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            // Text(
                                                            //   widget.type ==
                                                            //           "LE AZIENDE"
                                                            //       ? reddata[index]
                                                            //           .producer
                                                            //       : widget.type ==
                                                            //               "I VINI"
                                                            //           ? reddata[
                                                            //                   index]
                                                            //               .color
                                                            //           : reddata[
                                                            //                   index]
                                                            //               .country,
                                                            //   style: TextStyle(
                                                            //     fontSize: 16,
                                                            //   ),
                                                            // ),

                                                            Text(
                                                              reddata[index]
                                                                  .producer,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20.0,
                                                            right: 10),
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
                                      }),
                            ],
                          ),
                        )
                      : widget.type == "whitecount"
                          ? Scaffold(
                              body: ListView(
                                children: [
                                  // TextField(
                                  //   controller: textcontrollerwhite,
                                  //   onChanged: onSearchTextChangedwhite,
                                  //   decoration: new InputDecoration(
                                  //       prefixIcon: new Icon(Icons.search,
                                  //           color: Colors.grey),
                                  //       hintText: "Search...",
                                  //       hintStyle:
                                  //       new TextStyle(color: Colors.grey)),
                                  // ),
                                  _searchResultwhite.length != 0 ||
                                          textcontrollerwhite.text
                                              .trim()
                                              .toLowerCase()
                                              .isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: _searchResultwhite.length,
                                          //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                          scrollDirection: Axis.vertical,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(DetailScreen(
                                                  fav: false,
                                                  addnote:
                                                      _searchResultwhite[index]
                                                          .addnote,
                                                  webAdress:
                                                      _searchResultwhite[index]
                                                          .webAddress,
                                                  wineColor:
                                                      _searchResultwhite[index]
                                                          .color,
                                                  wineRegion:
                                                      _searchResultwhite[index]
                                                          .wineRegion,
                                                  wineType:
                                                      _searchResultwhite[index]
                                                          .wineType,
                                                  country:
                                                      _searchResultwhite[index]
                                                          .country,
                                                  village:
                                                      _searchResultwhite[index]
                                                          .village,
                                                  aging:
                                                      _searchResultwhite[index]
                                                          .agingInYears,
                                                  note:
                                                      _searchResultwhite[index]
                                                          .notes,
                                                  grapeVar:
                                                      _searchResultwhite[index]
                                                          .grapeVarieties,
                                                  producer:
                                                      _searchResultwhite[index]
                                                          .producer,
                                                  suggestedBottle:
                                                      _searchResultwhite[index]
                                                          .suggestedBottle,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                // Text(
                                                                //   widget.type ==
                                                                //           "LE AZIENDE"
                                                                //       ? _searchResultwhite[
                                                                //               index]
                                                                //           .producer
                                                                //       : widget.type ==
                                                                //               "I VINI"
                                                                //           ? _searchResultwhite[index]
                                                                //               .color
                                                                //           : _searchResultwhite[index]
                                                                //               .country,
                                                                //   style:
                                                                //       TextStyle(
                                                                //     fontSize:
                                                                //         16,
                                                                //   ),
                                                                // ),
                                                                widget.type ==
                                                                        "I VINI"
                                                                    ? Text(
                                                                        "Wine Producer: ${_searchResultwhite[index].producer}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.grey))
                                                                    : SizedBox(),
                                                                Text(
                                                                  widget.type ==
                                                                          "LE AZIENDE"
                                                                      ? _searchResultwhite[
                                                                              index]
                                                                          .wineRegion
                                                                      : widget.type ==
                                                                              "I VINI"
                                                                          ? _searchResultwhite[index]
                                                                              .country
                                                                          : _searchResultwhite[index]
                                                                              .producer,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
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
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Get.to(DetailScreen(
                                                  fav: false,
                                                  webAdress: whitedata[index]
                                                      .webAddress,
                                                  wineColor: widget.type,
                                                  wineRegion: whitedata[index]
                                                      .wineRegion,
                                                  addnote:
                                                      whitedata[index].addnote,
                                                  wineType:
                                                      whitedata[index].wineType,
                                                  serial:
                                                      whitedata[index].serial,
                                                  country:
                                                      whitedata[index].country,
                                                  village:
                                                      whitedata[index].village,
                                                  aging: whitedata[index]
                                                      .agingInYears,
                                                  note: whitedata[index].notes,
                                                  grapeVar: whitedata[index]
                                                      .grapeVarieties,
                                                  producer:
                                                      whitedata[index].producer,
                                                  suggestedBottle:
                                                      whitedata[index]
                                                          .suggestedBottle,
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
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 5),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                // Text(
                                                                //   widget.type ==
                                                                //           "LE AZIENDE"
                                                                //       ? whitedata[
                                                                //               index]
                                                                //           .producer
                                                                //       : widget.type ==
                                                                //               "I VINI"
                                                                //           ? whitedata[index]
                                                                //               .color
                                                                //           : whitedata[index]
                                                                //               .country,
                                                                //   style:
                                                                //       TextStyle(
                                                                //     fontSize:
                                                                //         16,
                                                                //   ),
                                                                // ),
                                                                widget.type ==
                                                                        "I VINI"
                                                                    ? Text(
                                                                        "Wine Producer: ${whitedata[index].producer}",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Colors.grey))
                                                                    : SizedBox(),
                                                                Text(
                                                                  widget.type ==
                                                                          "LE AZIENDE"
                                                                      ? whitedata[
                                                                              index]
                                                                          .wineRegion
                                                                      : widget.type ==
                                                                              "I VINI"
                                                                          ? whitedata[index]
                                                                              .country
                                                                          : whitedata[index]
                                                                              .producer,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black),
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
                                                          color: Colors.grey,
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
                            )
                          : TabbarContent(
                              physics: ScrollPhysics(),
                              controller: controller,
                              children: <Widget>[
                                Scaffold(
                                  body: ListView(
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
                                                    Get.to(DetailScreen(
                                                      fav: false,
                                                      addnote:
                                                          _searchResult[index]
                                                              .addnote,
                                                      webAdress:
                                                          _searchResult[index]
                                                              .webAddress,
                                                      wineColor:
                                                          _searchResult[index]
                                                              .color,
                                                      wineRegion:
                                                          _searchResult[index]
                                                              .wineRegion,
                                                      wineType:
                                                          _searchResult[index]
                                                              .wineType,
                                                      country:
                                                          _searchResult[index]
                                                              .country,
                                                      village:
                                                          _searchResult[index]
                                                              .village,
                                                      aging:
                                                          _searchResult[index]
                                                              .agingInYears,
                                                      note: _searchResult[index]
                                                          .notes,
                                                      grapeVar:
                                                          _searchResult[index]
                                                              .grapeVarieties,
                                                      producer:
                                                          _searchResult[index]
                                                              .producer,
                                                      suggestedBottle:
                                                          _searchResult[index]
                                                              .suggestedBottle,
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
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? _searchResult[index]
                                                                              .producer
                                                                          : widget.type == "I VINI"
                                                                              ? _searchResult[index].color
                                                                              : _searchResult[index].country,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    widget.type ==
                                                                            "I VINI"
                                                                        ? Text(
                                                                            "Wine Producer: ${_searchResult[index].producer}",
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.grey))
                                                                        : SizedBox(),
                                                                    Text(
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? _searchResult[index]
                                                                              .wineRegion
                                                                          : widget.type == "I VINI"
                                                                              ? _searchResult[index].country
                                                                              : _searchResult[index].producer,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
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
                                              itemCount: reddata.length,
                                              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(DetailScreen(
                                                      fav: false,
                                                      addnote: reddata[index]
                                                          .addnote,
                                                      webAdress: reddata[index]
                                                          .webAddress,
                                                      wineColor:
                                                          reddata[index].color,
                                                      wineRegion: reddata[index]
                                                          .wineRegion,
                                                      wineType: reddata[index]
                                                          .wineType,
                                                      serial:
                                                          reddata[index].serial,
                                                      country: reddata[index]
                                                          .country,
                                                      village: reddata[index]
                                                          .village,
                                                      aging: reddata[index]
                                                          .agingInYears,
                                                      note:
                                                          reddata[index].notes,
                                                      grapeVar: reddata[index]
                                                          .grapeVarieties,
                                                      producer: reddata[index]
                                                          .producer,
                                                      suggestedBottle:
                                                          reddata[index]
                                                              .suggestedBottle,
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
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? reddata[index]
                                                                              .producer
                                                                          : widget.type == "I VINI"
                                                                              ? reddata[index].color
                                                                              : reddata[index].country,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    widget.type ==
                                                                            "I VINI"
                                                                        ? Text(
                                                                            "Wine Producer: ${reddata[index].producer}",
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.grey))
                                                                        : SizedBox(),
                                                                    Text(
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? reddata[index]
                                                                              .wineRegion
                                                                          : widget.type == "I VINI"
                                                                              ? reddata[index].country
                                                                              : reddata[index].producer,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
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
                                ),
                                Scaffold(
                                  body: ListView(
                                    children: [
                                      TextField(
                                        controller: textcontrollerwhite,
                                        onChanged: onSearchTextChangedwhite,
                                        decoration: new InputDecoration(
                                            prefixIcon: new Icon(Icons.search,
                                                color: Colors.grey),
                                            hintText: "Search...",
                                            hintStyle: new TextStyle(
                                                color: Colors.grey)),
                                      ),
                                      _searchResultwhite.length != 0 ||
                                              textcontrollerwhite.text
                                                  .trim()
                                                  .toLowerCase()
                                                  .isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount:
                                                  _searchResultwhite.length,
                                              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(DetailScreen(
                                                      fav: false,
                                                      addnote:
                                                          _searchResultwhite[
                                                                  index]
                                                              .addnote,
                                                      webAdress:
                                                          _searchResultwhite[
                                                                  index]
                                                              .webAddress,
                                                      wineColor:
                                                          _searchResultwhite[
                                                                  index]
                                                              .color,
                                                      wineRegion:
                                                          _searchResultwhite[
                                                                  index]
                                                              .wineRegion,
                                                      wineType:
                                                          _searchResultwhite[
                                                                  index]
                                                              .wineType,
                                                      country:
                                                          _searchResultwhite[
                                                                  index]
                                                              .country,
                                                      village:
                                                          _searchResultwhite[
                                                                  index]
                                                              .village,
                                                      aging: _searchResultwhite[
                                                              index]
                                                          .agingInYears,
                                                      note: _searchResultwhite[
                                                              index]
                                                          .notes,
                                                      grapeVar:
                                                          _searchResultwhite[
                                                                  index]
                                                              .grapeVarieties,
                                                      producer:
                                                          _searchResultwhite[
                                                                  index]
                                                              .producer,
                                                      suggestedBottle:
                                                          _searchResultwhite[
                                                                  index]
                                                              .suggestedBottle,
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
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? _searchResultwhite[index]
                                                                              .producer
                                                                          : widget.type == "I VINI"
                                                                              ? _searchResultwhite[index].color
                                                                              : _searchResultwhite[index].country,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    widget.type ==
                                                                            "I VINI"
                                                                        ? Text(
                                                                            "Wine Producer: ${_searchResultwhite[index].producer}",
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.grey))
                                                                        : SizedBox(),
                                                                    Text(
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? _searchResultwhite[index]
                                                                              .wineRegion
                                                                          : widget.type == "I VINI"
                                                                              ? _searchResultwhite[index].country
                                                                              : _searchResultwhite[index].producer,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
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
                                              itemCount: whitedata.length,
                                              //    padding: EdgeInsets.only(top: 10, left: 6, right: 6),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(DetailScreen(
                                                      fav: false,
                                                      addnote: whitedata[index]
                                                          .addnote,
                                                      webAdress:
                                                          whitedata[index]
                                                              .webAddress,
                                                      wineColor:
                                                          whitedata[index]
                                                              .color,
                                                      wineRegion:
                                                          whitedata[index]
                                                              .wineRegion,
                                                      wineType: whitedata[index]
                                                          .wineType,
                                                      serial: whitedata[index]
                                                          .serial,
                                                      country: whitedata[index]
                                                          .country,
                                                      village: whitedata[index]
                                                          .village,
                                                      aging: whitedata[index]
                                                          .agingInYears,
                                                      note: whitedata[index]
                                                          .notes,
                                                      grapeVar: whitedata[index]
                                                          .grapeVarieties,
                                                      producer: whitedata[index]
                                                          .producer,
                                                      suggestedBottle:
                                                          whitedata[index]
                                                              .suggestedBottle,
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
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? whitedata[index]
                                                                              .producer
                                                                          : widget.type == "I VINI"
                                                                              ? whitedata[index].color
                                                                              : whitedata[index].country,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    widget.type ==
                                                                            "I VINI"
                                                                        ? Text(
                                                                            "Wine Producer: ${whitedata[index].producer}",
                                                                            style:
                                                                                TextStyle(fontSize: 14, color: Colors.grey))
                                                                        : SizedBox(),
                                                                    Text(
                                                                      widget.type ==
                                                                              "LE AZIENDE"
                                                                          ? whitedata[index]
                                                                              .wineRegion
                                                                          : widget.type == "I VINI"
                                                                              ? whitedata[index].country
                                                                              : whitedata[index].producer,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.grey),
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
                                ),
                              ],
                            ),
    );
  }
}
