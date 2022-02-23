import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'inbrain_method_channel.dart';
import 'inbrain_survey.dart';

typedef InBrainClosedCallback = void Function(bool? completedSurvey);
typedef InBrainErrorCallback = void Function(String? error);
typedef InBrainRewardCallback = void Function(double? reward);
typedef InBrainVoidCallback = void Function();
typedef InBrainNativeSurveysCallback = void Function(List<InBrainSurvey> surveys, String? placementId);

abstract class InBrainPlatformInterface extends PlatformInterface {
  /// Contructor
  InBrainPlatformInterface() : super(token: _token);

  /// token
  static final Object _token = Object();

  /// Singleton instance
  static InBrainPlatformInterface _instance = InBrainMethodChannel();

  /// Default instance to use.
  static InBrainPlatformInterface get instance => _instance;

  static set instance(InBrainPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  ////////////////////////////////////
  /// InBrain platform interface
  ///////////////////////////////////

  /// This delegate function calls back whenever the InBrainWebView is dismissed
  InBrainClosedCallback? onSurveyClosed;

  /// This delegate function calls back whenever the InBrainWebView is dismissed from special web page placement
  InBrainClosedCallback? onSurveyClosedFromPage;

  /// This delegate function provides an array of InBrainReward objects
  InBrainRewardCallback? onDidReceiveRewards;

  /// This delegate function provides an error if getRewards() failed
  InBrainErrorCallback? onDidFailToReceiveRewards;

  /// Сalled just after loading of NativeSurveys started.
  InBrainVoidCallback? onNativeSurveysLoadingStarted;

  /// Called when Native surveys have been returned
  InBrainNativeSurveysCallback? onNativeSurveysReceived;

  /// Called if loading of Native Surveys failed
  InBrainErrorCallback? onFailedToReceiveNativeSurveys;

  Future<void> init({required String apiClientId, required String apiSecret, bool isS2S = false, String? userId}) async {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> showSurveys() async {
    throw UnimplementedError('showSurveys() has not been implemented.');
  }

  Future<void> setUserId(String userId) async {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<bool?> checkForAvailableSurveys() async {
    throw UnimplementedError('checkForAvailableSurveys() has not been implemented.');
  }

  Future<void> getNativeSurveys() async {
    throw UnimplementedError('getNativeSurveys() has not been implemented.');
  }

  Future<void> showNativeSurvey({required String id, String? placementId}) async {
    throw UnimplementedError('showNativeSurvey() has not been implemented.');
  }
}
