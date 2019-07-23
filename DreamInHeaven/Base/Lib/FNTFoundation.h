
#import <UIKit/UIKit.h>
//#import <Reachability/Reachability.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "UIDevice+Hardware.h"

#define SCREEN_SCALE ([UIScreen mainScreen].scale)
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define OnePixel (1.f/SCREEN_SCALE)

#define IS_RETINA() (SCREEN_SCALE >= 1.0f)
#define IS_RETINA_2X() (SCREEN_SCALE == 2.0f)
#define IS_RETINA_3X() (SCREEN_SCALE == 3.0f)

#define IS_IPAD	([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPAD_HD (IS_IPAD || IS_RETINA)

#define IS_SCREEN_3_5 ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define IS_SCREEN_4 ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define IS_SCREEN_4_7 ([UIScreen mainScreen].bounds.size.height == 667.0f)
#define IS_SCREEN_4_7_OR_BIGGER ([UIScreen mainScreen].bounds.size.height >= 667.0f)
#define IS_SCREEN_5_5 ([UIScreen mainScreen].bounds.size.height == 736.0f)
#define IS_SCREEN_5_5_OR_BIGGER ([UIScreen mainScreen].bounds.size.height >= 736.0f)

#define IS_SCREEN_WIDTH_320_OR_BIGGER ([UIScreen mainScreen].bounds.size.width >= 320.0f)

#if TARGET_IPHONE_SIMULATOR

#define IS_IPHONEXS_MAX (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size))
#define IS_IPHONEXR (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size))
#define IS_IPHONEX_ORXS (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size))

#else

#define IS_IPHONEXS_MAX ([UIDevice deviceHardware] == UIDeviceHardware_iPhone_XS_MAX)
#define IS_IPHONEXR ([UIDevice deviceHardware] == UIDeviceHardware_iPhone_XR)
#define IS_IPHONEX_ORXS ([UIDevice deviceHardware] == UIDeviceHardware_iPhone_X || [UIDevice deviceHardware] == UIDeviceHardware_iPhone_XS)

#endif

#define IS_HAVE_SAFEAREAINSET   (IS_IPHONEX_ORXS|| IS_IPHONEXR || IS_IPHONEXS_MAX)
#define IS_IPHONEX  IS_HAVE_SAFEAREAINSET   //临时全面兼容，后续废弃

#define StatusBarHeight    (IS_IPHONEX?44.f:20.f)
#define NavigationBarHeight    (44.f)

// 获取本地字符串
#define LString(KEY) NSLocalizedString((KEY),nil)


// 用iOS5的Json生成方法
#define JsonEncode(object) (object?[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:0 error:nil] encoding:NSUTF8StringEncoding]:nil)
#define JsonPrettyEncode(object) (object?[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]:nil)
#define JsonDecode(jsonStr) (jsonStr?[NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil]:nil)


// 声明const key的宏
// KEY_VAR 产生的变量名
// KEY_NAME @"就是这个东西" 值
// KEY_TYPE key的类别  标示这个key的类别  比如userdefault notification 名字随便起
// 可以参考下面Notification系列宏
//
// 如果有重复的 link 阶段会有重复符号 就会报错了 搜索重复的符号 可以去掉重复key

#ifdef DEBUG

    #define CREATE_KEY_VALUE(KEY_VAR,KEY_NAME,KEY_TYPE)         \
                static NSString* const KEY_VAR = @#KEY_NAME;    \
                NSString *KEY_NAME##_for_##KEY_TYPE = nil;  //主要就是通过这玩意判断 如果有重复的 link 阶段会有重复符号 就会报错了 搜索重复的符号 可以去掉重复key

    #define CREATE_KEY_VALUE_PUBLIC(KEY_VAR,KEY_NAME,KEY_TYPE)  \
                NSString* const KEY_VAR = @#KEY_NAME;             \
                NSString *KEY_NAME##_for_##KEY_TYPE = nil;
#else

    #define CREATE_KEY_VALUE(KEY_VAR,KEY_NAME,KEY_TYPE)         \
            static NSString* const KEY_VAR = @#KEY_NAME;    \


    #define CREATE_KEY_VALUE_PUBLIC(KEY_VAR,KEY_NAME,KEY_TYPE)  \
            NSString* const KEY_VAR = @#KEY_NAME;             \


#endif

// 创建相同名字的变量和赋值
#define CREATE_KEY(KEY,TYPE) CREATE_KEY_VALUE(KEY,KEY,TYPE)
#define CREATE_KEY_PUBLIC(KEY,TYPE) CREATE_KEY_VALUE_PUBLIC(KEY,KEY,TYPE)

