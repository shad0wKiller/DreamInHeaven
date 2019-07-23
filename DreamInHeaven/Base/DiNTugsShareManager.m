//
//  InsTagsShareManager.m
//  InsTags
//
//  Created by 111 on 2019/6/13.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DiNTugsShareManager.h"
#import "SynthesizeSingleton.h"
#import <AssetsLibrary/AssetsLibrary.h>
//#import "NSString+EnDeCoding.h"
#import <Photos/Photos.h>
#import "DiNTugsPhotoManager.h"
@implementation DiNTugsShareManager

+ (void)PostShareToInstagram:(NSString*)imagePath
{
    NSLog(@"save video url: %@", imagePath);
    NSURL* instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]){

        if (imagePath.length) {
            NSString *escapedString  = [DiNTugsShareManager urlencodedString:imagePath];
            NSURL *insURL = [NSURL URLWithString:[NSString stringWithFormat:@"instagram://library?AssetPath=%@&InstagramCaption=%@", escapedString, @""]];
            [[UIApplication sharedApplication] openURL:insURL options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:instagramURL options:@{} completionHandler:nil];
        }
        
    }else{
        NSLog(@"无法打开Instagram，请确定是否安装了Instagram！");
    }
}
+ (NSString*)urlencodedString:(NSString *)message{
    return [message stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}

@end
