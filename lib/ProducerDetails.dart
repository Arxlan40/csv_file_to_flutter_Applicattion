import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import 'localstorage.dart';

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

  bool fav;

  ProducerDetail(
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
        this.addnote,
        this.webAdress,
        this.wineColor});

  @override
  _ProducerDetailState createState() => _ProducerDetailState();
}

class _ProducerDetailState extends State<ProducerDetail> {

  @override
  void initState() {
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
        child: Column(
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
                  Flexible(
                    child: Text(
                      "${widget.webAdress}",
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
      ),
    );
  }
}
