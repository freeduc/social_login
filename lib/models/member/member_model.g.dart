// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MemberModel _$$_MemberModelFromJson(Map<String, dynamic> json) =>
    _$_MemberModel(
      id: json['id'] as int?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      sidoCode: json['sidoCode'] as int?,
      sigunguCode: json['sigunguCode'] as int?,
      dongCode: json['dongCode'] as int?,
      email: json['email'] as String?,
      describeBook: json['describeBook'] as String?,
      autoLogin: json['autoLogin'] as String?,
      snsToken: json['snsToken'] as String?,
      snsType: json['snsType'] as String?,
      status: json['status'] as String?,
      role: json['role'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      orgId: json['organizationId'] as int?,
    );

Map<String, dynamic> _$$_MemberModelToJson(_$_MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'password': instance.password,
      'name': instance.name,
      'age': instance.age,
      'gender': instance.gender,
      'sidoCode': instance.sidoCode,
      'sigunguCode': instance.sigunguCode,
      'dongCode': instance.dongCode,
      'email': instance.email,
      'describeBook': instance.describeBook,
      'autoLogin': instance.autoLogin,
      'snsToken': instance.snsToken,
      'snsType': instance.snsType,
      'status': instance.status,
      'role': instance.role,
      'createDate': instance.createDate?.toIso8601String(),
      'updateDate': instance.updateDate?.toIso8601String(),
      'organizationId': instance.orgId,
    };
