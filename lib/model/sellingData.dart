class SellingDataModel{
  int? sellingProcessId;
  String resalName;
  double? amola;
  String calculationMethod;
  double bwabaValue;
  double totalAfterBwaba;
  double sellingPrice;
  double? gettenMoney;
  double? remainningofTotalMoney;
  int numbOfBox;
  double weight;
  String customerName;
  String? date;
  int? resalaNumberForTheDay;
  int resalaId;
  String? notice;
  String categoryFresala;


  SellingDataModel({required this.amola,required this.bwabaValue,required this.calculationMethod,required this.customerName, this.date,this.gettenMoney,
  this.notice,required this.numbOfBox,this.remainningofTotalMoney,required this.resalaId,this.resalaNumberForTheDay,required this.resalName,
  required this.sellingPrice,this.sellingProcessId,required this.totalAfterBwaba,required this.weight,required this.categoryFresala});

  factory SellingDataModel.fromJson(Map<String, dynamic> json) {
    return SellingDataModel(
        resalName: json['resalName'],
        amola: json['amola'],
        calculationMethod: json['calculationMethod'],
        bwabaValue: json['bwabaValue'],
        totalAfterBwaba:json["totalAfterBwaba"],
        sellingPrice: json['sellingPrice'],
        gettenMoney: json['gettenMoney'],
        remainningofTotalMoney: json['remainningofTotalMoney'],
        numbOfBox: json['numbOfBox'],
        weight:json["weight"],
        customerName: json['customerName'],
        date: json['date'],
        resalaNumberForTheDay:json["resalaNumberForTheDay"],
        sellingProcessId: json['sellingProcessId'],
        resalaId: json['resalaId'],

        notice: json['notice'], categoryFresala: json['categoryFresala'],

    );

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['resalName'] = this.resalName;
    data['amola'] = this.amola;
    data['calculationMethod'] = this.calculationMethod;
    data['bwabaValue']=this.bwabaValue;
    data['totalAfterBwaba'] = this.totalAfterBwaba;
    data['sellingPrice'] = this.sellingPrice;
    this.gettenMoney !=null? data['gettenMoney'] = this.gettenMoney:null;
    this.remainningofTotalMoney != null? data['remainningofTotalMoney']=this.remainningofTotalMoney:null;
    data['numbOfBox'] = this.numbOfBox;
    data['weight'] = this.weight;
    data['customerName'] = this.customerName;
    this.date != null? data['date']=this.date:null;
    this.resalaNumberForTheDay !=null?  data['resalaNumberForTheDay'] = this.resalaNumberForTheDay:null;
    data['resalaId'] = this.resalaId;
    this.notice !=null? data['notice']=this.notice:null;
    data['categoryFresala']=this.categoryFresala;
    return data;
  }
}