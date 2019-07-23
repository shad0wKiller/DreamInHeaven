//
//  InsTagTabBarController.h
//  InsTags
//
//  Created by 111 on 2019/6/9.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiNTagTabBar.h"
NS_ASSUME_NONNULL_BEGIN
@class DiNTabBarController;
@protocol InsTagTabBarControllerDelegate <InsTagBarDelegate>
- (void)addButtonClick:(DiNTabBarController *)tabBarVC;
@end

@interface DiNTabBarController : UITabBarController
@property (nonatomic, weak) id<InsTagTabBarControllerDelegate>insTagTabBarDelegate;
@end

NS_ASSUME_NONNULL_END
