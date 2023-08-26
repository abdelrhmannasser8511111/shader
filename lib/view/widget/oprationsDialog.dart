import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shader/model/mwared.dart';

import '../../controller/dataRepo.dart';
import '../../controller/dbController.dart';
import '../../controller/func.dart';
import '../../model/moshtry.dart';
import '../../model/resala.dart';
import 'categoryTableInResal.dart';
import 'commonWidgit.dart';

List<String> items = [
  "Brazil",
  "Italia (Disabled)",
  "Tunisia",
  'Canada',
  "italy",
  "tsdhj",
  "dksjkjd",
  "Brazil",
];

GlobalKey<FormState> _resalaGlopalKey = new GlobalKey<FormState>();
 GlobalKey<FormState> _tableInResalaGlopalKey = new GlobalKey<FormState>();
Future ResalaDialog(
    {required BuildContext context,
    required String editTybe,
    ResalaModel? resalaDataForUpdate}) {

  final TextEditingController catCountController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${resalaDataForUpdate?.catCount}");
  ;
  final TextEditingController nawlonController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${resalaDataForUpdate?.nawloon}");

  final TextEditingController noticeController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(
          text: "${resalaDataForUpdate?.resalaDescription}");
  final TextEditingController nameController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${resalaDataForUpdate?.nameofmwared}");
  final TextEditingController amolaController=editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${resalaDataForUpdate?.amola}");
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  // final appBarHeight =appBar.preferredSize.height;
  final statusBar = MediaQuery.of(context).padding.top;
  int? mwaredId=editTybe == 'add'?null:resalaDataForUpdate!.mwaredId;
  double totalNetWeight =editTybe == 'add'? 0:resalaDataForUpdate!.TotalNetWeight;
  int totalCountBoxes =  editTybe =='add'? 0 :resalaDataForUpdate!.totalCountOfBoxes;

  List<FocusNode> focusList=List.generate(6, (index)=>FocusNode());
  getTotalCount() {
    double i = 0;
    int count = 0;
    categoriesTableDetails.map((e) {
      (e["netWeight"].text as String).isNotEmpty && e["netWeight"].text != null
          ? i += double.parse(e["netWeight"].text)
          : 0;
      (e["countOfBoxes"].text as String).isNotEmpty &&
              e["countOfBoxes"].text != null
          ? count += int.parse(e["countOfBoxes"].text)
          : 0;
    }
        // print("totalNetWeight= ${totalNetWeight}");
        ).toList();
    print("totalNetWeight= ${i}");
    totalNetWeight = i;
    totalCountBoxes = count;
  }


  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return Form(
            key: _resalaGlopalKey,
            child: AlertDialog(
              title: Column(
                children: [
                  Text(editTybe == 'add' ? "استلام رسالة  " : 'تعديل رساله',
                      style: TextStyle(fontSize: screenWidth * 0.015)),
                  Divider(
                    thickness: 1,
                    endIndent: 5,
                  )
                ],
              ),
              content: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Container(
                    height: screenHeight * 0.05,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("الرقم_التاريخ"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.1,
                        // ),
                        Container(
                          child: Text(editTybe == 'add'
                              ? "${getCurrentDate()}"
                              : "${resalaDataForUpdate!.date}"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          child: Text("اسم المورد"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        StreamBuilder<UnmodifiableListView<MwaredModel>>(
                            stream: bloc.mwaredStream,
                            initialData: UnmodifiableListView<MwaredModel>([]),
                            builder: (context, mwaredsnapshot) {
                              return Container(
                                width: screenWidth * 0.18,
                                height: screenHeight * 0.05,
                                child: SearchField(
                                  focusNode: focusList[0],
                                  onSubmit: (v){
                                    FocusScope.of(context).requestFocus(focusList[1]);
                                  },
                                  controller: nameController,
                                  suggestions: mwaredsnapshot.data!
                                      .map((e) => SearchFieldListItem(e.name))
                                      .toList(),
                                  onSuggestionTap: (s) {
                                    mwaredId = mwaredsnapshot.data!
                                        .firstWhere((element) =>
                                            element.name == nameController.text)
                                        .id!;
                                    print("mwaredId= ${mwaredId}");
                                  },
                                  validator: (v) {
                                    if (mwaredsnapshot.data!
                                        .any((element) =>
                                    element
                                        .name ==
                                        v)) {
                                      return null;
                                    } else {
                                      return 'اختر مورد';
                                    }
                                  },

                                  suggestionState: Suggestion.expand,
                                  textInputAction: TextInputAction.next,
                                  hint: 'ابحث عن المورد',
                                  searchStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  searchInputDecoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  maxSuggestionsInViewPort: 6,
                                  itemHeight: screenHeight * 0.07,
                                )

                                // TextField(
                                //   cursorColor: Color(0xff22a39f),
                                //   controller: nameController,
                                //   // textAlign: TextAlign.left,
                                //   onTap: (){
                                //   },
                                //   decoration: InputDecoration(
                                //      border: OutlineInputBorder(
                                //          borderSide: BorderSide(),
                                //          // borderRadius: BorderRadius.circular(50)
                                //      ),
                                //     hintText: 'ادخل اسم المورد',
                                //     hintStyle: TextStyle(color: Colors.grey),
                                //   ),
                                // )
                                ,
                              );
                            }),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Center(
                            child: IconButton(
                                onPressed: () async {
                                  await AddUpdatemwaredDialog(
                                      context: context, editTybe: 'add');
                                  setState(() {});
                                },
                                icon: Icon(Icons.add),
                                style: IconButton.styleFrom(
                                    backgroundColor: Color(0xff22a39f))))
                      ],
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.05,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("عدد الاصناف"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.05,
                          child: TextFormField(
                            // autofocus: true,
                            focusNode: focusList[1],
                            onFieldSubmitted: (v)=> FocusScope.of(context).requestFocus(focusList[2]),
                            cursorColor: Color(0xff22a39f),
                            controller: catCountController,
                            onChanged: (v) {

                              if (v.isEmpty) {
                                categoriesTableDetails.clear();
                                // list=List.filled(catCountController.text.isEmpty?0:int.parse(catCountController.text), []);


                              } else {
                                if(categoriesTableDetails.length>int.parse(catCountController.text)){
                                  categoriesTableDetails.removeRange(int.parse(catCountController.text), categoriesTableDetails.length);
                                  print("categoriesTableDetails= ${categoriesTableDetails.length}");
                                }

                              }
                              setState((){
                                getTotalCount();
                              });
                            },
                            // textAlign: TextAlign.left,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              LengthLimitingTextInputFormatter(1),
                              //   FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'ادخل قيمه صحيحه';
                              } else
                                return null;
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: 'عدد الاصناف',
                              hintStyle: TextStyle(color: Colors.grey),
                                                          ),
                          ),
                        )
                      ],
                    ),
                  ),
                  catCountController.text.isNotEmpty
                      ? Form(
                    key: _tableInResalaGlopalKey,
                        child: AnimatedContainer(
                    // key: _tableInResalaGlopalKey,
                    // key: new Key(1.toString()),

                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            padding: EdgeInsets.only(bottom: 10),
                            width: screenWidth * 0.3,
                            height: screenHeight * 0.18,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Color(0xff22a39f),
                                // spreadRadius: 2,
                              )
                            ], color: Color(0xffeff3f2)),
                            duration: Duration(seconds: 1),
                            child:

                           GridView(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                children:

                                editTybe=='add'?
                                List.generate(
                                    catCountController.text.isEmpty ? 0 : int.parse(catCountController.text),
                                    (v)=>v).map((e) {

                                  return
                                      CategoryTableInResala(

                                      callBack:  () {
                                            print("object");
                                            setState(() {
                                              getTotalCount();
                                            });
                                          }, editeTybe: 'add', index: e,
                                  );
                                }).toList():
                                List.generate(
                                    catCountController.text.isEmpty ? 0 : int.parse(catCountController.text),
                                        (v)=>v).map((e) {

                                  return
                                    CategoryTableInResala(

                                      catCount:resalaDataForUpdate!.catCount,
                                      cattegoriesOfResala: resalaDataForUpdate.ctegoriesDetails,
                                      callBack:  () {
                                        print("object");
                                        setState(() {
                                          getTotalCount();
                                        });
                                      }, editeTybe: 'update', index: e,
                                    );
                                }).toList()


                                // List.generate(
                                //
                                //     int.parse(catCountController.text),
                                //     (index) {
                                //
                                //       return CategoryTableInResala(
                                //         callBack: () {
                                //           print("object");
                                //           setState(() {
                                //             getTotalCount();
                                //           });
                                //         },
                                //       );
                                //     },growable:false)

                                // int.parse(catCountController.text )CategoryTableInResala()

                                ),
                            ),
                      )
                      : Container(),
                  Container(
                    height: screenHeight * 0.05,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
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
                          height: screenHeight * 0.05,

                          child: TextFormField(
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'ادخل قيمه صحيحه';
                              } else
                                return null;
                            },
                            focusNode: focusList[2],
                            onFieldSubmitted: (v)=> FocusScope.of(context).requestFocus(focusList[3]),
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .allow(RegExp('[0-9.]'))
                              //   FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Color(0xff22a39f),
                            controller: amolaController,
                            // textAlign: TextAlign.left,
                            // onChanged: (v){
                            //   setState(() {
                            //     amolaController;
                            //   });
                            //
                            // },
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
                    height: screenHeight * 0.05,
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("النولون"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.05,
                          child: TextFormField(
                            controller: nawlonController,
                            focusNode: focusList[3],
                            onFieldSubmitted: (v)=> FocusScope.of(context).requestFocus(focusList[4]),
                            // autofocus: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                              //   FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'ادخل قيمه صحيحه';
                              } else
                                return null;
                            },
                            cursorColor: Color(0xff22a39f),

                            // textAlign: TextAlign.left,

                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: 'النولون',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("وصف الرساله"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          child: TextFormField(

                            focusNode: focusList[4],
                            onFieldSubmitted: (v) {
                              print("onFieldSubmitted ${v}");
                              FocusScope.of(context).requestFocus(focusList[5]);
                            },
                            maxLines: 3,

                            cursorColor: Color(0xff22a39f),
                            controller: noticeController,
                            // textAlign: TextAlign.left,
                            decoration: const InputDecoration(

                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: 'وصف الرساله',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // height: screenHeight * 0.05,
                    margin: EdgeInsets.only(top:catCountController.text.isEmpty? screenHeight * 0.05:0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow()], color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(" الوزن الكلي:  ${totalNetWeight} "),
                        Text(" العدد الكلي: ${totalCountBoxes} "),
                      ],
                    ),
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      categoriesTableDetails.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("الغاء", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff22a39f))),
                ElevatedButton(
                    onPressed: () async {
                      // print("testController${categoriesTableDetails.map((e) {
                      //   {
                      //     return {
                      //       e["catName"].text,
                      //       e["boxName"].text,
                      //       e["netWeight"].text,
                      //       e["countOfBoxes"].text,
                      //     };
                      //   }
                      // })}");
                      // "catName": catName,
                      //                                 "boxName": boxName,
                      //                                 "netWeight": netWeight,
                      //                                 "countOfBoxes": countOfBoxes,
                      //
                      //                                 "index": index,
                      if(_resalaGlopalKey.currentState!.validate() && _tableInResalaGlopalKey.currentState!.validate()){
                      if (editTybe == 'add') {
                        await SqlHelper.createItem(
                            TableNameAsWrittenINDB: 'resala',
                            modelData: ResalaModel(
                              date: getCurrentDate().toString(),
                              resalaDescription: noticeController.text,
                              nameofmwared: nameController.text,
                              nawloon: double.parse(nawlonController.text),
                              catCount: int.tryParse(catCountController.text)!,
                              ctegoriesDetails: categoriesTableDetails
                                  .map((e) => CattegoriesOfResala(
                                        netWeight:
                                            double.tryParse(e["netWeight"].text)!,
                                        count: int.parse(e["countOfBoxes"].text),
                                        catName: e["catName"].text,
                                        boxType: e["boxName"].text,
                                      ))
                                  .toList(),
                              mwaredId: mwaredId!,
                              totalCountOfBoxes: totalCountBoxes,
                              TotalNetWeight: totalNetWeight, amola: double.parse(amolaController.text),
                            )).then((value) {
                          if (value is int) {
                            categoriesTableDetails.clear();
                            Navigator.of(context).pop();
                            return snackBar(
                                context: context, content: 'تمت العمليه بنجاح');
                          } else {
                            errDialog(context: context, err: value.toString());
                          }
                        });
                      }
                      else if (editTybe == 'update') {
                        SqlHelper.updateItem(
                          TableNameAsWrittenINDB: 'resala',
                          modelData: ResalaModel(
                            date: resalaDataForUpdate!.date,
                            resalaDescription: noticeController.text,
                            nameofmwared: nameController.text,
                            nawloon: double.parse(nawlonController.text),
                            catCount: int.tryParse(catCountController.text)!,
                            ctegoriesDetails: categoriesTableDetails
                                .map((e) => CattegoriesOfResala(
                              netWeight:
                              double.tryParse(e["netWeight"].text)!,
                              count: int.parse(e["countOfBoxes"].text),
                              catName: e["catName"].text,
                              boxType: e["boxName"].text,
                            ))
                                .toList(),
                            mwaredId: mwaredId!,
                            totalCountOfBoxes: totalCountBoxes,
                            TotalNetWeight: totalNetWeight,
                            amola: double.parse(amolaController.text),
                          ),
                          id: resalaDataForUpdate.resalaId!,
                          context: context,
                        );

                      }
                      else
                        null;
                    }else{
                        Future.delayed(
                            Duration(milliseconds: 1000),
                                () {
                              setState(() {

                                _resalaGlopalKey=GlobalKey<FormState>();
                                _tableInResalaGlopalKey.currentState!.save();
                                _tableInResalaGlopalKey.currentState!.reset();

                              });
                            });
                      }

                      },
                    focusNode: focusList[5],

                    child: Text(editTybe == 'add' ? "حفظ" : 'حفظ التعديل',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff22a39f))),
              ],
            ),
          );
        });
      });
}

