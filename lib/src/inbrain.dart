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

  Future<void> getNativeSurveys() async {
    return platform.getNativeSurveys();
  }

  Future<void> showNativeSurvey({required String id, String? placementId}) async {
    return platform.showNativeSurvey(id: id, placementId: placementId);
  }

  void onSurveyClosed(InBrainClosedCallback listener) => platform.onSurveyClosed = listener;

  void onSurveyClosedFromPage(InBrainClosedCallback listener) => platform.onSurveyClosedFromPage = listener;

  void onDidReceiveRewards(InBrainRewardCallback listener) => platform.onDidReceiveRewards = listener;

  void onDidFailToReceiveRewards(InBrainErrorCallback listener) => platform.onDidFailToReceiveRewards = listener;

  void onNativeSurveysLoadingStarted(InBrainVoidCallback listener) => platform.onNativeSurveysLoadingStarted = listener;

  void onNativeSurveysReceived(InBrainNativeSurveysCallback listener) => platform.onNativeSurveysReceived = listener;

  void onFailedToReceiveNativeSurveys(InBrainErrorCallback listener) => platform.onFailedToReceiveNativeSurveys = listener;
}
