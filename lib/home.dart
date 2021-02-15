import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spreadsheet/Favourite.dart';
import 'package:spreadsheet/HomePage.dart';

import 'Country.dart';
import 'ProducerList.dart';

class HomeWine extends StatelessWidget {
  double _height;
  double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Wine Time",
          style: TextStyle(fontFamily: "sans"),
        ),
        backgroundColor: Color(0xFF800000),
        elevation: 5,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Get.to(MyHomePage(type: "redgrap", title: "RED WINE BY GRAPE"));

              //   Get.to(Countries(type: "redgrap",title: "RED WINE BY GRAPE",));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Red Wine By Grape",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Image.asset(
                          "assets/files/red.png",
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
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
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(
                  MyHomePage(type: "whitegrap", title: "WHITE WINE BY GRAPE"));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "White Wine By Grape",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Image.asset(
                          "assets/files/white.png",
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
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
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(Countries(type: "redcount", title: "RED WINE BY COUNTRY"));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Red Wine By Country",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Image.asset(
                          "assets/files/red.png",
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
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
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(Countries(
                  type: "whitecount", title: "WHITE WINE BY COUNTRY"));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "White Wine By Country",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 35.0),
                        child: Image.asset(
                          "assets/files/white.png",
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
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
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(ProducerList());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Producer List",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 23.0),
                        child: Image.asset(
                          "assets/files/producers.png",
                          height: 70,
                          width: 80,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
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
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(Favourite());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 10, bottom: 30),
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Favourite List",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFF800000),
                            size: 50,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 10),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  //    Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
