import 'package:http/http.dart' as http;
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/resources/errors.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/strings.dart';

class SignApi {
  SignApi({required this.client});

  final http.Client client;

  ///
  /// 회원가입
  ///
  Future<ApiResponse> signUp(Map<String, String> form) async {
    try {
      final response = await client.post(
        Uri.http(Strings.apiDomain, '/signUp'),
        body: form,
      );

      final body = Functions.toJsonUTF8(response.bodyBytes);

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(body);
      } else {
        return ApiResponse.failed(code: body['code'], msg: body['msg']);
      }
    } catch (e) {
      print(e);
      throw Exceptions.connectServerFailed;
    }
  }

  ///
  /// 로그인
  ///
  Future<ApiResponse> signIn(String phone, String password) async {
    try {
      final response = await client.post(
        Uri.http(Strings.apiDomain, '/signIn'),
        body: {'id': phone, 'password': password},
      );

      final body = Functions.toJsonUTF8(response.bodyBytes);

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(body);
      } else {
        final code = body['code'];

        if (code == 1001) {
          return ApiResponse.failed(code: code, msg: '아이디 또는 패스워드가 틀립니다.');
        } else {
          return ApiResponse.failed(code: code);
        }
      }
    } catch (e) {
      print(e);
      throw Exceptions.connectServerFailed;
    }
  }
}
