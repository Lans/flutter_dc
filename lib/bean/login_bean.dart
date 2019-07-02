import 'package:json_annotation/json_annotation.dart';

part 'login_bean.g.dart';

@JsonSerializable()
class LoginBean {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  Data data;

  LoginBean(
    this.status,
    this.code,
    this.msg,
    this.data,
  );

  factory LoginBean.fromJson(Map<String, dynamic> srcJson) =>
      _$LoginBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LoginBeanToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'truename')
  String truename;

  @JsonKey(name: 'identity_card')
  String identityCard;

  Data(
    this.userId,
    this.phone,
    this.truename,
    this.identityCard,
  );

  factory Data.fromJson(Map<String, dynamic> srcJson) =>
      _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
