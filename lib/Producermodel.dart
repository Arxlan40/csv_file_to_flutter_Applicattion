// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.sheet1,
  });

  List<ProducerModel> sheet1;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    sheet1: List<ProducerModel>.from(json["Sheet1"].map((x) => ProducerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Sheet1": List<dynamic>.from(sheet1.map((x) => x.toJson())),
  };
}

class ProducerModel {
  ProducerModel({
    this.producer,
    this.country,
    this.wineRegion,
    this.village,
    this.webAddress,
    this.serial,
  });

  String producer;
  String country;
  String wineRegion;
  String village;
  String webAddress;
  String serial;

  factory ProducerModel.fromJson(Map<String, dynamic> json) => ProducerModel(
    producer: json["Producer"],
    country: json["Country"],
    wineRegion: json["Wine Region"],
    village: json["Village"],
    webAddress: json["Web Address"],
    serial: json["Serial"],
  );

  Map<String, dynamic> toJson() => {
    "Producer": producer,
    "Country": country,
    "Wine Region": wineRegion,
    "Village": village,
    "Web Address": webAddress,
    "Serial": serial,
  };
}