AddUpdateMoshtryDialog(
    {required BuildContext context,
    required String editTybe,
    MoshtryModel? moshtryDataForUpdate}) {
  bool _namevalidate = false, phoneNumbValidate = false;
  final TextEditingController phonenumbController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: moshtryDataForUpdate?.phonNumb==null?'':moshtryDataForUpdate?.phonNumb.toString());
  final TextEditingController noticeController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${moshtryDataForUpdate?.notice}");
  final TextEditingController nameController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${moshtryDataForUpdate?.name}");

  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  // final appBarHeight =appBar.preferredSize.height;
  final statusBar = MediaQuery.of(context).padding.top;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              children: [
                Text(editTybe == 'add' ? "تسجيل مشتري  " : "تعديل مشتري  ",
                    style: TextStyle(fontSize: screenWidth * 0.015)),
                Divider(
                  thickness: 1,
                  endIndent: 5,
                )
              ],
            ),
            content: Container(
              height: screenHeight * 0.35,
              child: Focus(
                autofocus: true,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: Text("اسم المشتري"),
                          ),
                          // SizedBox(
                          //   width: screenWidth * 0.05,
                          // ),
                          Container(
                            width: screenWidth * 0.18,
                            height: screenHeight * 0.05,
                            child: TextField(
                              cursorColor: Color(0xff22a39f),
                              controller: nameController,
                              // textAlign: TextAlign.left,
                              onTap: () {
                                setState(() {
                                  _namevalidate = false;
                                });
                              },
                              decoration: InputDecoration(
                                errorText:
                                    !_namevalidate ? null : "ادخل اسم صحيح",
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff22a39f), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22a39f)),
                                  // borderRadius: BorderRadius.circular(50)
                                ),
                                hintText: 'اسم المشتري',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: Text("رقم الهاتف"),
                          ),
                          // SizedBox(
                          //   width: screenWidth * 0.05,
                          // ),
                          Container(
                            width: screenWidth * 0.18,
                            height: screenHeight * 0.05,
                            child: TextField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                                //   FilteringTextInputFormatter.digitsOnly
                              ],
                              cursorColor: Color(0xff22a39f),
                              controller: phonenumbController,
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
                                hintText: 'رقم الهاتف',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            child: Text("ملاحظات ع المشتري"),
                          ),
                          // SizedBox(
                          //   width: screenWidth * 0.05,
                          // ),
                          Container(
                            width: screenWidth * 0.18,
                            child: TextField(
                              maxLines: 5,
                              cursorColor: Color(0xff22a39f),
                              controller: noticeController,
                              // textAlign: TextAlign.left,
                              onTap: () {},
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xff22a39f), width: 2.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xff22a39f)),
                                  // borderRadius: BorderRadius.circular(50)
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("الغاء", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff22a39f))),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      nameController.text.isEmpty
                          ? _namevalidate = true
                          : _namevalidate = false;
                    });

                    // final moshtryData=await bloc.dataFromMoshtryStream;
                    // int countToCheckWhenUpdate=0;
                    // for (var element in moshtryData) {
                    //   element.name == nameController.text?countToCheckWhenUpdate++:null;
                    // }
                    if (_namevalidate == false && editTybe == 'add') {
                      // if(moshtryData.any((element) => element.name==nameController.text)==false) {
                        SqlHelper.createItem(
                                TableNameAsWrittenINDB: 'moshtry',
                                modelData: MoshtryModel(
                                    name: nameController.text,
                                    phonNumb: phonenumbController.text.isEmpty
                                        ? null
                                        : int.parse(phonenumbController.text),
                                    notice: noticeController.text))
                            .then((value) {
                          if (value is int) {
                            Navigator.of(context).pop();
                            return snackBar(
                                context: context, content: 'تمت العمليه بنجاح');
                          } else {
                            errDialog(context: context, err: "هذا المشتري موجود بالفعل !!");
                          }
                        });
                      // }else errDialog(context: context, err: "هذا المشتري موجود بالفعل !!");
                    } else if (_namevalidate == false && editTybe == 'update') {
                      // if(countToCheckWhenUpdate<=1)  {
                        SqlHelper.updateItem(
                          TableNameAsWrittenINDB: 'moshtry',
                          modelData: MoshtryModel(
                            name: nameController.text,
                            phonNumb: phonenumbController.text.isEmpty
                                ? null
                                : int.parse(phonenumbController.text),
                            notice: noticeController.text,
                          ),
                          context: context,
                          id: moshtryDataForUpdate!.id!,
                        );
                      // }else errDialog(context: context, err: "هذا المشتري موجود بالفعل !!");
                    } else
                      return null;
                  },
                  child: Text(editTybe == 'add' ? "حفظ" : "حفظ التعديل",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff22a39f))),
            ],
          );
        });
      });
}

