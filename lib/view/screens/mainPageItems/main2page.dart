import 'package:flutter/material.dart';

import '../billsPage.dart';
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BillsPage()));

            },
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black,blurRadius: 12)]
                ),
                alignment: Alignment.center,
                height: screenHeight*0.15,width: screenWidth*0.2,
                child: Text("فواتير مشترين",style: TextStyle(fontSize: screenWidth*0.013,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          SizedBox(width: screenWidth*0.05,),
          Card(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 12)]
              ),
              alignment: Alignment.center,
              height: screenHeight*0.15,width: screenWidth*0.2,
              child: Text("فواتير موردين",style: TextStyle(fontSize: screenWidth*0.013,fontWeight: FontWeight.bold),),
            ),
          )

        ],
      ),
    );
  }
}
