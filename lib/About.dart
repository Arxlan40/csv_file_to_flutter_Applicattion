// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/html_parser.dart';
// import 'package:flutter_html/style.dart';

// class About extends StatefulWidget {
//   About({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _AboutState createState() => new _AboutState();
// }

// const htmlData = """
// <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of "de Finibus Bonorum et Malorum" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.

// The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc</p>
//       <!--
//       <h3>Video support:</h3>
//       <video controls>
//         <source src="https://www.w3schools.com/html/mov_bbb.mp4" />
//       </video>
//       <h3>Audio support:</h3>
//       <audio controls>
//         <source src="https://www.w3schools.com/html/horse.mp3" />
//       </audio>
//       <h3>IFrame support:</h3>
//       <iframe src="https://google.com"></iframe>
//       -->
// """;

// class _AboutState extends State<About> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Color(0xFF800000),
//         title: Text('CHI SIAMO',
//             style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Colors.white,
//                 fontFamily: "sans")),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Html(
//           data: htmlData,
//           //Optional parameters:
//           style: {
//             "html": Style(
//               backgroundColor: Colors.white,
// //              color: Colors.white,
//             ),
// //            "h1": Style(
// //              textAlign: TextAlign.center,
// //            ),
//             "table": Style(
//               backgroundColor: Colors.white,
//             ),
//             "tr": Style(
//               border: Border(bottom: BorderSide(color: Colors.white)),
//             ),
//             "th": Style(
//               padding: EdgeInsets.all(6),
//               backgroundColor: Colors.white,
//             ),
//             "td": Style(
//               padding: EdgeInsets.all(6),
//             ),
//             "var": Style(fontFamily: 'serif'),
//           },
//           customRender: {
//             "flutter": (RenderContext context, Widget child, attributes, _) {
//               return FlutterLogo(
//                 style: (attributes['horizontal'] != null)
//                     ? FlutterLogoStyle.horizontal
//                     : FlutterLogoStyle.markOnly,
//                 textColor: context.style.color,
//                 size: context.style.fontSize.size * 5,
//               );
//             },
//           },
//           onLinkTap: (url) {
//             print("Opening $url...");
//           },
//           onImageTap: (src) {
//             print(src);
//           },
//           onImageError: (exception, stackTrace) {
//             print(exception);
//           },
//         ),
//       ),
//     );
//   }
// }
