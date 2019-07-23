
#import "UIColor+QuickInit.h"
#import "LoadableCategory.h"

MAKE_CATEGORIES_LOADABLE (TGCommon_UIColor_QuickInit)

static inline NSUInteger integerValueFromHex(NSString *s)
{
    int result = 0;
    sscanf([s UTF8String], "%x", &result);
    return result;
}


@implementation UIColor(QuickInit)

+(UIColor*)colorWithRGB:(unsigned int)aColor alpha:(CGFloat)aAlpha
{
    int r = aColor / 256 / 256;
    int g = aColor / 256 % 256;
    int b = aColor % 256;
    
    //转换为UIColor
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:aAlpha];
}


+ (UIColor *)colorWithIntRed:(uint)red green:(uint)green blue:(uint)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:alpha];
}

+ (UIColor*)colorWithARGB:(unsigned int)argb;
{
    CGFloat red = (argb>>16)&0xFF;
    CGFloat green = (argb>>8)&0xFF;
    CGFloat blue = argb&0xFF;
    CGFloat alpha = 255;
    
    if (argb > (unsigned int)0xFFFFFF)
    {
        alpha = (argb>>24)&0xFF;
    }
    
    return [UIColor colorWithIntRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithRGB:(unsigned int)rgb;
{
    return [UIColor colorWithARGB:rgb];
}

+ (UIColor *)colorWithRGBHexString:(NSString *)hex
{
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    
    if ([hex length]!=6 && [hex length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hex length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat red = integerValueFromHex([hex substringWithRange:NSMakeRange(0, digits)])/maxValue;
    CGFloat green = integerValueFromHex([hex substringWithRange:NSMakeRange(digits, digits)])/maxValue;
    CGFloat blue = integerValueFromHex([hex substringWithRange:NSMakeRange(2*digits, digits)])/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWithARGBHexString:(NSString *)hex
{
    if ([hex hasPrefix:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    
    if ([hex length]!=8 && [hex length]!=4)
    {
        return [self colorWithRGBHexString:hex];
    }
    
    NSUInteger digits = [hex length]/4;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat alpha = integerValueFromHex([hex substringWithRange:NSMakeRange(0, digits)])/maxValue;
    CGFloat red = integerValueFromHex([hex substringWithRange:NSMakeRange(digits, digits)])/maxValue;
    CGFloat green = integerValueFromHex([hex substringWithRange:NSMakeRange(2*digits, digits)])/maxValue;
    CGFloat blue = integerValueFromHex([hex substringWithRange:NSMakeRange(3*digits, digits)])/maxValue;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexARGBString
{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%02x%02x%02x%02x",(int)(a*255), (int)(r*255), (int)(g*255), (int)(b*255)];
}

- (NSString *)hexRGBString
{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return [NSString stringWithFormat:@"#%02x%02x%02x", (int)(r*255), (int)(g*255), (int)(b*255)];
}

- (BOOL)isGrayLikeColor
{
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    return r==g && g==b;
}

- (BOOL)isLightColor
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    return colorBrightness > 0.5;
}

@end
