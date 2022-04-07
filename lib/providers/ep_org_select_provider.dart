import 'package:flutter/material.dart';
import 'package:social_login/data/repository/organization_repository.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/models/organization/organization_model.dart';

class ExpertProposalOrgSelectProvider extends ChangeNotifier {
  final OrganizationRepository organizationRepo;

  ExpertProposalOrgSelectProvider({required this.organizationRepo});

  // 단체 저장 리스트
  List<OrganizationModel> orgList = [];

  Future getOrganizationListAsPaging({required int page, int? size}) async {
    return organizationRepo.findAllByPaging(page: page, size: size);
  }

  Future<ApiResponse> getAllOrganization() async {
    final ApiResponse response = await organizationRepo.findAll();
    // 조회 성공 시
    if (response.code == 200) {
      // 데이터 있을 시
      if (response.data != null) {
        orgList
          ..clear()
          ..addAll((response.data as List).map((e) => OrganizationModel.fromJson(e)));
        notifyListeners();
      }

      return ApiResponse.success(code: response.code, msg: response.msg);
    } else {
      return ApiResponse.failed(code: response.code, msg: response.msg);
    }
  }
}
