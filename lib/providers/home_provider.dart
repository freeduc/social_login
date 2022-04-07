import 'package:flutter/material.dart';
import 'package:social_login/data/repository/member_repository.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/models/member/member_model.dart';
import 'package:social_login/resources/locator.dart';


class HomeProvider extends ChangeNotifier {
  final MemberRepository memberRepository;

  HomeProvider({required this.memberRepository});

  // 팝업광고 오늘 안보기
  bool notShowToday = false;

  void toggleNotShowToday() {
    notShowToday = !notShowToday;
    notifyListeners();
  }

  // [toggleNotShowToday]의 결과에 따라 팝업광고 처리
  void applyNotShowToday() {
    if (notShowToday) {
      preferences.setInt('timeToHidePopUp', DateTime.now().millisecondsSinceEpoch);
    }
  }

  // 로그인 사용자 정보 조회
  Future<MemberModel> getLoginMemberInfo() async {
    final String phone = preferences.getString('phone') ?? '';
    final ApiResponse response = await memberRepository.findByPhone(phone);

    return MemberModel.fromJson(response.data);
  }
}
