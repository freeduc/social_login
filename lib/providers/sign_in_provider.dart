import 'package:flutter/material.dart';
import 'package:social_login/data/repository/sign_repository.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/models/member/member_model.dart';


class SignInProvider extends ChangeNotifier {
  final SignRepository signRepo;

  SignInProvider({
    required this.signRepo,
  });

  // 로그인
  Future<ApiResponse> signIn(String phone, String password) async {
    // 입력 검증
    String? errorMsg;
    if (phone.isEmpty) {
      errorMsg = '아이디를 입력해주세요.';
    } else if (phone.length < 11) {
      errorMsg = '아이디 형식이 올바르지 않습니다.';
    } else if (password.isEmpty) {
      errorMsg = '비밀번호를 입력해주세요.';
    }

    if (errorMsg != null) {
      return ApiResponse.failed(msg: errorMsg);
    }

    MemberModel loginMember = MemberModel(phone: phone, password: password);

    return signRepo.login(loginMember);
  }

  // 카카오톡 로그인
  Future<ApiResponse> loginWithKakao() async {
    return signRepo.loginWithKakao();
  }

  //구글 로그인
  Future<bool> requestGoogleLogin() async {
    return false;
  }

  //네이버 로그인
  Future<bool> requestNaverLogin() async {
    return false;
  }

  //페이스북 로그인
  Future<bool> requestFaceBookLogin() async {
    return false;
  }

}