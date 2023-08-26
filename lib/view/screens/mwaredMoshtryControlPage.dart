import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:shader/controller/dataRepo.dart';
import 'package:shader/controller/dbController.dart';
import '../../../model/moshtry.dart';


import '../../../model/mwared.dart';
import '../widget/commonWidgit.dart';
import '../widget/tableWidget.dart';
class ffd extends StatefulWidget {
  const ffd({Key? key}) : super(key: key);

  @override
  State<ffd> createState() => _ffdState();
}

class _ffdState extends State<ffd> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MwaredMoshtryControlPage extends StatefulWidget {
  String type;

  MwaredMoshtryControlPage({required this.type});

  @override
  State<MwaredMoshtryControlPage> createState() =>
      _MwaredMoshtryControlPageState();
}

class _MwaredMoshtryControlPageState extends State<MwaredMoshtryControlPage> {
  final TextEditingController searchController = TextEditingController();

  searhfuncByname(
      String text, AsyncSnapshot<UnmodifiableListView<MwaredModel>> snap) {
    return snap.data!.where((element) => element.name.contains(text));
  }

  @override
  void initState() {
    widget.type == 'mwared'
        ? bloc.getData(TableNameAsWrittenInDB: 'mwared')
        : bloc.getData(TableNameAsWrittenInDB: 'moshtry');
    super.initState();
  }

  int? lenghtoftableDataForListView = 0;


  // List <TableItemField> _buildTableItemsDebenOnSearch(
  //     AsyncSnapshot <UnmodifiableListView<MwaredModel>> snap,
  //     TextEditingController searchController, double screenWidth) {
  //   if (searchController.text.isEmpty) {
  //     lenghtoftableDataForListView = snap.data!.length;
  //     return
  //       [ TableItemField(titleName: "الاسم",
  //           titleWidth: screenWidth * 0.15,
  //           tableData: snap.data!.map((e) => e.name).toList()),
  //         TableItemField(titleName: "رقم الهاتف",
  //             titleWidth: screenWidth * 0.15,
  //             tableData: snap.data!.map((e) => e.phonNumb).toList()),
  //         TableItemField(titleName: "العنوان",
  //             titleWidth: screenWidth * 0.2,
  //             tableData: snap.data!.map((e) => e.address).toList()),
  //         TableItemField(titleName: "ملاحظات",
  //             titleWidth: screenWidth * 0.2,
  //             tableData: snap.data!.map((e) => e.notice).toList()),
  //       ];
  //   } else {
  //     final data = snap.data!.where((element) =>
  //         element.name.contains(searchController.text));
  //     lenghtoftableDataForListView = data.length;
  //     return [
  //       TableItemField(titleName: "الاسم",
  //           titleWidth: screenWidth * 0.15,
  //           tableData: data.map((e) => e.name).toList()),
  //       TableItemField(titleName: "رقم الهاتف",
  //           titleWidth: screenWidth * 0.15,
  //           tableData: data.map((e) => e.phonNumb).toList()),
  //       TableItemField(titleName: "العنوان",
  //           titleWidth: screenWidth * 0.2,
  //           tableData: data.map((e) => e.address).toList()),
  //       TableItemField(titleName: "ملاحظات",
  //           titleWidth: screenWidth * 0.2,
  //           tableData: data.map((e) => e.notice).toList())
  //     ];
  //   }
  // }

  Widget searchbynameItems(
      AsyncSnapshot<UnmodifiableListView<MwaredModel>> snapShot,
      TextEditingController searchname,
      VoidCallback callBack) {
    final dataAfterSearch = snapShot.data!
        .where((element) => element.name.contains(searchname.text));

    searchname.text.isEmpty
        ? snapShot.data!.map((e) {
            return RowMwaredInTable(
              name: e.name,
              notice: "${e.notice}",
              phoneNumb: e.phonNumb,
              adress: e.address,
              id: e.id,
              voidCallBack: callBack,
            );
          })
        : dataAfterSearch.map((e) {
            return RowMwaredInTable(
              name: e.name,
              notice: "${e.notice}",
              phoneNumb: e.phonNumb,
              adress: e.address,
              id: e.id,
              voidCallBack: callBack,
            );
          });
    return Container();
  }

