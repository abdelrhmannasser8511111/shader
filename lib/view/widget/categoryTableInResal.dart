import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/dataRepo.dart';
import '../../model/resala.dart';

int cccccc = 0;

class CategoryTableInResala extends StatefulWidget {
  VoidCallback callBack;
  String editeTybe;
  List<CattegoriesOfResala>? cattegoriesOfResala;
  int? catCount;
  int index;


  CategoryTableInResala({
    Key? key,
    required this.callBack,
    this.cattegoriesOfResala,
    required this.editeTybe,
    this.catCount,
    required this.index,
  }) : super(key: key);


  @override
  State<CategoryTableInResala> createState() => _CategoryTableInResalaState();
}

int indxForUbdatedCategoryTableInResala = 0;

class _CategoryTableInResalaState extends State<CategoryTableInResala> {
  late final TextEditingController catNameController;
  late final TextEditingController boxNameController;
  late final TextEditingController netWeightController;
  late final TextEditingController countOfBoxesController;
  List<FocusNode> focusList=List.generate(4, (index)=>FocusNode());


  @override
  void initState() {
    catNameController = widget.editeTybe == 'add'
        ? TextEditingController()
        : TextEditingController(
            text: widget
                .cattegoriesOfResala![indxForUbdatedCategoryTableInResala]
                .catName);
    boxNameController = widget.editeTybe == 'add'
        ? TextEditingController()
        : TextEditingController(
            text: widget
                .cattegoriesOfResala![indxForUbdatedCategoryTableInResala]
                .boxType);
    netWeightController = widget.editeTybe == 'add'
        ? TextEditingController()
        : TextEditingController(
            text: widget
                .cattegoriesOfResala![indxForUbdatedCategoryTableInResala]
                .netWeight
                .toString());
    countOfBoxesController = widget.editeTybe == 'add'
        ? TextEditingController()
        : TextEditingController(
            text: widget
                .cattegoriesOfResala![indxForUbdatedCategoryTableInResala].count
                .toString());
    categoriesTableDetails.add({
      "catName": catNameController,
      "boxName": boxNameController,
      "netWeight": netWeightController,
      "countOfBoxes": countOfBoxesController,
    });
    widget.editeTybe != 'add'? indxForUbdatedCategoryTableInResala++:null;
    widget.catCount != null &&
            widget.catCount == indxForUbdatedCategoryTableInResala
        ? indxForUbdatedCategoryTableInResala = 0
        : null;
    print("cccccc= $cccccc");
    // print("categoriesTableDetails.length= ${categoriesTableDetails.length}");
    cccccc++;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("dublicated");

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // final appBarHeight =appBar.preferredSize.height;
    final statusBar = MediaQuery.of(context).padding.top;
    return Container(
      // key: Key(widget.index.toString()),

      margin: EdgeInsets.all(screenHeight * 0.003),
      height: screenHeight * 0.13,
      width: screenWidth * 0.09,
      decoration: BoxDecoration(boxShadow: [BoxShadow()], color: Colors.white),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: screenHeight * 0.003, top: screenHeight * 0.003),
            width: screenWidth * 0.085,
            height: screenHeight * 0.03,
            child: TextFormField(
              autofocus: true,
              focusNode: focusList[0],
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(focusList[1]);
              },
              style: TextStyle(fontSize: screenHeight * 0.014),
              cursorColor: Color(0xff22a39f),
              controller: catNameController,
              validator: (v) {
                int checkCatName=0;
                categoriesTableDetails.forEach((element) {
                  element['catName'].text == v ? checkCatName++ :null;
                  print("element['catName'].text= ${ element['catName'].text } $v");
                });
                if (v == null || v.isEmpty || checkCatName>=2) {

                  return 'ادخل قيمه صحيحه';
                } else
                  return null;
              },
              // textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: "اسم الصنف",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f), width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f)),
                  // borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.003,
            ),
            width: screenWidth * 0.085,
            height: screenHeight * 0.03,
            child: TextFormField(
              focusNode: focusList[1],
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(focusList[2]);
              },
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
              style: TextStyle(fontSize: screenHeight * 0.014),
              cursorColor: Color(0xff22a39f),
              controller: netWeightController,
              // textAlign: TextAlign.left,
              onChanged: (e) {

                widget.callBack();
              },
              decoration: const InputDecoration(
                labelText: "صافي الوزن",
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f), width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f)),
                  // borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.003,
            ),
            width: screenWidth * 0.085,
            height: screenHeight * 0.03,
            child: TextFormField(
              focusNode: focusList[2],
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(focusList[3]);
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                //   FilteringTextInputFormatter.digitsOnly
              ],
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'ادخل قيمه صحيحه';
                } else
                  return null;
              },
              style: TextStyle(fontSize: screenHeight * 0.014),
              cursorColor: Color(0xff22a39f),
              controller: countOfBoxesController,
              onChanged: (e) {
                widget.callBack();
              },
              // textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: "العدد",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f), width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f)),
                  // borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              bottom: screenHeight * 0.003,
            ),
            margin: EdgeInsets.only(
              bottom: screenHeight * 0.003,
            ),
            width: screenWidth * 0.085,
            height: screenHeight * 0.03,
            child: TextFormField(
              focusNode: focusList[3],
              onFieldSubmitted: (_){
                FocusScope.of(context).nearestScope;
              },
              style: TextStyle(fontSize: screenHeight * 0.014),
              cursorColor: Color(0xff22a39f),
              controller: boxNameController,
              onChanged: (e) {
                widget.callBack();
              },
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'ادخل قيمه صحيحه';
                } else
                  return null;
              },
              // textAlign: TextAlign.left,
              decoration: const InputDecoration(
                labelText: "اسم العبوه",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f), width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff22a39f)),
                  // borderRadius: BorderRadius.circular(50)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
