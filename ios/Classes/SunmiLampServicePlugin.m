#import "SunmiLampServicePlugin.h"
#if __has_include(<sunmi_lamp_service/sunmi_lamp_service-Swift.h>)
#import <sunmi_lamp_service/sunmi_lamp_service-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sunmi_lamp_service-Swift.h"
#endif

@implementation SunmiLampServicePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSunmiLampServicePlugin registerWithRegistrar:registrar];
}
@end