  late final dataAfterSearch;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final intialHight=screenHeight-appBarHeight-statusBar;
    return Scaffold(
      body: Container(
        color: Color(0xffeff3f2),
        width: double.infinity,
        height: double.infinity,
        child:widget.type=='mwared'?
        StreamBuilder<UnmodifiableListView<MwaredModel>>(
            stream: bloc.mwaredStream,
            initialData: UnmodifiableListView<MwaredModel>([]),
            builder: (context, mwaredsnapshot) {
              mwaredsnapshot.data;
              print("mwaredsnapshot${mwaredsnapshot.data!.length}");
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
                        Container(
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
                                        TableNameAsWrittenINDB: 'mwared',
                                        id: detectedItems)
                                    .then((value) async {
                                  if (value is int && value != 0) {
                                    detectedItems.clear();
                                    changeCheckBoxValueToFalse();
                                    print('detectedItems$detectedItems');
                                    // setState(() {});
                                    return snackBar(
                                        context: context, content: 'تم الحذف');
                                  } else {
                                    errDialog(
                                        context: context,
                                        err: value.toString());
                                  }
                                });
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
                                width: screenWidth * 0.15,
                                child: Text(
                                  "${'الاسم'}",
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerRight,
                                width: screenWidth * 0.15,
                                child: Text(
                                  "رقم الهاتف",
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerRight,
                                width: screenWidth * 0.2,
                                child: Text(
                                  "العنوان",
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerRight,
                                width: screenWidth * 0.2,
                                child: Text(
                                  "ملاحظات",
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.7,
                          child: getTableRows(
                              snapshot: mwaredsnapshot,
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
            }):
        StreamBuilder<UnmodifiableListView<MoshtryModel>>(
            stream: bloc.moshtryStream,
            initialData: UnmodifiableListView<MoshtryModel>([]),
            builder: (context, moshtrysnapshot) {
              // moshtrysnapshot.data;
              print("moshtrysnapshot${moshtrysnapshot.data!.length}");
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
                        Container(
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
                                    TableNameAsWrittenINDB: 'moshtry',
                                    id: detectedItems)
                                    .then((value) async {
                                  if (value is int && value != 0) {
                                    detectedItems.clear();
                                    changeCheckBoxValueToFalse();
                                    print('detectedItems$detectedItems');
                                    // setState(() {});
                                    return snackBar(
                                        context: context, content: 'تم الحذف');
                                  } else {
                                    errDialog(
                                        context: context,
                                        err: value.toString());
                                  }
                                });
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
                                width: screenWidth * 0.15,
                                child: Text(
                                  "${'الاسم'}",
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerRight,
                                width: screenWidth * 0.15,
                                child: Text(
                                  "رقم الهاتف",
                                  style: TextStyle(),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                alignment: Alignment.centerRight,
                                width: screenWidth * 0.2,
                                child: Text(
                                  "ملاحظات",
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.95,
                          height: screenHeight * 0.7,
                          child: getmoshtryTableRows(
                              snapshot: moshtrysnapshot,
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
            })

      ),
    );
  }

  Widget getTableRows(
      {required AsyncSnapshot<UnmodifiableListView<MwaredModel>> snapshot,
      required TextEditingController controller,
      required VoidCallback callback}) {
    final data = snapshot.data!
        .where((element) => element.name.contains(controller.text))
        .toList();

      if (controller.text.isEmpty) {
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RowMwaredInTable(
                name: snapshot.data![index].name,
                notice: "${snapshot.data![index].notice}",
                phoneNumb: snapshot.data![index].phonNumb,
                adress: snapshot.data![index].address,
                id: snapshot.data![index].id,
                voidCallBack: callback,
              );
            });
      } else {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return RowMwaredInTable(
                  name: data[index].name,
                  notice: "${data[index].notice}",
                  phoneNumb: data[index].phonNumb,
                  adress: data[index].address,
                  id: data[index].id,
                  voidCallBack: callback);
            });
      }


  }
  Widget getmoshtryTableRows(
      {required AsyncSnapshot<UnmodifiableListView<MoshtryModel>> snapshot,
        required TextEditingController controller,
        required VoidCallback callback}) {
    final data = snapshot.data!
        .where((element) => element.name.contains(controller.text))
        .toList();
      if (controller.text.isEmpty) {
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RowMoshtryInTable(
                name: snapshot.data![index].name,
                notice: "${snapshot.data![index].notice}",
                phoneNumb: snapshot.data![index].phonNumb,
                id: snapshot.data![index].id,
                voidCallBack: callback,
              );
            });
      } else {
        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return RowMoshtryInTable(
                  name: data[index].name,
                  notice: "${data[index].notice}",
                  phoneNumb: data[index].phonNumb,

                  id: data[index].id,
                  voidCallBack: callback);
            });
      }
  }
}
