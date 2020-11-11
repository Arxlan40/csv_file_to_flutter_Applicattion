import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spreadsheet/About.dart';
import 'package:spreadsheet/Favourite.dart';
import 'package:spreadsheet/test.dart';

import 'Contact.dart';
import 'localstorage.dart';

class HomeScreen extends StatelessWidget {
  @override
  double _height;
  double _width;

  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;

    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF800000),
      appBar: AppBar(
        backgroundColor: Color(0xFF800000),
        elevation: 5,
        title: Center(
            child: Text(
          "LA GUIDA DEI VINI NEL MONDO",
          style:
              TextStyle(fontSize: 18, fontFamily: "sans", color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(MyHomePage(type: "LE AZIENDE",));
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          elevation: 10,
                          color: Color(0xFF800000),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/comp.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'LE AZIENDE',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(MyHomePage(type: "I VINI",));
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          color: Color(0xFF800000),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/wine.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'I VINI',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(MyHomePage(type: "LE NAZIONI",));
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          elevation: 10,
                          color: Color(0xFF800000),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/world.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'LE NAZIONI',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(Favourite());
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          color: Color(0xFF800000),
                          elevation: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/fav.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'PREFERITA',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(About());
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          elevation: 10,
                          color: Color(0xFF800000),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/about.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'CHI SIAMO',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(Contact());
                    },
                    child: Container(
                      width: _width / 2,
                      height: 200,
                      child: Card(
                          elevation: 10,
                          color: Color(0xFF800000),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/files/support.png',
                                height: 150,
                                width: 120,
                              ),
                              Text(
                                'CONTATTACI',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "sans"),
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
