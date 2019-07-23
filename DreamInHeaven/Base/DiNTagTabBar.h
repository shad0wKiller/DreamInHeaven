//
//  InsTagTabBar.h
//  InsTags
//
//  Created by 111 on 2019/6/9.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DiNTagTabBar;
@protocol InsTagBarDelegate <NSObject>

- (void)addButtonClick:(DiNTagTabBar *)tabBar;

@end

@interface DiNTagTabBar : UITabBar
@property (nonatomic, weak) id<InsTagBarDelegate>insTagTabBarDelegate;
@end

NS_ASSUME_NONNULL_END
