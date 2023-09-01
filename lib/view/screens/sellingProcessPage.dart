import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shader/controller/dbController.dart';
import 'package:shader/model/moshtry.dart';
import 'package:shader/model/resala.dart';

import '../../controller/dataRepo.dart';
import '../../controller/func.dart';
import '../../model/mwared.dart';
import '../../model/sellingData.dart';
import '../widget/commonWidgit.dart';
import '../widget/oprationsDialog.dart';

GlobalKey<FormState> _glopalKey = new GlobalKey<FormState>();

bool _autovalidate = false;
bool _returnValidateToDevault = false;

class SellingProcessPage extends StatefulWidget {
  const SellingProcessPage({Key? key}) : super(key: key);

  @override
  State<SellingProcessPage> createState() => _SellingProcessPageState();
}

class _SellingProcessPageState extends State<SellingProcessPage> {
  TextEditingController resalaNameController = TextEditingController();
  late TextEditingController amolaController;

  TextEditingController bwabaController = TextEditingController();
  TextEditingController moshtryNameController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController nolonController = TextEditingController();
  TextEditingController takenMoneyController = TextEditingController();
  TextEditingController remainingMoneyController = TextEditingController();
  TextEditingController noticeController = TextEditingController();

  bool checkboxCount1 = true;
  bool checkboxWeight2 = false;
  String? selectedValueInDropDpownM;

  @override
  void initState() {
    bloc.getData(TableNameAsWrittenInDB: 'resala');
    bloc.getData(TableNameAsWrittenInDB: 'moshtry');
    super.initState();
  }
  resetEntryData(){
    bwabaController.clear();
    moshtryNameController.clear();
    weightController.clear();
    countController.clear();
    priceController.clear();
    nolonController.clear();
    noticeController.clear();
    amolaController.clear();
    resalaNameController.clear();
    selectedValueInDropDpownM=null;
    choosenResala=null;
    // bloc.getData(TableNameAsWrittenInDB: 'sellingData');
  }

  ResalaModel? choosenResala;
  List<SellingDataModel> sellingProcessData = [];
  double resalaCurrentWeight = 0;
  int resalaCurrentBox = 0;
  double cattCurrentWeight = 0;
  int cattCurrentBox = 0;

  currentWeigtandboxInResal() {
    print("we do currentWeigtandboxInResal");
    double w = 0;
    int c = 0;
    for (int i = 0; i < sellingProcessData.length; i++) {
      w += sellingProcessData[i].weight;
      c += sellingProcessData[i].numbOfBox;
    }
    resalaCurrentWeight = choosenResala!.TotalNetWeight - w;
    resalaCurrentBox = choosenResala!.totalCountOfBoxes - c;
    return {"weight": resalaCurrentWeight, "numbOfBox": resalaCurrentBox};
  }

  currentWeigtandboxInCattInResal() {
    double w = 0;
    int c = 0;
    //
    final f = sellingProcessData.where(
        (element) => element.categoryFresala == selectedValueInDropDpownM).toList();
    print("we do currentWeigtandboxInResal");
    for (int i = 0; i < f.length; i++) {
      w += f[i].weight;
      c += f[i].numbOfBox;
    }
    cattCurrentBox=choosenResala!.ctegoriesDetails.firstWhere((element) => element.catName==selectedValueInDropDpownM).count-c;
  print("cattCurrentBox==${cattCurrentBox}");
    cattCurrentWeight=choosenResala!.ctegoriesDetails.firstWhere((element) => element.catName==selectedValueInDropDpownM).netWeight-w;
  }

  late double bwabaValue;
  late double amolaValue;
  late double totalMoneyBeforeAddinganyThing;
  late double totalMoneyAfterbwaba;

  List<FocusNode> focusList=List.generate(10, (index)=>FocusNode());

