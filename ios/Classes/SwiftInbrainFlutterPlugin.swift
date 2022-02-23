import Flutter
import UIKit
import InBrainSurveys_SDK_Swift

public class SwiftInbrainFlutterPlugin: NSObject, FlutterPlugin, InBrainDelegate, NativeSurveyDelegate {
    
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
            inBrain.nativeSurveysDelegate = self;
            
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
            
        case "getNativeSurveys":
            inBrain.getNativeSurveys()
        
        case "showNativeSurvey":
            if let arguments = call.arguments as? Dictionary<String, Any>,
               let surveyId = arguments["id"] as? String,
               let placementId = arguments["placementId"] as? String {
                let controller = UIApplication.shared.keyWindow!.rootViewController!
                inBrain.showNativeSurveyWith(id: surveyId, placementId: placementId, from: controller)
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    //////////////////////////////////////////
    //MARK: - InBrainDelegate
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
    
    //////////////////////////////////////////
    //MARK: - NativeSurveysDelegate
    //////////////////////////////////////////
    
    public func nativeSurveysLoadingStarted(placementId: String?) {
        channel.invokeMethod("onNativeSurveysLoadingStarted", arguments: placementId);
    }

    public func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey], placementId: String?) {
        var result = [[String:Any?]]();
        
        for item in surveys {
            var it = [String:Any?]();
            it["id"] = item.id;
            it["time"] = item.time;
            it["rank"] = item.rank;
            it["value"] = item.value;
            it["placementId"] = item.placementId;
            result.append(it);
        }
        
        let arguments : [String: Any?] = ["surveys": result, "placementId": placementId];
        channel.invokeMethod("onNativeSurveysReceived", arguments: arguments);
    }
       
    public func failedToReceiveNativeSurveys(error: Error, placementId: String?) {
        let arguments : [String: Any?] = ["error": error.localizedDescription, "placementId": placementId];
        channel.invokeMethod("onFailedToReceiveNativeSurveys", arguments: arguments);
    }
}
