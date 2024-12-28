import 'package:flutter/material.dart';
import 'package:grocery_delivery_boy/common/models/api_response_model.dart';
import 'package:grocery_delivery_boy/features/profile/domain/models/userinfo_model.dart';
import 'package:grocery_delivery_boy/features/profile/domain/reposotories/profile_repo.dart';
import 'package:grocery_delivery_boy/helper/api_checker_helper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  String _appVersion = '';

  ProfileProvider({required this.profileRepo});

  UserInfoModel? _userInfoModel;

  UserInfoModel? get userInfoModel => _userInfoModel;

  String get appVersion => _appVersion;

  Future<void> loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners();
  }

  Future<void> getUserInfo(BuildContext context) async {
    ApiResponseModel apiResponse = await profileRepo.getUserInfo();
    if (apiResponse.response?.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(apiResponse.response?.data);
    } else {
      ApiCheckerHelper.checkApi( apiResponse);
    }
    notifyListeners();
  }
}
