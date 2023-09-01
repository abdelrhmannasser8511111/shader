import 'dart:collection';
import 'dart:typed_data';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:printing/printing.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shader/model/resala.dart';
import 'package:shader/model/sellingData.dart';
import 'package:shader/view/screens/pdfBillPage.dart';

import '../../controller/dataRepo.dart';
import '../../controller/dbController.dart';
import '../widget/commonWidgit.dart';
import '../widget/tableWidget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

GlobalKey<FormState> keyForlist = new GlobalKey<FormState>();

class BillsPage extends StatefulWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    bloc.getData(TableNameAsWrittenInDB: 'sellingData');
    super.initState();
  }

  ScrollController scrollconrol = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, DateTime initialDate) async {
    final dateRange = await showDateRangePicker(
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 55)),
      lastDate: DateTime.now(),
      builder: (context, child) {
        MaterialColor material = MaterialColorGenerator.from(Color(0xff22a39f));
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: material,
              primaryColorDark: Color(0xff22a39f),
              accentColor: Color(0xff22a39f),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 500,
                  width: 700,
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );

    if (dateRange != null) {
      print("Selected date range: ${dateRange}");
      setState(() {
        startDate = dateRange.start;
        endDate = dateRange.end;
      });
    }
  }

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
                      // detectedItems.clear();
                      // checkBoxValue.clear();
                      // print('detectedItems$detectedItems');
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
                        // width: screenWidth * 0.3,
                        margin: EdgeInsets.only(
                            bottom: 5,
                            right: screenWidth * 0.04,
                            top: screenHeight * 0.02),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Container(
                            //   child: Text("البحث من خلال الاسم :",
                            //       style: TextStyle(
                            //           fontSize: screenWidth * 0.014,
                            //           fontWeight: FontWeight.w400)),
                            // ),
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
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(4),
                            //   width: screenWidth * 0.1,
                            //   height: screenHeight * 0.04,
                            //   child: TextButton(
                            //       style: TextButton.styleFrom(
                            //         backgroundColor: Colors.grey,
                            //         padding: EdgeInsets.all(0),
                            //       ),
                            //       onPressed: () {
                            //         _selectDate(context, startDate);
                            //       },
                            //       child: Text(
                            //         "some text",
                            //         style: TextStyle(color: Colors.white),
                            //       ),
                            // ),),
                            InkWell(
                              onTap: () {
                                _selectDate(context, startDate);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Color(0xffeff3f2),
                                    boxShadow: [BoxShadow(color: Colors.black,blurRadius: 1)]),
                                width: screenWidth * 0.19,
                                height: screenHeight * 0.038,
                                child: Text(
                                  "من: ${intl.DateFormat('yyyy-MM-dd').format(startDate)} --- الى ${intl.DateFormat('yyyy-MM-dd').format(startDate)}",
                                  style: TextStyle(

                                      color: Colors.black,
                                      fontSize: screenWidth * 0.01),
                                ),
                              ),
                            ),
                          ],
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
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.12,
                              child: Text(
                                "${'اسم المشتري '}",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.12,
                              child: Text(
                                "تاريخ عملية الشراء",
                                style: TextStyle(),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              margin: EdgeInsets.only(left: 15),
                              alignment: Alignment.centerRight,
                              width: screenWidth * 0.06,
                            ),
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
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                            startDate: startDate,
                            endDate: endDate),

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

  Widget getTableRows({
    required AsyncSnapshot<UnmodifiableListView<SellingDataModel>> snapshot,
    required TextEditingController controller,
    required double screenHeight,
    required double screenWidth,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    //Name Filter
    final data = snapshot.data!
        .where((element) => element.customerName.contains(controller.text))
        .toList();

    //Date filter
    List listOfDays = List.generate(
        endDate.difference(startDate).inDays + 1,
        (index) => intl.DateFormat('yyyy-MM-dd')
            .format(startDate.add(Duration(days: index))));
    Map<String, List<SellingDataModel>> dateFilter = {};

    for (var day in listOfDays) {
      final d = data
          .where((element) =>
              element.date?.replaceAll(' ', '').split('–').first.toString() ==
              day.toString())
          .toList();
      d.isNotEmpty ? dateFilter.addAll({"$day": d}) : null;
    }

    print("listOfDays${dateFilter}");
    //////////////

    //customer selling process per day filter
    List<List<List<SellingDataModel>>> dataPerDay = [];

    for (var sellingDataIn1Day in (dateFilter.values.toList())) {
      List<List<SellingDataModel>> todayData =
          []; //List of List for customer sellimg process
      for (var element in sellingDataIn1Day) {
        List<SellingDataModel> similarData =
            []; //all selling rproocesing for the customer in 1 day
        if (todayData.any((elementt) => elementt.any(
                (elementt) => elementt.customerName == element.customerName)) !=
            true) {
          for (int i = 0; i < sellingDataIn1Day.length; i++) {
            if (element.customerName == sellingDataIn1Day[i].customerName) {
              similarData.add(sellingDataIn1Day[i]);
              // dateFilter.removeAt(i);
            }
          }
        }
        similarData.isNotEmpty ? todayData.add([...similarData]) : null;
        similarData.clear();
      }
      dataPerDay.addAll([
        [...todayData]
      ]);
      todayData.clear();
    }
    ;
    // dataPerDay.forEach((value) {
    //   value.forEach((element) {
    //     element.forEach((element) {
    //       print(",,,,,,,, ${element.customerName},,,,,,,,${element.date}");
    //     });
    //   });
    // });
    DateTime selectedDate = DateTime.now();

    List<List<SellingDataModel>> customerDataPerDay = [];

    //get data from 2d lists and put it in list
    for (var v in dataPerDay) {
      for (var customerData in v) {
        // print("customerData[0].customerName,${customerData[0].date}");
        customerDataPerDay.add(customerData);
      }
    }
    return ListView.builder(
      // key: _keyForlist,

      // print(",,,,,,,, ${'todayData[index][0].customerName'}");
      itemCount: customerDataPerDay.length,
      itemBuilder: (BuildContext context, int index) {
        // print(",,,,,,,, ${customerDataPerDay[index][0].date}");
        return InkWell(
          // key: UniqueKey(),
          onDoubleTap: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PdfBllPage()));
          },
          child: Container(
            color: Colors.white,
            height: screenHeight * 0.05,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: screenHeight * 0.04,
                  child: Row(
                    children: [
                      Container(
                        // height: screenHeight * 0.04,
                        margin: EdgeInsets.only(
                            left: 15, right: screenWidth * 0.03),
                        alignment: Alignment.centerRight,
                        width: screenWidth * 0.12,
                        child: Text(
                          customerDataPerDay[index][0].customerName,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerRight,
                        width: screenWidth * 0.12,
                        child: Text(
                          "${customerDataPerDay[index][0].date}",
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.centerRight,
                        width: screenWidth * 0.06,
                        child: Text(
                          "",
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 15),
                      //   alignment: Alignment.centerRight,
                      //   width: screenWidth * 0.06,
                      //   child: Text(
                      //     "${widget.sellingData.weight}",
                      //     style: TextStyle(overflow: TextOverflow.ellipsis),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  child: Divider(
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        );

        // return w[index];
      },
    );
    // } else {
    return Container();
    // return ListView.builder(
    //
    //     // key: _keyForlist,
    //     itemCount: data.length,
    //     itemBuilder: (context, index) {
    //       return RowSellingProcessInTable(
    //         voidCallBack: callback,
    //         sellingData: data[index],
    //         allSellingDataOnthisResala: snapshot.data!
    //             .where((element) => element.resalaId == data[index].resalaId)
    //             .toList(),
    //       );
    //     });
    // }
  }
}

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    return MaterialColor(color.value, <int, Color>{
      50: color.withOpacity(0.1),
      100: color.withOpacity(0.2),
      200: color.withOpacity(0.3),
      300: color.withOpacity(0.4),
      400: color.withOpacity(0.5),
      500: color.withOpacity(0.6),
      600: color.withOpacity(0.7),
      700: color.withOpacity(0.8),
      800: color.withOpacity(0.9),
      900: color.withOpacity(1.0),
    });
  }
}
