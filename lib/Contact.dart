import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  List<String> attachments = [];
  bool isHTML = false;

  final _recipientController = TextEditingController(
    text: 'example@example.com',
  );

  final _subjectController = TextEditingController(text: 'The subject');

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> send() async {
    final Email email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: ["Arxlanumer40@gmail.com"],
      attachmentPaths: attachments,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Mail Sent';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
         backgroundColor: Color(0xFF800000),
        title: Text('CONTATTACI',style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: "sans")),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: 10,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
              // CheckboxListTile(
              //   title: Text('HTML'),
              //   onChanged: (bool value) {
              //     setState(() {
              //       isHTML = value;
              //     });
              //   },
              //   value: isHTML,
              // ),
              ...attachments.map(
                    (item) => Text(
                  item,
                  overflow: TextOverflow.fade,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: FlatButton(
                  onPressed: send,
                  child: Text(
                    'Spedire',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: "sans"),
                  ),
                  color: Color(0xFF800000),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   icon: Icon(Icons.camera),
      //   label: Text('Add Image'),
      //   onPressed: _openImagePicker,
      // ),
    );
  }

// void _openImagePicker() async {
//   File pick = await ImagePicker.pickImage(source: ImageSource.gallery);
//   setState(() {
//     attachments.add(pick.path);
//   });
// }
}
