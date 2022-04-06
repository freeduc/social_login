import 'package:http/http.dart' as http;
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/resources/errors.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/strings.dart';

class MemberApi {
  final http.Client client;

  MemberApi({required this.client});

  Future<ApiResponse> findByPhone(String phone) async {
    try {
      final response = await client.get(
        Uri.http(Strings.apiDomain, '/api/member/$phone'),
        headers: {
          'X-AUTH-TOKEN': preferences.getString('accessToken') ?? '',
        },
      );

      final Map<String, dynamic> body =
          Functions.toJsonUTF8(response.bodyBytes);

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
}
