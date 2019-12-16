#import "FlutterResponsivePlugin.h"
#if __has_include(<flutter_responsive/flutter_responsive-Swift.h>)
#import <flutter_responsive/flutter_responsive-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_responsive-Swift.h"
#endif

@implementation FlutterResponsivePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterResponsivePlugin registerWithRegistrar:registrar];
}
@end
