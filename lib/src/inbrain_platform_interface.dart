import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'inbrain_method_channel.dart';

typedef InBrainSurveyClosedCallback = void Function(bool? value);
typedef InBrainErrorRewardsCallback = void Function(String? value);
typedef InBrainSuccessRewardsCallback = void Function(double? value);

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
  InBrainSurveyClosedCallback? onSurveyClosed;

  /// This delegate function calls back whenever the InBrainWebView is dismissed from special web page placement
  InBrainSurveyClosedCallback? onSurveyClosedFromPage;

  /// This delegate function provides an array of InBrainReward objects
  InBrainSuccessRewardsCallback? onDidReceiveRewards;

  /// This delegate function provides an error if getRewards() failed
  InBrainErrorRewardsCallback? onDidFailToReceiveRewards;

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
}
