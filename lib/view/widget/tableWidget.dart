import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shader/model/moshtry.dart';
import 'package:shader/model/mwared.dart';
import 'package:shader/model/resala.dart';
import 'package:shader/model/sellingData.dart';
import 'package:shader/view/widget/updateSellingProcessDialog.dart';

import '../../controller/dataRepo.dart';
import '../screens/resalaControlPage.dart';
import 'oprationsDialog.dart';

int setcheckBoxValue() {
  checkBoxValue.add(false);
  print("checkBoxValue${checkBoxValue.length - 1}");
  return checkBoxValue.length - 1;
}

class RowMwaredInTable extends StatefulWidget {
  RowMwaredInTable(
      {Key? key,
      required this.name,
      required this.notice,
      required this.phoneNumb,
      required this.adress,
      required this.id,
      required this.voidCallBack})
      : super(key: key);
  String name;
  int? phoneNumb;
  String? adress;
  String notice;
  int? id;

  VoidCallback voidCallBack;

  @override
  State<RowMwaredInTable> createState() => _RowMwaredInTableState();
}

class _RowMwaredInTableState extends State<RowMwaredInTable> {
  final indexInListCheckBox = setcheckBoxValue();

  // bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBar = MediaQuery.of(context).padding.top;
    return InkWell(
      onDoubleTap: () {
        AddUpdatemwaredDialog(
            context: context,
            editTybe: 'update',
            mwaredDataForUpdate: MwaredModel(
              name: widget.name,
              id: widget.id,
              address: widget.adress,
              phonNumb: widget.phoneNumb,
              notice: widget.notice,
            ));
      },
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.04,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.03,
                  height: screenHeight * 0.01,
                  child:
                      // checkBox(id: widget.id!, callback: widget.voidCallBack, tableCallbac: () {  },)
                      Checkbox(
                    activeColor: Color(0xff22a39f),
                    checkColor: Color(0xffeff3f2),
                    focusColor: Color(0xffeff3f2),
                    value: checkBoxValue[indexInListCheckBox],
                    onChanged: (value) {
                      setState(() {
                        checkBoxValue[indexInListCheckBox] = value!;
                        savedetectedDataToremove(
                            checkBoxValue[indexInListCheckBox], widget.id!);
                        widget.voidCallBack();
                      });

                      // print("ffffffffffff$checkBoxValue");

                      // voidCallback();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.name}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.phoneNumb}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.2,
                  child: Text(
                    "${widget.adress}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.2,
                  child: Text(
                    "${widget.notice}",
                    style: TextStyle(),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class RowMoshtryInTable extends StatefulWidget {
  RowMoshtryInTable(
      {Key? key,
      required this.name,
      required this.notice,
      required this.phoneNumb,
      required this.id,
      required this.voidCallBack})
      : super(key: key);
  String name;
  int? phoneNumb;
  String notice;
  int? id;

  VoidCallback voidCallBack;

  @override
  State<RowMoshtryInTable> createState() => _RowMoshtryInTableState();
}

class _RowMoshtryInTableState extends State<RowMoshtryInTable> {
  final indexInListCheckBox = setcheckBoxValue();

  // bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBar = MediaQuery.of(context).padding.top;
    return InkWell(
      onDoubleTap: () {
        AddUpdateMoshtryDialog(
            context: context,
            editTybe: 'update',
            moshtryDataForUpdate: MoshtryModel(
                name: widget.name,
                phonNumb: widget.phoneNumb,
                notice: widget.notice,
                id: widget.id));
      },
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.04,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.03,
                  height: screenHeight * 0.01,
                  child:
                      // checkBox(id: widget.id!, callback: widget.voidCallBack, tableCallbac: () {  },)
                      Checkbox(
                    activeColor: Color(0xff22a39f),
                    checkColor: Color(0xffeff3f2),
                    focusColor: Color(0xffeff3f2),
                    value: checkBoxValue[indexInListCheckBox],
                    onChanged: (value) {
                      setState(() {
                        checkBoxValue[indexInListCheckBox] = value!;
                        savedetectedDataToremove(
                            checkBoxValue[indexInListCheckBox], widget.id!);
                        widget.voidCallBack();
                      });

                      print("ffffffffffff$checkBoxValue");

                      // voidCallback();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.name}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.phoneNumb}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.2,
                  child: Text(
                    "${widget.notice}",
                    style: TextStyle(),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

class RowSellingProcessInTable extends StatefulWidget {
  RowSellingProcessInTable(
      {Key? key,
      required this.voidCallBack,
      required this.sellingData,
      required this.allSellingDataOnthisResala})
      : super(key: key);
  VoidCallback voidCallBack;
  SellingDataModel sellingData;
  List<SellingDataModel> allSellingDataOnthisResala;

  @override
  State<RowSellingProcessInTable> createState() =>
      _RowSellingProcessInTableState();
}

class _RowSellingProcessInTableState extends State<RowSellingProcessInTable> {
  final indexInListCheckBox = setcheckBoxValue();

  // bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBar = MediaQuery.of(context).padding.top;
    return InkWell(
      // key: UniqueKey(),
      onDoubleTap: () async {
        final f = await bloc.dataFromResalaSream;
        ResalaModel currentReala = f.firstWhere(
            (element) => element.resalaId == widget.sellingData.resalaId);
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (ctx) => UpdateSellingProcessDialog(
              callBack: widget.voidCallBack,
                  currentResala: currentReala,
                  sellingProcessDataOnThisResala:
                      widget.allSellingDataOnthisResala,
                  thisSellingProcess: widget.sellingData,
                ));
        // updateSellingProcessDialog(
        //   sellingProcess: widget.sellingData,
        //   currentResala: currentReala,
        //   sellingProcessDataOnThisResala: widget.allSellingDataOnthisResala,
        //   context: context,
        // );
        // ResalaDialog(context: context,
        //     editTybe: 'update',
        //     resalaDataForUpdate: widget.);
      },
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.04,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.03,
                  height: screenHeight * 0.01,
                  child:
                      // checkBox(id: widget.id!, callback: widget.voidCallBack, tableCallbac: () {  },)
                      Checkbox(
                    key: UniqueKey(),
                    activeColor: Color(0xff22a39f),
                    checkColor: Color(0xffeff3f2),
                    focusColor: Color(0xffeff3f2),
                    value: checkBoxValue[indexInListCheckBox],
                    onChanged: (value) {
                      checkBoxValue[indexInListCheckBox] = value!;
                      print(
                          "widget.checkValue${checkBoxValue[indexInListCheckBox]}");
                      savedetectedDataToremove(
                          checkBoxValue[indexInListCheckBox],
                          widget.sellingData.sellingProcessId!);
                      // keyForlist.currentContext.
                      widget.voidCallBack();

                      // print("ffffffffffff$checkBoxValue");

                      // voidCallback();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.12,
                  child: Text(
                    "${widget.sellingData.resalName}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.12,
                  child: Text(
                    "${widget.sellingData.customerName}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.numbOfBox}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.weight}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.sellingPrice}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.categoryFresala}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.amola}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.06,
                  child: Text(
                    "${widget.sellingData.bwabaValue}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.08,
                  child: Text(
                    "${widget.sellingData.totalAfterBwaba}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.1,
                  child: Text(
                    "${widget.sellingData.notice}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

class RowResalaInTable extends StatefulWidget {
  RowResalaInTable(
      {Key? key, required this.voidCallBack, required this.resalaData})
      : super(key: key);

  VoidCallback voidCallBack;
  ResalaModel resalaData;

  @override
  State<RowResalaInTable> createState() => _RowResalaInTableState();
}

class _RowResalaInTableState extends State<RowResalaInTable> {
  final indexInListCheckBox = setcheckBoxValue();

  // bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBar = MediaQuery.of(context).padding.top;
    return InkWell(
      key: UniqueKey(),
      onDoubleTap: () {
        ResalaDialog(
            context: context,
            editTybe: 'update',
            resalaDataForUpdate: widget.resalaData);
      },
      child: Container(
        color: Colors.white,
        height: screenHeight * 0.04,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: screenWidth * 0.03,
                  height: screenHeight * 0.01,
                  child:
                      // checkBox(id: widget.id!, callback: widget.voidCallBack, tableCallbac: () {  },)
                      Checkbox(
                    key: UniqueKey(),
                    activeColor: Color(0xff22a39f),
                    checkColor: Color(0xffeff3f2),
                    focusColor: Color(0xffeff3f2),
                    value: checkBoxValue[indexInListCheckBox],
                    onChanged: (value) {
                      checkBoxValue[indexInListCheckBox] = value!;
                      print(
                          "widget.checkValue${checkBoxValue[indexInListCheckBox]}");
                      savedetectedDataToremove(
                          checkBoxValue[indexInListCheckBox],
                          widget.resalaData.resalaId!);
                      // keyForlist.currentContext.
                      widget.voidCallBack();

                      // print("ffffffffffff$checkBoxValue");

                      // voidCallback();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.resalaData.nameofmwared}",
                    style: TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.15,
                  child: Text(
                    "${widget.resalaData.catCount}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.1,
                  child: Text(
                    "${widget.resalaData.totalCountOfBoxes}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.1,
                  child: Text(
                    "${widget.resalaData.TotalNetWeight}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.1,
                  child: Text(
                    "${widget.resalaData.status}",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerRight,
                  width: screenWidth * 0.2,
                  child: Text(
                    "${widget.resalaData.resalaDescription}",
                    style: TextStyle(),
                  ),
                )
              ],
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}

// class table extends StatefulWidget {
//   table(
//       {required this.tableHeight,
//       required this.tableWidth,
//       required this.rowCount,
//       required this.itemsId,
//       required this.titleItems,
//       required this.callback});
//
//   double tableHeight;
//   double tableWidth;
//   int rowCount;
//   List itemsId;
//   List<TableItemField> titleItems;
//   VoidCallback callback;
//
//   @override
//   State<table> createState() => _tableState();
// }
//
// class _tableState extends State<table> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: widget.tableWidth,
//       height: widget.tableHeight,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(right: 15),
//             height: widget.tableHeight * 0.08,
//             width: widget.tableWidth,
//             child: Row(
//               children: widget.titleItems.map((e) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 22),
//                   alignment: Alignment.centerRight,
//                   width: e.titleWidth,
//                   child: Text(
//                     e.titleName,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           Divider(
//             thickness: 1,
//           ),
//           Container(
//             height: widget.tableHeight * 0.8,
//             child: ListView.builder(
//                 itemCount: widget.rowCount,
//                 itemBuilder: (ctx, index) {
//                   final f = index;
//
//                   return Container(
//                       padding: EdgeInsets.only(right: 15),
//                       width: widget.tableWidth,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               checkBox(
//                                 id: widget.itemsId[index],
//                                 callback: widget.callback,
//                                 tableCallbac: () {
//                                   setState(() {});
//                                 },
//                               ),
//                               Row(
//                                 children: widget.titleItems.map((e) {
//                                   return Container(
//                                     margin: EdgeInsets.only(left: 15),
//                                     alignment: Alignment.centerRight,
//                                     width: e.titleWidth,
//                                     child: Text(
//                                       "${e.tableData[index]}",
//                                       style: TextStyle(),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             thickness: 1,
//                           ),
//                         ],
//                       ));
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }

// Widget table(
//     {required double tableHeight,
//     required double tableWidth,
//     required int rowCount,
//     required List itemsId,
//     required List<TableItemField> titleItems,
//      required VoidCallback callback}) {
//   return StatefulBuilder(builder: (context, setState) {
//     return Container(
//       color: Colors.white,
//       width: tableWidth,
//       height: tableHeight,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(right: 15),
//             height: tableHeight * 0.08,
//             width: tableWidth,
//             child: Row(
//               children: titleItems.map((e) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 22),
//                   alignment: Alignment.centerRight,
//                   width: e.titleWidth,
//                   child: Text(
//                     e.titleName,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           Divider(
//             thickness: 1,
//           ),
//           Container(
//             height: tableHeight * 0.8,
//             child: ListView.builder(
//                 itemCount: rowCount,
//                 itemBuilder: (ctx, index) {
//                   bool f = false;
//
//                   return Container(
//                       padding: EdgeInsets.only(right: 15),
//                       width: tableWidth,
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               checkBox(id: itemsId[index],callback:callback, tableCallbac: () { setState((){}); },),
//                               Row(
//                                 children: titleItems.map((e) {
//                                   return Container(
//                                     margin: EdgeInsets.only(left: 15),
//                                     alignment: Alignment.centerRight,
//                                     width: e.titleWidth,
//                                     child: Text(
//                                       "${e.tableData[index]}",
//                                       style: TextStyle(),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ],
//                           ),
//                           Divider(
//                             thickness: 1,
//                           ),
//                         ],
//                       ));
//                 }),
//           )
//         ],
//       ),
//     );
//   });
// }

Widget titleTabelItem({required double titleWidth}) {
  return Container();
}

class TableItemField {
  String titleName;
  double titleWidth;
  List tableData;
  List<int> id;

  TableItemField({
    required this.titleName,
    required this.titleWidth,
    required this.tableData,
    required this.id,
  });
}

savedetectedDataToremove(bool value, int id) {
  if (value == true) {
    detectedItems.add(id);
    print("id added$id");
  } else {
    detectedItems.removeWhere((element) => element == id);
    print("idAfter Removeing$id");
  }
}
