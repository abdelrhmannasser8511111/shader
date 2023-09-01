// import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
// import 'package:flutter/material.dart';
//
// class Tesst extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(),
//         initialRoute: '/',
//         routes: {'/': (BuildContext context) => MyHomePage()});
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   final ScrollController horizontalScroll = ScrollController();
//   final ScrollController verticalScroll = ScrollController();
//   final double width = 20;
//
//   @override
//   Widget build(BuildContext context) {
//     return AdaptiveScrollbar(
//         controller: verticalScroll,
//         width: width,
//         scrollToClickDelta: 75,
//         scrollToClickFirstDelay: 200,
//         scrollToClickOtherDelay: 50,
//         sliderDecoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(12.0))),
//         sliderActiveDecoration: BoxDecoration(
//             color: Color.fromRGBO(206, 206, 206, 100),
//             borderRadius: BorderRadius.all(Radius.circular(12.0))),
//         underColor: Colors.transparent,
//         child: AdaptiveScrollbar(
//             underSpacing: EdgeInsets.only(bottom: width),
//             controller: horizontalScroll,
//             width: width,
//             position: ScrollbarPosition.bottom,
//             sliderDecoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(12.0))),
//             sliderActiveDecoration: BoxDecoration(
//                 color: Color.fromRGBO(206, 206, 206, 100),
//                 borderRadius: BorderRadius.all(Radius.circular(12.0))),
//             underColor: Colors.transparent,
//             child: SingleChildScrollView(
//                 controller: horizontalScroll,
//                 scrollDirection: Axis.horizontal,
//                 child: Container(
//                     width: 3000,
//                     child: Scaffold(
//                       appBar: AppBar(
//                           title: Text("Example",
//                               style: TextStyle(color: Colors.black)),
//                           flexibleSpace: Container(
//                               decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                       colors: [
//                                         Colors.blueAccent,
//                                         Color.fromRGBO(208, 206, 255, 1)
//                                       ])))),
//                       body: Container(
//                           color: Colors.lightBlueAccent,
//                           child: ListView.builder(
//                               padding: EdgeInsets.only(bottom: width),
//                               controller: verticalScroll,
//                               itemCount: 100,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   height: 30,
//                                   color: Colors.lightBlueAccent,
//                                   child: Text("Line " + index.toString()),
//                                 );
//                               })),
//                     )))));
//   }
// }