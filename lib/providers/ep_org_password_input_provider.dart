
import 'package:flutter/material.dart';
import 'package:social_login/data/repository/organization_repository.dart';
import 'package:social_login/models/organization/organization_model.dart';

class ExpertOrganizationPasswordInputProvider extends ChangeNotifier {
  final OrganizationRepository organizationRepo;

  ExpertOrganizationPasswordInputProvider({required this.organizationRepo});

  // 전달받은 단체 정보
  OrganizationModel? receivedOrganization;

  void setOrganization(OrganizationModel organizationModel) {
    receivedOrganization = organizationModel;
  }
}
