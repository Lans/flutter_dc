import 'package:json_annotation/json_annotation.dart';

part 'web_bean.g.dart';

@JsonSerializable()
class WebBean {
  @JsonKey(name: 'status')
  final int status;

  @JsonKey(name: 'code')
  final int code;

  @JsonKey(name: 'msg')
  final String msg;

  @JsonKey(name: 'data')
  final Data data;

  WebBean(
    this.status,
    this.code,
    this.msg,
    this.data,
  );

  factory WebBean.fromJson(Map<String, dynamic> srcJson) =>
      _$WebBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WebBeanToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'url')
  final String url;

  Data(this.url);

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

//flutter pub run build_runner build
