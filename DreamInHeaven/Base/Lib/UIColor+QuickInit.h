
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define C_RGB_A(COLORSTR,ALPHA) ([UIColor colorWithRGB:(COLORSTR) alpha:(ALPHA)])
#define C_RGB(COLORSTR) C_RGB_A((COLORSTR),1)
#define C_R_G_B_A(rrr,ggg,bbb,aaa) ([UIColor colorWithIntRed:(rrr) green:(ggg) blue:(bbb) alpha:(aaa)])
#define C_R_G_B(r,g,b) C_R_G_B_A(r,g,b,1)

@interface UIColor(QuickInit)

// for exmaple UIColor *color = [UIColor colorWithRGB:0xff0000 alpha:0.5];
+ (UIColor*)colorWithRGB:(unsigned int)aRGB alpha:(CGFloat)aAlpha;

+ (UIColor *)colorWithIntRed:(uint)red green:(uint)green blue:(uint)blue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithARGB:(unsigned int)argb;
+ (UIColor *)colorWithRGB:(unsigned int)rgb;

+ (UIColor *)colorWithRGBHexString:(NSString *)hex;
+ (UIColor *)colorWithARGBHexString:(NSString *)hex;

- (NSString *)hexARGBString;
- (NSString *)hexRGBString;
- (BOOL)isGrayLikeColor;

- (BOOL)isLightColor;

@end
