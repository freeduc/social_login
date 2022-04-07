
import 'package:social_login/data/apis/organization_api.dart';
import 'package:social_login/models/common/api_response.dart';

class OrganizationRepository {
  final OrganizationApi organizationApi;

  OrganizationRepository({required this.organizationApi});

  Future<ApiResponse> findAllByPaging({required int page, int? size}) async {
    Map<String, String> params = {'page': '$page'};

    if (size != null) {
      params['size'] = '$size';
    }

    return organizationApi.findAllByPaging(params);
  }

  Future<ApiResponse> findAll() async {
    return organizationApi.findAll();
  }
}
