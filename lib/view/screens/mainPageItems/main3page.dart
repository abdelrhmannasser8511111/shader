import 'package:flutter/material.dart';
class Main3page extends StatefulWidget {
  const Main3page({Key? key}) : super(key: key);

  @override
  State<Main3page> createState() => _Main3pageState();
}

class _Main3pageState extends State<Main3page> {

  @override
  Widget build(BuildContext context) {
    final  screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return Container(
      width: screenWidth * 0.9 - 1,
      height: double.infinity,
      color: Color(0xffeff3f2),
      child: Text("3"),
    );
  }
}