// 头文件 extern 引用
#define CREATE_KEY_PUBLIC_HEADER(KEY) extern NSString* const KEY;

// 通知中心的key
#define NotificationNameHeader(NAME)  CREATE_KEY_PUBLIC_HEADER(NAME)
#define NotificationName(NAME)        CREATE_KEY_PUBLIC(NAME,NSNotificationName)
#define NotificationVarName(VAR,NAME) CREATE_KEY_VALUE_PUBLIC(VAR,NAME,NSNotificationName)

// userdefault的key
#define UserDefaultKey(NAME) CREATE_KEY(NAME,UserDefaultKey)
#define UserDefaultVarKey(VAR,NAME) CREATE_KEY_VALUE(VAR,NAME,UserDefaultKey)

// 弱引用
#define WEAKREF(ttttt) __weak __typeof__ (ttttt) w##ttttt = ttttt
#define STRONGREF(ttttt) __strong __typeof__ (ttttt) s##ttttt = ttttt

// 网络诊断
#define IsWifi ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWiFi)
#define IsWWAN ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWWAN)
#define IsNetworkReachable ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable)
#define Is2G   ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == ReachableViaWWAN \
    && [@[CTRadioAccessTechnologyEdge,CTRadioAccessTechnologyGPRS,CTRadioAccessTechnologyCDMA1x] containsObject:[[CTTelephonyNetworkInfo new] currentRadioAccessTechnology]])

// 单例
#define SingletonDeclarationWithClass +(instancetype)sharedInstance;
#define SingletonImplementationWithClass \
+ (instancetype)sharedInstance {\
    static id instance = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
}

// 是否连接debugger调试模式
FOUNDATION_EXPORT BOOL AmIBeingDebugged();
#define WFWIsInDebugger AmIBeingDebugged()

// 是否在模拟器
#if TARGET_IPHONE_SIMULATOR
#define WFWIsInSimulator 1
#else
#define WFWIsInSimulator 0
#endif

// 主线程
FOUNDATION_EXTERN BOOL WFWIsMainQueue();
FOUNDATION_EXTERN void WFWExecuteOnMainQueue(dispatch_block_t block);
FOUNDATION_EXTERN void WFWExecuteOnMainThread(dispatch_block_t block, BOOL sync);

// 检测没有实现方法
#define WFW_NOT_IMPLEMENTED(method) \
    _Pragma("clang diagnostic push") \
    _Pragma("clang diagnostic ignored \"-Wmissing-method-return-type\"") \
    _Pragma("clang diagnostic ignored \"-Wunused-parameter\"") \
    RCT_EXTERN NSException *_RCTNotImplementedException(SEL, Class); \
    method NS_UNAVAILABLE { \
        NSString *msg = [NSString stringWithFormat:@"%s is not implemented for the class %@", sel_getName(cmd), cls]; \
        @throw [NSException exceptionWithName:@"WFWNotImplementedException" reason:msg userInfo:nil]; \
    } \
    _Pragma("clang diagnostic pop")

// 基本block
typedef void(^BaseBlock)(void);
typedef void(^BaseBlockWithId)(id obj);
typedef void(^BaseBlockWithIdAndIndex)(id obj, NSInteger index);
typedef void(^BaseBlockWithBool)(BOOL YesOrNo);

typedef void(^BaseSuccessBlock)(BOOL success);
typedef void(^BaseErrorBlock)(NSError *err,id obj);

#define SuccessHandlerBlock(handlerrrr) ^(BOOL success){if(success){handlerrrr}};

// Strings
#define STRINGIZE(x) #x
#define NSSTRING(text) @ STRINGIZE(text)

#define L(key) NSLocalizedString(key, nil)
#define LT(key, tbl) NSLocalizedStringFromTable(key, tbl, nil)

#define StrIfNN(ssss)   ((ssss)?(ssss):@"")
#define StrDefault(ssss, dddd) (ssss).length ? (ssss) : (dddd);

// For easy use
#define RadianFromDegree(degrees) ((degrees) * M_PI / 180)
#define DegreeFromRadian(radians) ((radians) / M_PI * 180)
#define CONSTRAINT_VALUE(value, min, max) MIN(MAX((value), (min)), (max))

// UIView find UIViewController
#define WFWUIViewFindParentController(__view) ({ \
    UIResponder *__responder = __view; \
    while ([__responder isKindOfClass:[UIView class]]) \
        __responder = [__responder nextResponder]; \
    (UIViewController *)__responder; \
    })

#import "UIColor+QuickInit.h"
#import "Masonry.h"


@interface FNTFoundation : NSObject
@end
