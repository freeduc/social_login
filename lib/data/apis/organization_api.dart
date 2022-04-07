
import 'package:http/http.dart' as http;
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/resources/function.dart';
import 'package:social_login/resources/locator.dart';
import 'package:social_login/resources/strings.dart';

class OrganizationApi {
  final http.Client client;

  OrganizationApi({required this.client});

  final String accessToken = preferences.getString('accessToken') ?? '';

  ///
  /// 모든 단체 조회
  ///
  Future<ApiResponse> findAll() async {
    try {
      final response = await client.get(
        Uri.http(Strings.apiDomain, '/api/organization/'),
        headers: {
          'X-AUTH-TOKEN': accessToken,
        },
      );

      final body = Functions.toJsonUTF8(response.bodyBytes);

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(body);
      } else {
        return ApiResponse.failed(code: body['code'], msg: body['msg']);
      }
    } catch (e) {
      return ApiResponse.failed();
    }
  }

  ///
  /// 모든 단체 페이징 조회
  ///
  Future<ApiResponse> findAllByPaging(Map<String, String> params) async {
    try {
      final response = await client.get(
        Uri.http(
          Strings.apiDomain,
          '/api/organization/',
          params,
        ),
        headers: {
          'X-AUTH-TOKEN': accessToken,
        },
      );

      final body = Functions.toJsonUTF8(response.bodyBytes);

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(body);
      } else {
        return ApiResponse.failed(code: body['code'], msg: body['msg']);
      }
    } catch (e) {
      return ApiResponse.failed();
    }
  }
}
