import 'package:freezed_annotation/freezed_annotation.dart';

part 'member_model.freezed.dart';
part 'member_model.g.dart';

@freezed
class MemberModel with _$MemberModel {
  factory MemberModel({
    int? id,
    String? phone,
    String? password,
    String? name,
    int? age,
    String? gender,
    @JsonKey(name: 'sidoCode') int? sidoCode,
    @JsonKey(name: 'sigunguCode') int? sigunguCode,
    @JsonKey(name: 'dongCode') int? dongCode,
    String? email,
    @JsonKey(name: 'describeBook') String? describeBook,
    @JsonKey(name: 'autoLogin') String? autoLogin,
    @JsonKey(name: 'snsToken') String? snsToken,
    @JsonKey(name: 'snsType') String? snsType,
    String? status,
    String? role,
    @JsonKey(name: 'createDate') DateTime? createDate,
    @JsonKey(name: 'updateDate') DateTime? updateDate,
    @JsonKey(name: 'organizationId') int? orgId,
  }) = _MemberModel;

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);
}
