import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shader/model/moshtry.dart';
import 'package:shader/model/resala.dart';
import 'package:shader/view/screens/mainPageItems/test.dart';
import 'package:shader/view/screens/resalaControlPage.dart';
import 'package:shader/view/screens/sellingProcessControlPage.dart';
import 'package:shader/view/screens/sellingProcessPage.dart';
import 'package:shader/view/widget/commonWidgit.dart';
import 'package:shader/view/widget/oprationsDialog.dart';

import '../../../../controller/dbController.dart';
import '../mwaredMoshtryControlPage.dart';

class Main1page extends StatefulWidget {
  const Main1page({Key? key}) : super(key: key);

  @override
  State<Main1page> createState() => _Main1pageState();
}

class _Main1pageState extends State<Main1page> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return Container(
      color: Color(0xffeff3f2),
      width: screenWidth * 0.9 - 1,
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "الرسائل",
                  style: TextStyle(
                      fontSize: screenWidth * 0.015,
                      fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap: () async {

                  // await  SqlHelper.deletetable(TableNameAsWrittenINDB: 'resala');
                  //   for(int i=0;i<=50;i++){
                  //     await  SqlHelper.createItem(
                  //         TableNameAsWrittenINDB: 'resala',
                  //         modelData: ResalaModel(
                  //           date: '7-8-2000',
                  //           nameofmwared: 'abdelrhman',
                  //           nawloon: 200,
                  //           catCount: 2,
                  //           ctegoriesDetails: List<CattegoriesOfResala>.generate(
                  //               4,
                  //                   (index) => CattegoriesOfResala(
                  //                 netWeight: 500,
                  //                 count: 20,
                  //                 catName: 'منجه',
                  //                 boxType: 'صندوق',
                  //               )),
                  //           mwaredId: 222,
                  //           totalCountOfBoxes: 80,
                  //           TotalNetWeight: 2000,
                  //         ));
                  //   }

                    // print("${await SqlHelper.getData(TableNameAsWrittenInDB: 'resala')}");
                    ResalaDialog(
                      context: context,
                      editTybe: 'add',
                    );
                  },
                  child: Card(
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black, spreadRadius: 1)
                        // ]
                      ),
                      child: Text("إدخال رسالة",
                          style: TextStyle(fontSize: screenWidth * 0.015)),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async{
                  // print('SqlHelper.getItem${SqlHelper.getItem(TableNameAsWrittenInDB: 'resala', id: 55,)}');
                // await  SqlHelper.getItem(TableNameAsWrittenInDB: 'resala', id: 1,);
                  // for (int i = 0; i <= 99; i++) {
                  //   SqlHelper.createItem(
                  //       TableNameAsWrittenINDB: 'resala',
                  //       modelData: ResalaModel(
                  //         date: "${DateTime.now().add(Duration(days: i+1))}",
                  //         countOfBoxes: i,
                  //         nameofCatt: "nameofCatt$i",
                  //         nameofmwared: "$i _nameofmwared",
                  //         netWeight: i+200,
                  //       ));
                  // }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ResalaControlPage()));
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(color: Colors.black, spreadRadius: 3)
                      // ]
                    ),
                    child: Text("تعديل رسالة",
                        style: TextStyle(
                          fontSize: screenWidth * 0.015,
                        )),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "عملاء",
                  style: TextStyle(
                      fontSize: screenWidth * 0.015,
                      fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        // SqlHelper.deletetable(
                        //     TableNameAsWrittenINDB: 'moshtry');
                        // print("${SqlHelper.getData(TableNameAsWrittenInDB: 'moshtry')}");
                        await AddUpdateMoshtryDialog(
                            context: context, editTybe: 'add');
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.black, spreadRadius: 1)
                            // ]
                          ),
                          child: Text("إضافة مشتري",
                              style: TextStyle(fontSize: screenWidth * 0.01)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // for(int i=0;i<=99;i++){
                        //   SqlHelper.createItem(
                        //       TableNameAsWrittenINDB: 'moshtry',
                        //       modelData: MoshtryModel(
                        //           name: "$i moshtry",
                        //           phonNumb:123456789,
                        //           notice: 'noticeController.text'));
                        // }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MwaredMoshtryControlPage(
                                  type: 'moshtry',
                                )));
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.black, spreadRadius: 1)
                            // ]
                          ),
                          child: Text("تعديل وحذف مشتري",
                              style: TextStyle(fontSize: screenWidth * 0.01)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        await AddUpdatemwaredDialog(
                            context: context, editTybe: 'add');
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.black, spreadRadius: 1)
                            // ]
                          ),
                          child: Text("إضافة مورد",
                              style: TextStyle(fontSize: screenWidth * 0.01)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        // SqlHelper.deletetable(TableNameAsWrittenINDB: 'mwared');
                        // for(int i=0;i<=99;i++){
                        //   SqlHelper.createItem(
                        //       TableNameAsWrittenINDB: 'mwared',
                        //       modelData: MwaredModel(
                        //           name: "$i _mwared",
                        //           phonNumb:123456789,
                        //           notice: 'noticeController.text',address: 'adressController.text)'));
                        // }
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => MwaredMoshtryControlPage(
                                  type: 'mwared',
                                )));
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // boxShadow: [
                            //   BoxShadow(color: Colors.black, spreadRadius: 1)
                            // ]
                          ),
                          child: Text("تعديل وحذف مورد",
                              style: TextStyle(fontSize: screenWidth * 0.01)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Text(
                  "عليات البيع",
                  style: TextStyle(
                      fontSize: screenWidth * 0.015,
                      fontWeight: FontWeight.bold),
                ),
                margin: EdgeInsets.only(bottom: screenHeight * 0.01),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: InkWell(
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SellingProcessPage()));
                  },
                  child: Card(
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.13,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(color: Colors.black, spreadRadius: 1)
                        // ]
                      ),
                      child: Text("تسجيل عملية بيع",
                          style: TextStyle(fontSize: screenWidth * 0.015)),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap:(){
                  //SellingProcessControlPage()
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SellingProcessControlPage()));
                },
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.13,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // boxShadow: [
                      //   BoxShadow(color: Colors.black, spreadRadius: 3)
                      // ]
                    ),
                    child: Text("تعديل وحذف عملية بيع",
                        style: TextStyle(
                          fontSize: screenWidth * 0.015,
                        )),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
