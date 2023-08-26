import 'dart:collection';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shader/controller/dbController.dart';
import 'package:shader/model/mwared.dart';
import 'package:shader/model/sellingData.dart';

import '../model/moshtry.dart';
import '../model/resala.dart';

class BloC {
  List<MoshtryModel> _moshtryData = [];
  List<MwaredModel> _mowaredData = [];
  List<ResalaModel> _resalaData = [];
  List<SellingDataModel> _sellingData = [];

  final _moshtryDataStream =
      new BehaviorSubject<UnmodifiableListView<MoshtryModel>>();
  final _mowaredDataStream =
      new BehaviorSubject<UnmodifiableListView<MwaredModel>>();
  final _resalaDataStream =
      new BehaviorSubject<UnmodifiableListView<ResalaModel>>();
  final _sellingDataStream =
      new BehaviorSubject<UnmodifiableListView<SellingDataModel>>();

  Stream<UnmodifiableListView<MoshtryModel>> get moshtryStream =>
      _moshtryDataStream.stream;

  Stream<UnmodifiableListView<MwaredModel>> get mwaredStream =>
      _mowaredDataStream.stream;

  Stream<UnmodifiableListView<ResalaModel>> get resalaStream =>
      _resalaDataStream.stream;


  Stream<UnmodifiableListView<SellingDataModel>> get sellingDataStream =>
      _sellingDataStream.stream;


  UnmodifiableListView<ResalaModel> get dataFromResalaSream=>_resalaDataStream.value;
  UnmodifiableListView<MoshtryModel> get dataFromMoshtryStream=>_moshtryDataStream.value;
  UnmodifiableListView<MwaredModel> get dataFromMwaredStream=> _mowaredDataStream.value;

  getData({required String TableNameAsWrittenInDB}) async {
    final data =
        await SqlHelper.getData(TableNameAsWrittenInDB: TableNameAsWrittenInDB);
    if (TableNameAsWrittenInDB == 'mwared') {
      _mowaredData.clear();
      data.map((e) => _mowaredData.add(MwaredModel.fromJson(e))).toList();
      print('mowaredData${_mowaredData.length}');
      _mowaredDataStream.add(UnmodifiableListView(_mowaredData));
    } else if (TableNameAsWrittenInDB == 'moshtry') {
      // data.forEach((key) =>moshtryData.add(MoshtryModel.fromJson(key)));
      _moshtryData.clear();
      data.map((e) => _moshtryData.add(MoshtryModel.fromJson(e))).toList();
      print('moshtryData${_moshtryData}');
      _moshtryDataStream.add(UnmodifiableListView(_moshtryData));
    } else if (TableNameAsWrittenInDB == 'resala') {
      // data.forEach((key) =>moshtryData.add(MoshtryModel.fromJson(key)));
      _resalaData.clear();
      data.map((e) => _resalaData.add(ResalaModel.fromJson(e))).toList();
      print('resalaData${_resalaData}');
      _resalaDataStream.add(UnmodifiableListView(_resalaData));
    } else if (TableNameAsWrittenInDB == 'sellingData') {
      // data.forEach((key) =>moshtryData.add(MoshtryModel.fromJson(key)));
      _sellingData.clear();
      data.map((e) => _sellingData.add(SellingDataModel.fromJson(e))).toList();
      print('sellingData${_sellingData}');
      _sellingDataStream.add(UnmodifiableListView(_sellingData));
    }
  }


}
