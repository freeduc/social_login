import 'package:flutter/material.dart';
import 'package:social_login/data/repository/member_repository.dart';
import 'package:social_login/models/member/member_model.dart';

class GlobalProvider extends ChangeNotifier {
  final MemberRepository memberRepository;

  GlobalProvider({required this.memberRepository});

  // 사용자
  MemberModel member = MemberModel();

  // 사용자 정보 조회
  void setMember(MemberModel member) {
    this.member = member;
    notifyListeners();
  }
}
