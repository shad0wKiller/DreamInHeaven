
#import <UIKit/UIKit.h>

@interface UIColor (Addition)

+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

- (NSString *)hexARGBValue;
- (NSString *)hexRGBValue;

- (BOOL)isGrayLikeColor;

@end

#define ColorHexStr(hexxxx) [UIColor colorWithHexString:(hexxxx)]
