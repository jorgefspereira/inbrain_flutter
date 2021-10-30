import Flutter
import UIKit
import InBrainSurveys_SDK_Swift

public class SwiftInbrainFlutterPlugin: NSObject, FlutterPlugin, InBrainDelegate {
    
    let channel: FlutterMethodChannel!
    var result: FlutterResult!
    let inBrain: InBrain!


    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "inbrain_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftInbrainFlutterPlugin(withChannel: channel)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    // Plugin constructor
    init(withChannel channel: FlutterMethodChannel) {
        self.channel = channel
        self.inBrain = InBrain.shared
    }
    
    // Plugin handle method
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        switch call.method {
        case "init":
            if let arguments = call.arguments as? Dictionary<String, Any> {
                if let apiClientId = arguments["apiClientId"] as? String,
                   let apiSecret = arguments["apiSecret"] as? String,
                   let isS2S = arguments["isS2S"] as? Bool {
                    inBrain.setInBrain(apiClientID: apiClientId, apiSecret: apiSecret, isS2S: isS2S)
                }
                
                if let userId = arguments["userId"] as? String {
                    inBrain.set(userID: userId)
                }
                
            }
            try! inBrain.setLanguage("en-us")
            inBrain.inBrainDelegate = self;
            
        case "showSurveys":
            inBrain.showSurveys()
            
        case "checkForAvailableSurveys":
            inBrain.checkForAvailableSurveys { hasSurveys, _ in
                result(hasSurveys);
            }
                
        case "setUserId":
            if let arguments = call.arguments as? Dictionary<String, Any>,
               let userId = arguments["userId"] as? String {
                inBrain.set(userID: userId)
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    //////////////////////////////////////////
    //MARK: InBrainDelegate
    //////////////////////////////////////////
    
    public func didFailToReceiveRewards(error: Error) {
        channel.invokeMethod("onDidFailToReceiveRewards", arguments: error.localizedDescription)
    }
    
    public func didReceiveInBrainRewards(rewardsArray: [InBrainReward]) {
        var idsToConfirm : [Int] = []
        var points: Float = 0
        
        for reward in rewardsArray {
            points +=  reward.amount
            idsToConfirm.append(reward.transactionId)
        }
        
        inBrain.confirmRewards(txIdArray: idsToConfirm)
        channel.invokeMethod("onDidReceiveInBrainRewards", arguments: points)
    }
    
    public func surveysClosed(byWebView: Bool, completedSurvey: Bool) {
        channel.invokeMethod("onSurveyClosed", arguments: completedSurvey)
    }
    
    public func surveysClosedFromPage(byWebView: Bool, completedSurvey: Bool) {
        channel.invokeMethod("onSurveyClosedFromPage", arguments: completedSurvey)
    }
}
