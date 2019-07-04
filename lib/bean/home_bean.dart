import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_bean.g.dart';


@JsonSerializable()
  class HomeBean  {

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  Data data;

  HomeBean(this.status,this.code,this.msg,this.data,);

  factory HomeBean.fromJson(Map<String, dynamic> srcJson) => _$HomeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeBeanToJson(this);

}

  
@JsonSerializable()
  class Data  {

  @JsonKey(name: 'banner')
  List<dynamic> banner;

  @JsonKey(name: 'product')
  List<Product> product;

  Data(this.banner,this.product,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

  
@JsonSerializable()
  class Product  {

  @JsonKey(name: 'product_id')
  int productId;

  @JsonKey(name: 'pic')
  String pic;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'apply_nums')
  int applyNums;

  @JsonKey(name: 'borrowing_balance_min')
  int borrowingBalanceMin;

  @JsonKey(name: 'borrowing_balance_max')
  int borrowingBalanceMax;

  @JsonKey(name: 'label')
  String label;

  Product(this.productId,this.pic,this.name,this.description,this.applyNums,this.borrowingBalanceMin,this.borrowingBalanceMax,this.label,);

  factory Product.fromJson(Map<String, dynamic> srcJson) => _$ProductFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

}

  
