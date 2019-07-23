//
//  InsTagsShareManager.h
//  InsTags
//
//  Created by 111 on 2019/6/13.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DiNTugsShareManager : NSObject

+ (void)PostShareToInstagram:(NSString*)videoPath;

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *tags;
@end

NS_ASSUME_NONNULL_END
