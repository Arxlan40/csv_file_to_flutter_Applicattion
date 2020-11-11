import 'package:flutter/material.dart';

import 'localstorage.dart';
class DetailScreen extends StatelessWidget {
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

  DetailScreen(
      {this.producer,
      this.country,
      this.suggestedBottle,
      this.wineRegion,
      this.wineType,
      this.village,
      this.aging,
      this.grapeVar,
      this.note,
      this.webAdress,
      this.wineColor});
  // _save() async {
  //   RedWine wine = RedWine();
  //   wine.serial =  '1';
  //   wine.wineColor = wineColor;
  //   wine.wineType = wineType;
  //   wine.webAdress = webAdress;
  //   wine.wineRegion = wineRegion;
  //   wine.country = country;
  //   wine.producer = producer;
  //   wine.village = village;
  //   wine.suggestedBottle = suggestedBottle;
  //   wine.note = note;
  //   wine.aging = aging;
  //   wine.grapeVar = 'grapeVar';
  //
  //   DatabaseHelper helper = DatabaseHelper.instance;
  //   int id = await helper.insert(wine);
  //   print('inserted row: $id');
  // }
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
                  "Wine Created By $country",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Text(
                "$wineColor Wine",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
              )
            ],
          ),
          title: ListTile(
              trailing: IconButton(
            onPressed: () {
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
                "$wineColor",
              ),
            ),
            ListTile(
              title: Text("Wine Type"),
              subtitle: Text(
                "$wineType",
              ),
            ),
            ListTile(
              title: Text("Country"),
              subtitle: Text(
                "$country",
              ),
            ),
            ListTile(
              title: Text("Wine Region"),
              subtitle: Text(
                "$wineRegion",
              ),
            ),
            ListTile(
              title: Text("Village"),
              subtitle: Text(
                "$village",
              ),
            ),
            ListTile(
              title: Text("Grape Varieties"),
              subtitle: Text(
                "$grapeVar",
              ),
            ),
            ListTile(
              title: Text("Producer"),
              subtitle: Text(
                "$producer",
              ),
            ),
            ListTile(
              title: Text("Aging in Years"),
              subtitle: Text(
                "$aging",
              ),
            ),
            ListTile(
              title: Text("Suggested Bottle"),
              subtitle: Text(
                "$suggestedBottle",
              ),
            ),
            ListTile(
              title: Text("Web Address"),
              subtitle: Text(
                "${webAdress != null ? webAdress : "Not Found"}",
              ),
            ),
            ListTile(
              title: Text("Note"),
              subtitle: Text(
                "${note != null ? note : "Not Found"}",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
