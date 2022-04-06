import 'package:social_login/data/apis/member_api.dart';
import 'package:social_login/models/common/api_response.dart';

class MemberRepository {
  final MemberApi memberApi;

  MemberRepository({required this.memberApi});

  Future<ApiResponse> findByPhone(String phone) async {
    return memberApi.findByPhone(phone);
  }
}