  @override
  Widget build(BuildContext context) {

    bwabaValue = checkboxWeight2 == true
        ? bwabaController.text.isNotEmpty && weightController.text.isNotEmpty
            ? double.parse(bwabaController.text) *
                double.parse(weightController.text)
            : 0
        : bwabaController.text.isNotEmpty && countController.text.isNotEmpty
            ? double.parse(bwabaController.text) *
                double.parse(countController.text)
            : 0;

    totalMoneyBeforeAddinganyThing = checkboxWeight2 == true
        ? priceController.text.isNotEmpty && weightController.text.isNotEmpty
            ? double.parse(priceController.text) *
                double.parse(weightController.text)
            : 0
        : priceController.text.isNotEmpty && countController.text.isNotEmpty
            ? double.parse(priceController.text) *
                double.parse(countController.text)
            : 0;
    amolaController = choosenResala == null
        ? TextEditingController()
        : TextEditingController(text: "${choosenResala!.amola}");
    print("totalMoneyBeforeAddinganyThing${totalMoneyBeforeAddinganyThing}");
    amolaValue = amolaController.text.isNotEmpty
        ? double.parse(((double.parse(amolaController.text) / 100) *
            totalMoneyBeforeAddinganyThing).toStringAsFixed(2))
        : 0;
    totalMoneyAfterbwaba = totalMoneyBeforeAddinganyThing + bwabaValue;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xffeff3f2),
        automaticallyImplyLeading: false,
        actions: [
          Container(
              padding: EdgeInsets.only(left: 25),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                  textDirection: TextDirection.ltr,
                  size: screenHeight * 0.04,
                ),
              ))
        ],
        title: Container(
          padding: EdgeInsets.only(right: 20),
          child: Text(
            "تسجيل عملية بيع",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffeff3f2),
        child: Column(
          children: [
            Form(
              key: _glopalKey,
              child: Container(
                margin: EdgeInsets.only(
                    left: screenWidth * 0.009,
                    right: screenWidth * 0.009,
                    top: screenWidth * 0.009),
                // color: Colors.white,
                height: screenHeight * 0.5,
                width: double.infinity,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          StreamBuilder<UnmodifiableListView<ResalaModel>>(

                              stream: bloc.resalaStream,
                              initialData:
                                  UnmodifiableListView<ResalaModel>([]),
                              builder: (context, resalanapshot) {
                                return Container(
                                  height: screenHeight * 0.4,
                                  padding: EdgeInsets.all(20),
                                  width: screenWidth * 0.47,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: screenHeight * 0.026,
                                        margin: EdgeInsets.only(
                                            bottom: screenHeight * 0.02),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.14,
                                              child: Text(
                                                "الرقم_التاريخ",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.012,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: screenWidth * 0.1,
                                            // ),
                                            Container(
                                              child: Text("${getCurrentDate()}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.012)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 0.038,
                                        margin: EdgeInsets.only(
                                            bottom: screenHeight * 0.012),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.14,
                                              child: Text(
                                                "الرساله",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.012,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            StreamBuilder<
                                                    UnmodifiableListView<
                                                        SellingDataModel>>(
                                                initialData:
                                                    UnmodifiableListView<
                                                        SellingDataModel>([]),
                                                stream: bloc.sellingDataStream,
                                                builder: (context,
                                                    sellingDatasnapshot) {
                                                  return Container(
                                                    width: screenWidth * 0.18,
                                                    height:
                                                        screenHeight * 0.042,
                                                    child: SearchField(
                                                      focusNode: focusList[0],
                                                      onSubmit: (v){
                                                        FocusScope.of(context).requestFocus(focusList[1]);
                                                      },
                                                      validator: (v) {
                                                        print("validate: ${v}");
                                                        if (resalanapshot.data!
                                                            .any((element) =>
                                                                element
                                                                    .nameofmwared ==
                                                                v)) {
                                                          return null;
                                                        } else {
                                                          return 'اختر رساله';
                                                        }
                                                      },
                                                      onSuggestionTap: (e) {
                                                        print(
                                                            "eeeeeeeeeeee $e");
                                                        selectedValueInDropDpownM =
                                                            null;
                                                        choosenResala = e.item
                                                            as ResalaModel?;
                                                        // print("choosenResala?.resalaId= ${choosenResala?.resalaId}");

                                                        // = resalanapshot
                                                        //     .data!
                                                        //     .firstWhere((element) =>
                                                        //         element
                                                        //             .nameofmwared ==
                                                        //         resalaNameController
                                                        //             .text);

                                                        sellingProcessData =
                                                            getSellingProcessOnResala(
                                                                sellindataSnap:
                                                                    sellingDatasnapshot,
                                                                resalaId:
                                                                    choosenResala!
                                                                        .resalaId!);
                                                        print("sellingProcessData= ${sellingProcessData}");
                                                        sellingProcessData
                                                                .isNotEmpty
                                                            ? currentWeigtandboxInResal()
                                                            : null;
                                                        print(
                                                            "resalaCurrentWeight $resalaCurrentWeight"
                                                            "   resalaCurrentBox$resalaCurrentBox");
                                                        setState(() {});
                                                      },
                                                      controller:
                                                          resalaNameController,
                                                      suggestions: resalanapshot
                                                          .data!
                                                          .map((e) =>
                                                              SearchFieldListItem(
                                                                  e.nameofmwared,
                                                                  item: e))
                                                          .toList(),
                                                      suggestionState:
                                                          Suggestion.expand,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      hint: 'اختيار الرساله',
                                                      searchStyle: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black,
                                                      ),
                                                      searchInputDecoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xff22a39f),
                                                          ),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ),
                                                      maxSuggestionsInViewPort:
                                                          9,
                                                      itemHeight:
                                                          screenHeight * 0.035,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 0.038,
                                        margin: EdgeInsets.only(
                                            bottom: screenHeight * 0.012),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.14,
                                              child: Text("العموله",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.012,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            // SizedBox(
                                            //   width: screenWidth * 0.05,
                                            // ),
                                            Container(
                                              width: screenWidth * 0.18,
                                              height: screenHeight * 0.042,
                                              child: TextFormField(
                                                readOnly: true,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) {
                                                    return 'ادخل قيمه صحيحه';
                                                  } else
                                                    return null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp('[0-9.]'))
                                                  //   FilteringTextInputFormatter.digitsOnly
                                                ],
                                                cursorColor: Color(0xff22a39f),
                                                controller: amolaController,
                                                // textAlign: TextAlign.left,
                                                onChanged: (v) {
                                                  setState(() {
                                                    amolaController;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  suffixIcon: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        Icons.percent,
                                                        color: Colors.black,
                                                        size:
                                                            screenWidth * 0.017,
                                                      )),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff22a39f),
                                                        width: 2.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff22a39f)),
                                                    // borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  hintText: 'العموله',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 0.058,
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: screenHeight * 0.012),
                                              width: screenWidth * 0.14,
                                              child: Text("الحساب",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.013,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 15),
                                              width: screenWidth * 0.09,
                                              // height: screenHeight * 0.042,
                                              child: CheckboxListTile(
                                                  activeColor:
                                                      Color(0xff22a39f),
                                                  value: checkboxCount1,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      value == true
                                                          ? checkboxWeight2 =
                                                              false
                                                          : checkboxWeight2 =
                                                              true;
                                                      checkboxCount1 = value!;
                                                    });
                                                  },
                                                  title: Text('عدد',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black))),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: screenHeight * 0.012),
                                              width: screenWidth * 0.09,
                                              // height: screenHeight * 0.042,
                                              child: CheckboxListTile(
                                                activeColor: Color(0xff22a39f),
                                                value: checkboxWeight2,
                                                onChanged: (value) {
                                                  setState(() {
                                                    value == true
                                                        ? checkboxCount1 = false
                                                        : checkboxCount1 = true;
                                                    checkboxWeight2 = value!;
                                                  });
                                                },
                                                title: Text(
                                                  'وزن',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: screenHeight * 0.038,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.14,
                                              child: Text("اختر الصنف",
                                                  style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.011,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            // SizedBox(
                                            //   width: screenWidth * 0.05,
                                            // ),
                                            Container(
                                                width: screenWidth * 0.18,
                                                height: screenHeight * 0.042,
                                                child: DropdownButtonFormField(
                                                  focusNode: focusList[1],
                                                  validator: (_) {
                                                    return selectedValueInDropDpownM ==
                                                            null
                                                        ? "اختر صنف "
                                                        : null;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusedBorder:
                                                        new UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff22a39f)),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Color(0xff22a39f),
                                                          width: 2),
                                                    ),
                                                  ),
                                                  // iconEnabledColor:  Color(0xff22a39f),

                                                  hint: Text("اختر صنف"),

                                                  value:
                                                      selectedValueInDropDpownM,
                                                  items: choosenResala
                                                      ?.ctegoriesDetails
                                                      .map((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value.catName,
                                                      child: Text(
                                                        value.catName,
                                                        style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.013,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newVal) {
                                                    setState(() {
                                                      selectedValueInDropDpownM =
                                                          newVal as String?;
                                                      currentWeigtandboxInCattInResal();
                                                    });


                                                    FocusScope.of(context).requestFocus(focusList[2]);

                                                  },
                                                ))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight * 0.01),
                                        padding: EdgeInsets.only(
                                            top: screenHeight * 0.01),
                                        height: screenHeight * 0.08,
                                        width: screenWidth * 0.32,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  spreadRadius: 1)
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      " رصيد برانيك كلي:",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    ),
                                                    Text(
                                                      choosenResala == null
                                                          ? "0"
                                                          : sellingProcessData
                                                          .isEmpty
                                                          ? '${choosenResala!.totalCountOfBoxes}'
                                                          : "${resalaCurrentBox}",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      " رصيد برانيك للصنف:",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    ),
                                                    Text(
                                                      choosenResala == null || selectedValueInDropDpownM == null
                                                          ? "0"
                                                          : "${cattCurrentBox}",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    )
                                                  ],
                                                ),

                                              ],
                                            ),
                                            Column(
                                              children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    " رصيد أوزان كلي :",
                                                    style: TextStyle(
                                                        fontSize:
                                                        screenWidth * 0.012),
                                                  ),
                                                  Text(
                                                    choosenResala == null
                                                        ? "0"
                                                        : sellingProcessData
                                                        .isEmpty
                                                        ? "${choosenResala!.TotalNetWeight}"
                                                        : "${resalaCurrentWeight}",
                                                    style: TextStyle(
                                                        fontSize:
                                                        screenWidth * 0.012),
                                                  )
                                                ],
                                              ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      " رصيد أوزان للصنف:",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    ),
                                                    Text(
                                                      choosenResala == null || selectedValueInDropDpownM == null
                                                          ? "0"
                                                          : "${cattCurrentWeight}",
                                                      style: TextStyle(
                                                          fontSize:
                                                          screenWidth * 0.012),
                                                    )

                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                          Container(
                            height: screenHeight * 0.39,
                            child: VerticalDivider(),
                          ),
                          StreamBuilder<UnmodifiableListView<MoshtryModel>>(
                              stream: bloc.moshtryStream,
                              initialData:
                                  UnmodifiableListView<MoshtryModel>([]),
                              builder: (context, moshtrySnapshot) {
                                return Container(
                                  height: screenHeight * 0.4,
                                  width: screenWidth * 0.45,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.11,
                                              child: Text(
                                                "اسم المشتري",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.012,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth * 0.21,
                                              height: screenHeight * 0.042,
                                              child: SearchField(
                                                focusNode: focusList[2],
                                                onSubmit: (v){
                                                  FocusScope.of(context).requestFocus(focusList[3]);
                                                },
                                                validator: (v) {
                                                  if (moshtrySnapshot.data!.any(
                                                      (element) =>
                                                          element.name == v)) {
                                                    return null;
                                                  } else {
                                                    return 'اختر مشتري';
                                                  }
                                                },
                                                controller:
                                                    moshtryNameController,
                                                suggestions: moshtrySnapshot
                                                    .data!
                                                    .map((e) =>
                                                        SearchFieldListItem(
                                                            e.name,
                                                            item: e))
                                                    .toList(),
                                                suggestionState:
                                                    Suggestion.expand,
                                                textInputAction:
                                                    TextInputAction.next,
                                                hint: 'اختيار المشتري',
                                                searchStyle: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                                searchInputDecoration:
                                                    InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xff22a39f),
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                maxSuggestionsInViewPort: 9,
                                                itemHeight:
                                                    screenHeight * 0.035,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              // height: screenHeight*0.03,
                                              // color: Color(0xff22a39f),

                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: IconButton(
                                                splashRadius: 25,
                                                icon: Icon(
                                                  Icons.add,
                                                  size: screenHeight * 0.03,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  AddUpdateMoshtryDialog(
                                                      context: context,
                                                      editTybe: 'add');
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: screenHeight * 0.008,
                                        ),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.05,
                                                  child: Text(
                                                    "العدد",
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.012,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.09,
                                                  height: screenHeight * 0.042,
                                                  child: TextFormField(
                                                    focusNode: focusList[3],
                                                    onFieldSubmitted: (v){
                                                      FocusScope.of(context).requestFocus(focusList[4]);
                                                    },
                                                    validator: (v) {
                                                      if (v == null ||
                                                          v.isEmpty) {
                                                        return 'ادخل قيمه صحيحه';
                                                      } else
                                                        return null;
                                                    },
                                                    onChanged: (V) {
                                                      setState(() {
                                                        countController;
                                                      });
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9]'))
                                                      //   FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    cursorColor:
                                                        Color(0xff22a39f),
                                                    controller: countController,
                                                    // textAlign: TextAlign.left,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f),
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f)),
                                                        // borderRadius: BorderRadius.circular(50)
                                                      ),
                                                      hintText: 'العدد',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.08,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.05,
                                                  child: Text(
                                                    "الوزن",
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.012,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.09,
                                                  height: screenHeight * 0.042,
                                                  child: TextFormField(
                                                    focusNode: focusList[4],
                                                    onFieldSubmitted: (v){
                                                      FocusScope.of(context).requestFocus(focusList[5]);
                                                    },
                                                    validator: (v) {
                                                      if (v == null ||
                                                          v.isEmpty) {
                                                        return 'ادخل قيمه صحيحه';
                                                      } else
                                                        return null;
                                                    },
                                                    onChanged: (V) {
                                                      setState(() {
                                                        weightController;
                                                      });
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9.]'))
                                                      //   FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    cursorColor:
                                                        Color(0xff22a39f),
                                                    controller:
                                                        weightController,
                                                    // textAlign: TextAlign.left,
                                                    onTap: () {},
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f),
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f)),
                                                        // borderRadius: BorderRadius.circular(50)
                                                      ),
                                                      hintText: 'الوزن',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: screenHeight * 0.008,
                                        ),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.05,
                                                  child: Text(
                                                    "السعر",
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.012,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.09,
                                                  height: screenHeight * 0.042,
                                                  child: TextFormField(
                                                    focusNode: focusList[5],
                                                    onFieldSubmitted: (v){
                                                      FocusScope.of(context).requestFocus(focusList[6]);
                                                    },
                                                    validator: (v) {
                                                      if (v == null ||
                                                          v.isEmpty) {
                                                        return 'ادخل قيمه صحيحه';
                                                      } else
                                                        return null;
                                                    },
                                                    onChanged: (V) {
                                                      setState(() {
                                                        priceController;
                                                      });
                                                    },
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                              RegExp('[0-9.]'))
                                                      //   FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    cursorColor:
                                                        Color(0xff22a39f),
                                                    controller: priceController,
                                                    // textAlign: TextAlign.left,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f),
                                                            width: 2.0),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff22a39f)),
                                                        // borderRadius: BorderRadius.circular(50)
                                                      ),
                                                      hintText: 'السعر',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.08,
                                            ),
                                            Container(
                                              height: screenHeight * 0.038,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: screenWidth * 0.05,
                                                    child: Text("البوابه",
                                                        style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.012,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  // SizedBox(
                                                  //   width: screenWidth * 0.05,
                                                  // ),
                                                  Container(
                                                    width: screenWidth * 0.09,
                                                    height:
                                                        screenHeight * 0.042,
                                                    child: TextFormField(
                                                      focusNode: focusList[6],
                                                      onFieldSubmitted: (v){
                                                        FocusScope.of(context).requestFocus(focusList[7]);
                                                      },
                                                      validator: (v) {
                                                        if (v == null ||
                                                            v.isEmpty) {
                                                          return 'ادخل قيمه صحيحه';
                                                        } else
                                                          return null;
                                                      },
                                                      onChanged: (V) {
                                                        setState(() {
                                                          bwabaController;
                                                        });
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                '[0-9.]'))
                                                        //   FilteringTextInputFormatter.digitsOnly
                                                      ],
                                                      cursorColor:
                                                          Color(0xff22a39f),
                                                      controller:
                                                          bwabaController,
                                                      // textAlign: TextAlign.left,
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff22a39f),
                                                              width: 2.0),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Color(
                                                                  0xff22a39f)),
                                                          // borderRadius: BorderRadius.circular(50)
                                                        ),
                                                        hintText:
                                                            'قيمة البوابه',
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Container(
                                      //   padding: EdgeInsets.only(
                                      //     bottom: screenHeight * 0.008,
                                      //   ),
                                      //   child: Row(
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           Container(
                                      //             width: screenWidth * 0.05,
                                      //             child: Text(
                                      //               "مبلغ التحصيل",
                                      //               style: TextStyle(
                                      //                   fontSize:
                                      //                       screenWidth * 0.012,
                                      //                   fontWeight:
                                      //                       FontWeight.w500),
                                      //             ),
                                      //           ),
                                      //           Container(
                                      //             width: screenWidth * 0.09,
                                      //             height: screenHeight * 0.042,
                                      //             child: TextFormField(
                                      //               validator: (v) {
                                      //                 if (v == null ||
                                      //                     v.isEmpty) {
                                      //                   return 'ادخل قيمه صحيحه';
                                      //                 } else
                                      //                   return null;
                                      //               },
                                      //               inputFormatters: [
                                      //                 FilteringTextInputFormatter
                                      //                     .allow(
                                      //                         RegExp('[0-9.]'))
                                      //                 //   FilteringTextInputFormatter.digitsOnly
                                      //               ],
                                      //               cursorColor:
                                      //                   Color(0xff22a39f),
                                      //               controller:
                                      //                   takenMoneyController,
                                      //               // textAlign: TextAlign.left,
                                      //               onChanged: (V){
                                      //                 setState(() {
                                      //                   takenMoneyController;
                                      //                 });
                                      //               },
                                      //               decoration: InputDecoration(
                                      //                 focusedBorder:
                                      //                     OutlineInputBorder(
                                      //                   borderSide: BorderSide(
                                      //                       color: Color(
                                      //                           0xff22a39f),
                                      //                       width: 2.0),
                                      //                 ),
                                      //                 border:
                                      //                     OutlineInputBorder(
                                      //                   borderSide: BorderSide(
                                      //                       color: Color(
                                      //                           0xff22a39f)),
                                      //                   // borderRadius: BorderRadius.circular(50)
                                      //                 ),
                                      //                 hintText: 'مبلغ التحصيل',
                                      //                 hintStyle: TextStyle(
                                      //                     color: Colors.grey),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      //       SizedBox(
                                      //         width: screenWidth * 0.08,
                                      //       ),
                                      //       Row(
                                      //         children: [
                                      //           Container(
                                      //             width: screenWidth * 0.05,
                                      //             child: Text(
                                      //               "الباقي",
                                      //               style: TextStyle(
                                      //                   fontSize:
                                      //                       screenWidth * 0.012,
                                      //                   fontWeight:
                                      //                       FontWeight.w500),
                                      //             ),
                                      //           ),
                                      //           Container(
                                      //             width: screenWidth * 0.09,
                                      //             height: screenHeight * 0.042,
                                      //             child: TextFormField(
                                      //               validator: (v) {
                                      //                 if (v == null ||
                                      //                     v.isEmpty) {
                                      //                   _returnValidateToDevault =
                                      //                       true;
                                      //                   return 'ادخل قيمه صحيحه';
                                      //                 } else
                                      //                   return null;
                                      //               },
                                      //
                                      //               inputFormatters: [
                                      //                 FilteringTextInputFormatter
                                      //                     .allow(
                                      //                         RegExp('[0-9.]'))
                                      //                 //   FilteringTextInputFormatter.digitsOnly
                                      //               ],
                                      //               cursorColor:
                                      //                   Color(0xff22a39f),
                                      //               controller:
                                      //                   remainingMoneyController,
                                      //               // textAlign: TextAlign.left,
                                      //               onTap: () {},
                                      //
                                      //               decoration: InputDecoration(
                                      //                 // errorText: ,
                                      //                 // errorBorder: UnderlineInputBorder(
                                      //                 //   borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                      //                 // ),
                                      //                 errorStyle: null,
                                      //                 //                       errorBorder:
                                      //                 // UnderlineInputBorder(
                                      //                 // borderSide: BorderSide(color: Colors.blue, width: 5.0),
                                      //                 // borderRadius: BorderRadius.circular(5),
                                      //                 // ),
                                      //                 focusedBorder:
                                      //                     OutlineInputBorder(
                                      //                   borderSide: BorderSide(
                                      //                       color: Color(
                                      //                           0xff22a39f),
                                      //                       width: 2.0),
                                      //                 ),
                                      //                 border:
                                      //                     OutlineInputBorder(
                                      //                   borderSide: BorderSide(
                                      //                       color: Color(
                                      //                           0xff22a39f)),
                                      //                   // borderRadius: BorderRadius.circular(50)
                                      //                 ),
                                      //                 hintText: 'الباقي',
                                      //                 hintStyle: TextStyle(
                                      //                     color: Colors.grey),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: screenWidth * 0.10,
                                              child: Text(
                                                "ملاحظات",
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.012,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Container(
                                              width: screenWidth * 0.26,
                                              height: screenHeight * 0.08,
                                              child: TextFormField(
                                                focusNode: focusList[7],
                                                onFieldSubmitted: (v){
                                                  FocusScope.of(context).requestFocus(focusList[8]);
                                                },
                                                // maxLines: 2,
                                                cursorColor: Color(0xff22a39f),
                                                controller: noticeController,
                                                // textAlign: TextAlign.left,
                                                onTap: () {},
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff22a39f),
                                                        width: 2.0),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff22a39f)),
                                                    // borderRadius: BorderRadius.circular(50)
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: screenWidth * 0.03),
                                        margin:
                                            EdgeInsets.all(screenHeight * 0.01),
                                        height: screenHeight * 0.04,
                                        width: screenWidth * 0.2,
                                        // padding:EdgeInsets.all(screenWidth*0.09),
                                        child: ElevatedButton(
                                          focusNode: focusList[8],

                                          child: Text("حفظ",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xff22a39f)),
                                          onPressed: () {
                                            if (_glopalKey.currentState!
                                                .validate()) {
                                             if(cattCurrentBox-int.parse(countController.text)>=0 && cattCurrentWeight - double.parse(weightController.text)>=0) {
                                                SqlHelper.createItem(
                                                        TableNameAsWrittenINDB:
                                                            'sellingData',
                                                        modelData: SellingDataModel(
                                                            bwabaValue:
                                                                bwabaValue,
                                                            calculationMethod:
                                                                checkboxCount1
                                                                    ? 'byCount'
                                                                    : 'byWeight',
                                                            customerName:
                                                                moshtryNameController
                                                                    .text,
                                                            date: getCurrentDate()
                                                                .toString(),
                                                            numbOfBox: int.parse(
                                                                countController
                                                                    .text),
                                                            resalaId: choosenResala!
                                                                .resalaId!,
                                                            resalName: choosenResala!
                                                                .nameofmwared,
                                                            sellingPrice:
                                                                double.parse(
                                                                    priceController
                                                                        .text),
                                                            totalAfterBwaba:
                                                            totalMoneyAfterbwaba,
                                                            weight: double.parse(
                                                                weightController.text),
                                                            categoryFresala: selectedValueInDropDpownM!,
                                                            amola: amolaValue))
                                                    .then((value) {
                                                  if (value is int &&
                                                      value != 0) {
                                                    snackBar(
                                                        context: context,
                                                        content:
                                                            'تم تسجيل عملية البيع');
                                                    resetEntryData();
                                                    setState(() {});
                                                    FocusScope.of(context).requestFocus(focusList[0]);
                                                  } else {
                                                    errDialog(
                                                        context: context,
                                                        err: '$value');
                                                  }
                                                });
                                              }else errDialog(context: context, err: "الكميه المطلوبه اكبر من المتاح!!");
                                            } else {
                                              Future.delayed(
                                                  Duration(milliseconds: 800),
                                                  () {
                                                setState(() {
                                                  _glopalKey = new GlobalKey<
                                                      FormState>();
                                                });
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: screenHeight * 0.013),
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: screenHeight * 0.08,
                          color: Color(0xff22a39f),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "إجمالي البضاعه :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${totalMoneyBeforeAddinganyThing}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "قيمة العمولة :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${amolaValue}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "قيمة البوابة :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$bwabaValue",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "الإجمالي الكلي بعد البوابة :",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.01,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$totalMoneyAfterbwaba",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenWidth * 0.013,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,

                  child:
                    DataTable(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      // border: TableBorder.all(width: 1),


                      sortColumnIndex: 0,

              columns: [
                    DataColumn(label: Text("اسم الرساله"), ),
                    DataColumn(label: Text("اسم المشتري")),
                    DataColumn(label: Text("العدد")),
                    DataColumn(label: Text("الوزن")),
                    DataColumn(label: Text("السعر")),
                DataColumn(label: Text("الصنف")),
                DataColumn(label: Text("العمولة")),
                    DataColumn(label: Text("البوابة")),
                    DataColumn(label: Text("الاجمالي بعد البوابة")),
                    DataColumn(label: Expanded(child: Text("ملاحظات عملية البيع"))),
              ],
              rows:sellingProcessData.isNotEmpty?

              sellingProcessData.map((e){
                      return DataRow(cells:[ DataCell(Text("${e.resalName}",)),
                        DataCell(Text("${e.customerName}",)),
                        DataCell(Text("${e.numbOfBox}",)),
                        DataCell(Text("${e.weight}",)),
                        DataCell(Text("${e.sellingPrice}",)),
                        DataCell(Text("${e.categoryFresala}",)),
                        DataCell(Text("${e.amola}",)),
                        DataCell(Text("${e.bwabaValue}",)),
                        DataCell(Text("${e.totalAfterBwaba}",)),
                        DataCell(Text("${e.notice}",)),

                      ]);
                    }).toList()


                    // DataRow(cells: sellingProcessData.map((e){
                    //   return DataCell(Text("${e.resalName}",));
                    // }).toList()),
                    // DataRow(cells: sellingProcessData.map((e){
                    //   return DataCell(Text("${e.customerName}"));
                    // }).toList())

              :[],
            ),

                ))
          ],
        ),
      ),
    );
  }
}
