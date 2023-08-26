import 'dart:convert';
import 'dart:convert' as convert;

import 'package:shader/model/resala.dart';

class ResalaModel {
  int? resalaId;
  int mwaredId;
  String date;
  String nameofmwared;
  int catCount;
  String? resalaDescription;
  int totalCountOfBoxes;
  double TotalNetWeight;
  String? status; //open/close
  double nawloon;
  double amola;
  List<CattegoriesOfResala> ctegoriesDetails;

  ResalaModel({
    this.resalaId,
    required this.date,
    this.status,
    required this.nameofmwared,
    this.resalaDescription,
    required this.nawloon,
    required this.catCount,
    required this.ctegoriesDetails,
    required this.mwaredId,
    required this.totalCountOfBoxes,
    required this.TotalNetWeight,
    required this.amola,
  });


  factory ResalaModel.fromJson(Map<String, dynamic> json) {

  List<CattegoriesOfResala> f=[];
  (convert.json.decode(json['ctegoriesDetails']).forEach((var i) {
    print("iiii$i");
    print("iiii${CattegoriesOfResala.fromJson(i).catName}");
    f.add ( CattegoriesOfResala.fromJson(i)) ;
  }) ) ;
    return ResalaModel(
      resalaId: json['resalaId'],
      date: json['date'],
      status: json['status'],
      nameofmwared: json['nameofmwared'],
      resalaDescription: json['resalaDescription'],
      nawloon: json['nawloon'],
      catCount: json['catCount'],
      ctegoriesDetails:f ,

     // (json['ctegoriesDetails']).map((i)=>CattegoriesOfResala.fromJson(i)).toList() ,

      mwaredId: json['mwaredId'],
      totalCountOfBoxes: json['totalCountOfBoxes'],
      TotalNetWeight: json['TotalNetWeight'],
      amola: json['amola'],
    );
  }

  Map<String, dynamic> toJson() {
    
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['resalaId'] = this.resalaId;
    data['date'] = this.date;
    this.status !=null?  data['status'] = this.status:null;
    data['nameofmwared'] = this.nameofmwared;
    this.resalaDescription!=null? data["resalaDescription"]=this.resalaDescription:null;
    data['nawloon'] = this.nawloon;
    data['catCount'] = this.catCount;
    data['ctegoriesDetails'] = convert.json.encode(this.ctegoriesDetails.map((e) => e.toJson()).toList()) ;
    //( data['ctegoriesDetails'] = this.ctegoriesDetails.map((e) {e.catName;e.netWeight;)
    // }).toList().toString();
        // .map((v)=> v.toJson()).toList();
    data['mwaredId'] = this.mwaredId;
    data['totalCountOfBoxes'] = this.totalCountOfBoxes;
    data['TotalNetWeight'] = this.TotalNetWeight;
    data['amola']=this.amola;
    // print("mmmmmmmm ${this.ctegoriesDetails.map((e) => e.toJson()).toList().toString()}");
    return data;
  }
}

class CattegoriesOfResala {
  double netWeight;
  int count;
  String catName;
  String boxType;

  CattegoriesOfResala(
      {required this.netWeight,
      required this.count,
      required this.catName,
      required this.boxType});

  factory CattegoriesOfResala.fromJson(Map<String, dynamic> json) {
    // print("json['netWeight'] ${json['catName']}");
    return CattegoriesOfResala(
      netWeight: json["netWeight"],
      count: json["count"],
      catName:(json["catName"]),
      boxType: json["boxType"],
    );
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['netWeight'] = this.netWeight;
    data['count'] = this.count;
    data['catName'] = '${this.catName}';
    data['boxType'] = '${this.boxType}';
    // print("data of cat ${data}");
    return data;
   // print("ttttttttttttt ${{'netWeight':"${netWeight}",'count':"${count}",'catName':"${catName}",'boxType':"${boxType}"}}");
   // return {'netWeight':"${netWeight}",'count':"${count}",'catName':"${catName}",'boxType':"${boxType}"};
  }
}
