import 'package:flutter/material.dart';
import 'package:social_login/models/common/api_response.dart';
import 'package:social_login/data/repository/sign_repository.dart';

class SplashProvider extends ChangeNotifier {
  final SignRepository signRepo;

  SplashProvider({
    required this.signRepo,
  });

  Future<bool> autoLogin() async {
    ApiResponse response = await signRepo.autoLogin();

    if (response.success) {
      return true;
    } else {
      return false;
    }
  }
}
