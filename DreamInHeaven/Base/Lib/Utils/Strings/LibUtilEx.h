//
//  LibUtilEx.h
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
//#import "LibUtil.h"

@interface LibUtilEx : NSObject
{
    
}

+ (BOOL)stringIsLegal:(NSString *)str;
+ (NSInteger)fontForStr:(NSString *)str constrainedToSize:(CGSize)size;

@end

