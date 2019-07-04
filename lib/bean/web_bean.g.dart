// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebBean _$WebBeanFromJson(Map<String, dynamic> json) {
  return WebBean(
      json['status'] as int,
      json['code'] as int,
      json['msg'] as String,
      json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$WebBeanToJson(WebBean instance) => <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(json['url'] as String);
}

Map<String, dynamic> _$DataToJson(Data instance) =>
    <String, dynamic>{'url': instance.url};