AddUpdatemwaredDialog(
    {required BuildContext context,
    required String editTybe,
    MwaredModel? mwaredDataForUpdate}) {
  bool _namevalidate = false, phoneNumbValidate = false;
  final TextEditingController phonenumbController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${mwaredDataForUpdate?.phonNumb !=null?mwaredDataForUpdate?.phonNumb:''}");
  final TextEditingController noticeController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${mwaredDataForUpdate?.notice}");
  final TextEditingController nameController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${mwaredDataForUpdate?.name}");
  final TextEditingController adressController = editTybe == 'add'
      ? TextEditingController()
      : TextEditingController(text: "${mwaredDataForUpdate?.address}");

  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  // final appBarHeight =appBar.preferredSize.height;
  final statusBar = MediaQuery.of(context).padding.top;
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Column(
              children: [
                Text(editTybe == 'add' ? "تسجيل مورد " : "تعديل مورد ",
                    style: TextStyle(fontSize: screenWidth * 0.015)),
                Divider(
                  thickness: 1,
                  endIndent: 5,
                )
              ],
            ),
            content: Container(
              height: screenHeight * 0.47,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("اسم المورد"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.05,
                          child: TextField(
                            cursorColor: Color(0xff22a39f),
                            controller: nameController,
                            // textAlign: TextAlign.left,
                            onTap: () {
                              setState(() {
                                _namevalidate = false;
                              });
                            },
                            decoration: InputDecoration(
                              errorText:
                                  !_namevalidate ? null : "ادخل اسم صحيح",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: 'اسم المورد',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("رقم الهاتف"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          height: screenHeight * 0.05,
                          child: TextField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                              //   FilteringTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Color(0xff22a39f),
                            controller: phonenumbController,
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
                              hintText: 'رقم الهاتف',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("العنوان"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          child: TextField(
                            maxLines: 2,
                            cursorColor: Color(0xff22a39f),
                            controller: adressController,
                            // textAlign: TextAlign.left,
                            onTap: () {},
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintText: "العنوان",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          child: Text("ملاحظات ع المورد"),
                        ),
                        // SizedBox(
                        //   width: screenWidth * 0.05,
                        // ),
                        Container(
                          width: screenWidth * 0.18,
                          child: TextField(
                            maxLines: 5,
                            cursorColor: Color(0xff22a39f),
                            controller: noticeController,
                            // textAlign: TextAlign.left,
                            onTap: () {},
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xff22a39f), width: 2.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff22a39f)),
                                // borderRadius: BorderRadius.circular(50)
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("الغاء", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff22a39f))),
              ElevatedButton(
                  onPressed: ()async {
                    setState(() {
                      nameController.text.isEmpty
                          ? _namevalidate = true
                          : _namevalidate = false;
                    });
                    final mwaredAllData=await bloc.dataFromMwaredStream;

                      if (_namevalidate == false && editTybe == 'add') {
                        // if(mwaredAllData.any((element) => element.name==nameController.text)==false){
                        SqlHelper.createItem(
                            TableNameAsWrittenINDB: 'mwared',
                            modelData: MwaredModel(
                              name: nameController.text,
                              phonNumb: phonenumbController.text.isEmpty
                                  ? null
                                  : int.parse(phonenumbController.text),
                              notice: noticeController.text,
                              address: adressController.text,
                            )).then((value) async {
                          if (value is int) {
                            Navigator.of(context).pop();
                            return snackBar(
                                context: context, content: 'تمت العمليه بنجاح');
                          } else {
                            errDialog(context: context, err:"هذا المورد موجود بالفعل !!" );
                          }
                        });
                      // }else errDialog(context: context, err: "هذا المورد موجود بالفعل !!");
                    } else if (_namevalidate == false &&
                          editTybe == 'update') {
                        SqlHelper.updateItem(
                          TableNameAsWrittenINDB: 'mwared',
                          modelData: MwaredModel(
                            name: nameController.text,
                            phonNumb: phonenumbController.text.isEmpty
                                ? null
                                : int.parse(phonenumbController.text),
                            notice: noticeController.text,
                            address: adressController.text,
                          ),
                          context: context,
                          id: mwaredDataForUpdate!.id!,
                        );
                      } else
                        return null;

                  },
                  child: Text(editTybe == 'add' ? "حفظ" : "حفظ التعديل",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff22a39f))),
            ],
          );
        });
      });
}
