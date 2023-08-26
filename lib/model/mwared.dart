class MwaredModel{
  int? id;
  String name;
  String? address;
  int? phonNumb;
  double? credit;
  String? notice;
  MwaredModel({ this.id,required this.name,this.address,this.credit,this.phonNumb,this.notice});
  factory MwaredModel.fromJson(Map<String, dynamic> json) {
    return MwaredModel(
         id: json['id'],
        name: json['name'],
        address: json['address'],
        credit: json['credit'],
        phonNumb:json["phonNumb"],
        notice:json["notice"]


    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    this.address !=null? data['address'] = this.address:null;
    this.credit !=null? data['credit'] = this.credit :null;
    this.phonNumb !=null?  data["phonNumb"]=this.phonNumb :null;
    this.notice !=null?  data["notice"]=this.notice : null;

    return data;
  }
}