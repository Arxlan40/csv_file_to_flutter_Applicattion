// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.red,
  });

  List<Red> red;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    red: List<Red>.from(json["Red"].map((x) => Red.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Red": List<dynamic>.from(red.map((x) => x.toJson())),
  };
}

class Red {
  Red({
    this.color,
    this.agingInYears,
    this.wineType,
    this.grapeVarieties,
    this.village,
    this.wineRegion,
    this.country,
    this.producer,
    this.suggestedBottle,
    this.notes,
    this.webAddress,
    this.serial,
    this.addnote,
  });

  String color;
  String agingInYears;
  String wineType;
  String grapeVarieties;
  String village;
  String wineRegion;
  String country;
  String producer;
  String suggestedBottle;
  String notes;
  String webAddress;
  String serial;
  String addnote;

  factory Red.fromJson(Map<String, dynamic> json) => Red(
    color: json["Color"],
    agingInYears: json["Aging in Years"],
    wineType: json["Wine Type"],
    grapeVarieties: json["Grape Varieties"],
    village: json["Village"],
    wineRegion: json["Wine Region"],
    country: json["Country"],
    producer: json["Producer"],
    suggestedBottle: json["Suggested Bottle"],
    notes: json["Notes"],
    webAddress: json["web address"],
      serial: json["Serial"],
    addnote:json['Additional Notes'],
  );

  Map<String, dynamic> toJson() => {
    "Color": color,
    "Aging in Years": agingInYears,
    "Wine Type": wineType,
    "Grape Varieties": grapeVarieties,
    "Village": village,
    "Wine Region": wineRegion,
    "Country": country,
    "Producer": producer,
    "Suggested Bottle": suggestedBottle,
    "Notes": notes,
    "web address": webAddress,
    "Serial": serial,
    "Additional Notes":addnote,
  };
}
