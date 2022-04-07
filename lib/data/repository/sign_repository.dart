import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:social_login/data/apis/sign_api.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/models/member/member_model.dart';
import 'package:social_login/resources/locator.dart';

class SignRepository {
  final SignApi signApi;

  SignRepository({
    required this.signApi,
  });

  // 회원가입
  Future<ApiResponse> register(Map<String, String> params) async {
    try {
      return signApi.signUp(params);
    } catch (e) {
      print(e);
      return ApiResponse.failed(msg: '가입정보가 올바르지 않습니다.');
    }
  }

  // 로그인
  Future<ApiResponse> login(MemberModel member) async {
    try {
      // 입력된 휴대폰번호, 패스워드가 없으면 예외 처리
      final String phone = member.phone!;
      final String password = member.password!;

      final ApiResponse response = await signApi.signIn(phone, password);

      if (response.success) {
        // 토큰 저장
        await preferences.setString(
            'accessToken', response.data['accessToken']);
        await preferences.setString(
            'refreshToken', response.data['refreshToken']);

        // 아이디, 비밀번호 저장된게 없으면 새로 저장
        await preferences.setString('phone', phone);
        await preferences.setString('password', password);

        return ApiResponse.success();
      } else {
        return ApiResponse.failed(code: response.code, msg: response.msg);
      }
    } catch (e) {
      print(e);
      return ApiResponse.failed(msg: '아이디 또는 비밀번호를 올바르게 입력해주세요.');
    }
  }

  // 자동로그인
  Future<ApiResponse> autoLogin() async {
    try {
      // 아이디, 비밀번호 저장된게 없으면 예외 처리
      String phone = preferences.getString('phone')!;
      String password = preferences.getString('password')!;

      MemberModel loginMember = MemberModel(phone: phone, password: password);

      return login(loginMember);
    } catch (e) {
      print(e);
      return ApiResponse.failed(msg: '자동로그인 정보가 없습니다.');
    }
  }

  // 카카오톡 로그인
  Future<ApiResponse> loginWithKakao() async {
    // 카카오톡 설치 여부 확인
    final bool isKaKaoInstalled = await isKakaoTalkInstalled();

    bool isSuccess = false;
    String errorMsg = '';

    // 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (isKaKaoInstalled) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        isSuccess = true;
      } catch (error) {
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          errorMsg = '로그인하려면 권한이 필요합니다.';
        } else {
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
          try {
            await UserApi.instance.loginWithKakaoAccount();
            isSuccess = true;
          } catch (error) {
            errorMsg = '카카오계정 로그인에 실패했습니다.';

            print('카카오계정으로 로그인 실패 $error');
          }
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        isSuccess = true;
      } catch (error) {
        errorMsg = '카카오계정 로그인에 실패했습니다.';
        print('카카오계정으로 로그인 실패 $error');
      }
    }

    // 로그인 성공 시 정보 저장
    if (isSuccess) {
      await preferences.setString('isSnsMember', 'Y');
      await preferences.setString('snsType', 'kakao');
    }

    return ApiResponse(code: isSuccess ? 200 : 500, msg: errorMsg);
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
