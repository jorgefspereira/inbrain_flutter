import 'dart:async';

import 'package:flutter/services.dart';

import 'inbrain_platform_interface.dart';

class InBrainMethodChannel extends InBrainPlatformInterface {
  final MethodChannel _channel = const MethodChannel('inbrain_flutter');

  MethodChannel get channel => _channel;

  InBrainMethodChannel() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  @override
  Future<void> init({required String apiClientId, required String apiSecret, bool isS2S = false, String? userId}) async {
    return _channel.invokeMethod(
      'init',
      <String, dynamic>{
        'apiClientId': apiClientId,
        'apiSecret': apiSecret,
        'isS2S': isS2S,
        'userId': userId,
      },
    );
  }

  @override
  Future<void> showSurveys() async {
    return _channel.invokeMethod('showSurveys');
  }

  @override
  Future<void> setUserId(String userId) async {
    return _channel.invokeMethod(
      'setUserId',
      <String, dynamic>{'userId': userId},
    );
  }

  @override
  Future<bool?> checkForAvailableSurveys() async {
    return await _channel.invokeMethod('checkForAvailableSurveys');
  }

  @override
  Future<void> getNativeSurveys() async {
    return _channel.invokeMethod('getNativeSurveys');
  }

  @override
  Future<void> showNativeSurvey(String id, String placementId) async {
    return _channel.invokeMethod(
      'showNativeSurvey',
      <String, dynamic>{'id': id, 'placementId': placementId},
    );
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onSurveyClosed":
        onSurveyClosed?.call(call.arguments);
        break;
      case "onSurveyClosedFromPage":
        onSurveyClosedFromPage?.call(call.arguments);
        break;
      case "onDidReceiveInBrainRewards":
        onDidReceiveRewards?.call(call.arguments);
        break;
      case "onDidFailToReceiveRewards":
        onDidFailToReceiveRewards?.call(call.arguments);
        break;
      default:
        throw MissingPluginException('${call.method} was invoked but has no handler');
    }
  }
}
