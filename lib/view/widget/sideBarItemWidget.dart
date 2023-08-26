import 'package:flutter/material.dart';

import '../../controller/dataRepo.dart';
class SideBarItemWidget extends StatefulWidget  {
  String name;
  IconData iconshape;
  int screenNumb;
  VoidCallback vcallback;
   SideBarItemWidget({Key? key,required this.name,required this.iconshape,required this.screenNumb,required this.vcallback}) : super(key: key);

  @override
  State<SideBarItemWidget> createState() => _SideBarItemWidgetState();
}

class _SideBarItemWidgetState extends State<SideBarItemWidget> {
  Color sideBarItemsColor=Colors.white;

  @override
  Widget build(BuildContext context) {
    final  screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return InkWell(

      onTap: (){
        setState(() {
          mainOpenPageforSideBar=  widget.screenNumb;
          widget.vcallback();
        });

      },
      child:  Container(
        margin: EdgeInsets.only(bottom: screenHeight*0.01),
        color: mainOpenPageforSideBar==widget.screenNumb?Color(0xffeff3f2):Colors.white,
        width: screenWidth*0.1,

        padding: EdgeInsets.all(4),
        child:
        Tab(
          icon: Icon(widget.iconshape),
          text:widget.name,
        ),
      ),
    );
  }
}
