import 'dart:async';

import 'inbrain_platform_interface.dart';

class InBrain {
  /// The platform interface that drives this plugin
  static InBrainPlatformInterface get platform => InBrainPlatformInterface.instance;

  InBrain({required String apiClientId, required String apiSecret, bool isS2S = false, String? userId}) {
    platform.init(apiClientId: apiClientId, apiSecret: apiSecret, isS2S: isS2S, userId: userId);
  }

  Future<void> showSurveys() async {
    return platform.showSurveys();
  }

  Future<bool?> checkForAvailableSurveys() async {
    return await platform.checkForAvailableSurveys();
  }

  Future<void> setUserId(String userId) async {
    return platform.setUserId(userId);
  }

  void onSurveyClosed(InBrainSurveyClosedCallback listener) => platform.onSurveyClosed = listener;

  void onSurveyClosedFromPage(InBrainSurveyClosedCallback listener) => platform.onSurveyClosedFromPage = listener;

  void onDidReceiveRewards(InBrainSuccessRewardsCallback listener) => platform.onDidReceiveRewards = listener;

  void onDidFailToReceiveRewards(InBrainErrorRewardsCallback listener) => platform.onDidFailToReceiveRewards = listener;
}
