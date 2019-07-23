
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIDeviceHardware)
{
    // iPhone
    UIDeviceHardware_iPhone_1           = 10,// 412 / 620
    UIDeviceHardware_iPhone_3G          = 20,// 412 / 620
    UIDeviceHardware_iPhone_3GS         = 30,// 600 / 833
    UIDeviceHardware_iPhone_4           = 40,// A4 800
    UIDeviceHardware_iPhone_4S          = 50,// A5 800 /1G
    UIDeviceHardware_iPhone_5           = 60,// 1.3 A6
    UIDeviceHardware_iPhone_5C          = 61,// 1.3 A6
    UIDeviceHardware_iPhone_5S          = 70,// 1.3 A7
    UIDeviceHardware_iPhone_6           = 80,//
    UIDeviceHardware_iPhone_6PLUS       = 90,
    UIDeviceHardware_iPhone_6S          = 100,
    UIDeviceHardware_iPhone_6SPLUS      = 110,
    UIDeviceHardware_iPhone_SE          = 120,
    UIDeviceHardware_iPhone_7PLUS       = 130,
    UIDeviceHardware_iPhone_7           = 140,
    UIDeviceHardware_iPhone_8           = 150,
    UIDeviceHardware_iPhone_8_PLUS      = 160,
    UIDeviceHardware_iPhone_X           = 170,
    UIDeviceHardware_iPhone_XS_MAX      = 180,
    UIDeviceHardware_iPhone_XR          = 190,
    UIDeviceHardware_iPhone_XS          = 200,
    
    // iPad
    UIDeviceHardware_iPad_1             = 41, // A4
    UIDeviceHardware_iPad_2             = 52, // A5
    UIDeviceHardware_iPad_3             = 55, // A5X
    UIDeviceHardware_iPad_4             = 65, // A6X
    UIDeviceHardware_iPad_Air           = 71, // A7
    UIDeviceHardware_iPad_Air_2         = 91,
    UIDeviceHardware_iPad_5             = 111,
    UIDeviceHardware_iPad_Pro_129       = 301,
    UIDeviceHardware_iPad_Pro_97        = 302,
    
    
    
    // iPad mini
    UIDeviceHardware_iPad_Mini_1        = 51,
    UIDeviceHardware_iPad_Mini_2        = 62,
    UIDeviceHardware_iPad_Mini_3        = 72,
    UIDeviceHardware_iPad_Mini_4        = 92,
    
    // unknow or Simulator max
    UIDeviceHardware_Unknow  = 10000,
};

@interface UIDevice (Hardware)

+ (UIDeviceHardware)deviceHardware;

+ (NSString*)hardwareModel;

+ (NSString*)macAddress;

@end
