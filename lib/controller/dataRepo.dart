import 'package:shader/controller/bloc.dart';

BloC bloc=BloC();

int mainOpenPageforSideBar=1;

List <int> detectedItems=[];
List<bool> checkBoxValue=[];
List<Map> categoriesTableDetails = [];

allDataGet()async{
  await bloc.getData(TableNameAsWrittenInDB: 'mwared');
  await bloc.getData(TableNameAsWrittenInDB: 'resala');
  await bloc.getData(TableNameAsWrittenInDB: 'moshtry');
  await bloc.getData(TableNameAsWrittenInDB: 'sellingData');
}
changeCheckBoxValueToFalse(){
  for(int i=0;i<checkBoxValue.length;i++){
    // checkBoxValue.replaceRange(0, checkBoxValue.length-1,[false]);
    checkBoxValue[i]=false;
  }
}
