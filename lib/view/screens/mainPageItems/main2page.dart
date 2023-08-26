import 'package:flutter/material.dart';
class Main2page extends StatefulWidget {
  const Main2page({Key? key}) : super(key: key);

  @override
  State<Main2page> createState() => _Main2pageState();
}

class _Main2pageState extends State<Main2page> {

  @override
  Widget build(BuildContext context) {
    final  screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return Container(
      color: Color(0xffeff3f2),
      height: double.infinity,
      width: screenWidth * 0.9 - 1,
      child: Container(),
    );
  }
}
