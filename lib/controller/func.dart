import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shader/model/sellingData.dart';

getCurrentDate() {
  return DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
}

getSellingProcessOnResala({required AsyncSnapshot<UnmodifiableListView<SellingDataModel>> sellindataSnap,required int resalaId}){
  final sellingProcess = sellindataSnap.data!.where((element) {
    print("element.resalaId=${element.resalaId}  resalaId=${element.resalaId}");
  return  element.resalaId == resalaId;
  }).toList();
print("sellingProcess${sellingProcess}");
  return sellingProcess;
}