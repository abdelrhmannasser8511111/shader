class MoshtryModel{
  int? id;
  String name;
  int? phonNumb;
  String? notice;
  MoshtryModel({this.id,required this.name,this.phonNumb,this.notice});
  factory MoshtryModel.fromJson(Map<String, dynamic> json) {
    return MoshtryModel(
        id: json['id'],
        name: json['name'],
        phonNumb:json["phonNumb"],
        notice:json["notice"]


    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    this.phonNumb !=null? data["phonNumb"]=this.phonNumb:null;
    this.notice !=null? data["notice"]=this.notice:null;

    return data;
  }
}