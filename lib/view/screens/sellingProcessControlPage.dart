import 'dart:collection';

import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shader/model/resala.dart';
import 'package:shader/model/sellingData.dart';

import '../../controller/dataRepo.dart';
import '../../controller/dbController.dart';
import '../widget/commonWidgit.dart';
import '../widget/tableWidget.dart';

GlobalKey<FormState> keyForlist = new GlobalKey<FormState>();

class SellingProcessControlPage extends StatefulWidget {
  const SellingProcessControlPage({Key? key}) : super(key: key);

  @override
  State<SellingProcessControlPage> createState() =>
      _SellingProcessControlPageState();
}

class _SellingProcessControlPageState extends State<SellingProcessControlPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc.getData(TableNameAsWrittenInDB: 'sellingData');
    super.initState();
  }

  ScrollController scrollconrol = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        color: Color(0xffeff3f2),
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<UnmodifiableListView<SellingDataModel>>(
          stream: bloc.sellingDataStream,
          initialData: UnmodifiableListView<SellingDataModel>([]),
          builder: (context, sellingSnapShot) {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.02, top: screenHeight * 0.02),
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      detectedItems.clear();
                      checkBoxValue.clear();
                      print('detectedItems$detectedItems');
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.keyboard_backspace,
                      size: screenHeight * 0.065,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        margin: EdgeInsets.only(
                            bottom: 5,
                            right: screenWidth * 0.04,
                            top: screenHeight * 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Text("البحث من خلال الاسم :",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.014,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Container(
                              width: screenWidth * 0.15,
                              height: screenHeight * 0.04,
                              child: TextField(
                                cursorHeight: screenHeight * 0.03,
                                cursorColor: Color(0xff22a39f),
                                controller: searchController,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                // textAlign: TextAlign.left,
                                onTap: () {},
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff22a39f), width: 2.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff22a39f)),
                                    // borderRadius: BorderRadius.circular(50)
                                  ),
                                  hintText: 'البحث بالاسم',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.01),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      Form(
                        key: keyForlist,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 5,
                              right: screenWidth * 0.04,
                              top: screenHeight * 0.02),
                          height:
                              detectedItems.isEmpty ? 0 : screenHeight * 0.044,
                          // width: detectedItems.isEmpty?0:screenWidth*0.06,

                          child: ElevatedButton(
                              onPressed: () async {
                                await SqlHelper.deleteItem(
                                        TableNameAsWrittenINDB: 'sellingData',
                                        id: detectedItems)
                                    .then((value) async {
                                  if (value is int && value != 0) {
                                    print('detectedItems$detectedItems');
                                    detectedItems.clear();
                                    changeCheckBoxValueToFalse();

                                    return snackBar(
                                        context: context, content: 'تم الحذف');
                                  } else {
                                    errDialog(
                                        context: context,
                                        err: value.toString());
                                  }
                                });

                                // _keyForlist.currentState!.re;
                              },
                              child: Row(
                                children: [
                                  Text("حذف",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: detectedItems.isEmpty
                                        ? 0
                                        : screenHeight * 0.033,
                                  )
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red)),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.8,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: screenWidth * 0.03),
                        height: screenHeight * 0.08,
                        color: Colors.white,
                        child: Row(
                          children: [
                            // Container(
                            //   child: Checkbox(
                            //     activeColor: Color(0xff22a39f),
                            //     checkColor: Color(0xffeff3f2),
                            //     focusColor: Color(0xffeff3f2),
                            //     value: checkBoxValue,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         checkBoxValue = value!;
                            //         savedetectedDataToremove(checkBoxValue, widget.id);
                            //         widget.voidCallBack();
                            //       });
                            //
                            //       print("ffffffffffff$checkBoxValue");
                            //
                            //       // voidCallback();
                            //     },
                            //   ),
                            // ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.12,
                              child: Text(
                                "${'اسم الرساله'}",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.12,
                              child: Text(
                                "اسم المشتري",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "العدد",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "الوزن",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "السعر",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "الصنف",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "العمولة",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                              child: Text(
                                "البوابة",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.08,
                              child: Text(
                                "الاجمالي بعد البوابة",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.1,
                              child: Text(
                                "ملاحظات عملية البيع",
                                style: TextStyle(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        // key: _keyForlist,
                        width: screenWidth * 0.95,
                        height: screenHeight * 0.7,
                        child: getTableRows(
                            snapshot: sellingSnapShot,
                            controller: searchController,
                            callback: () {
                              setState(() {});
                            }),

                        //  ListView(children:
                        // searchController.text.isEmpty?
                        //  mwaredsnapshot.data!.map((e) {
                        //    return   RowInTable(
                        //      name: e.name,
                        //      notice: "${e.notice}",
                        //      phoneNumb: e.phonNumb,
                        //      adress: e.address,
                        //      id: e.id,
                        //      voidCallBack: (){
                        //        setState(() {
                        //
                        //        });                              },);
                        //  } ).toList():mwaredsnapshot.data!.where((element) => element.name.contains(searchController.text)).map((e) {
                        //   return   RowInTable(
                        //     name: e.name,
                        //     notice: "${e.notice}",
                        //     phoneNumb: e.phonNumb,
                        //     adress: e.address,
                        //     id: e.id,
                        //     voidCallBack: (){
                        //       setState(() {
                        //
                        //       });
                        //     },);
                        // } ).toList()
                        //     ),
                      )
                    ],
                  ),
                ),
              ],
            );
            ;
          },
        ),
      ),
    );
  }

  Widget getTableRows(
      {required AsyncSnapshot<UnmodifiableListView<SellingDataModel>> snapshot,
      required TextEditingController controller,
      required VoidCallback callback}) {
    final data = snapshot.data!
        .where((element) => element.customerName.contains(controller.text))
        .toList();

    if (controller.text.isEmpty) {
      return ListView.builder(

          // key: _keyForlist,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            print("index${index}");
            return RowSellingProcessInTable(
              // key: Key(index.toString()),

              voidCallBack: callback,
              sellingData: snapshot.data![index],
              allSellingDataOnthisResala: snapshot.data!.where((element) => element.resalaId==snapshot.data![index].resalaId).toList(),
            );
          });
    } else {
      return ListView.builder(

          // key: _keyForlist,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return RowSellingProcessInTable(
              voidCallBack: callback,
              sellingData: data[index], allSellingDataOnthisResala: snapshot.data!.where((element) => element.resalaId==data[index].resalaId).toList(),
            );
          });
    }
  }
}
