// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBean _$HomeBeanFromJson(Map<String, dynamic> json) {
  return HomeBean(
      json['status'] as int,
      json['code'] as int,
      json['msg'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$HomeBeanToJson(HomeBean instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['banner'] as List,
      (json['product'] as List)
          ?.map((e) =>
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'banner': instance.banner, 'product': instance.product};

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['product_id'] as int,
      json['pic'] as String,
      json['name'] as String,
      json['description'] as String,
      json['apply_nums'] as int,
      json['borrowing_balance_min'] as int,
      json['borrowing_balance_max'] as int,
      json['label'] as String);
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'pic': instance.pic,
      'name': instance.name,
      'description': instance.description,
      'apply_nums': instance.applyNums,
      'borrowing_balance_min': instance.borrowingBalanceMin,
      'borrowing_balance_max': instance.borrowingBalanceMax,
      'label': instance.label
    };
