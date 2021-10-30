#import "InbrainFlutterPlugin.h"
#if __has_include(<inbrain_flutter/inbrain_flutter-Swift.h>)
#import <inbrain_flutter/inbrain_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "inbrain_flutter-Swift.h"
#endif

@implementation InbrainFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInbrainFlutterPlugin registerWithRegistrar:registrar];
}
@end
