//
//  LibUtilEx.m
//

#import "LibUtilEx.h"
#import <CommonCrypto/CommonDigest.h>
#import "regex.h"

@implementation LibUtilEx

+ (BOOL)stringIsLegal:(NSString *)str
{
    return (str && [str length] > 0);
}

+ (NSInteger)fontForStr:(NSString *)str constrainedToSize:(CGSize)size
{
    NSInteger fontSize = 1;
    CGSize strSize = [str sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    while (strSize.height < size.height) {
        fontSize ++;
        strSize = [str sizeWithFont:[UIFont systemFontOfSize:fontSize]  constrainedToSize:CGSizeMake(size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    }
    return fontSize - 1;
}

@end

