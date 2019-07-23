//
//  InsTagTabBarController.m
//  InsTags
//
//  Created by 111 on 2019/6/9.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DiNTabBarController.h"
#import "DiNTagTabBar.h"

@interface DiNTabBarController () <InsTagBarDelegate>

@end

@implementation DiNTabBarController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    DiNTagTabBar *tabBar = [[DiNTagTabBar alloc] init];
    tabBar.insTagTabBarDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
}
#pragma mark - InsTagBarDelegate
- (void)addButtonClick:(nonnull DiNTagTabBar *)tabBar {
    if (self.insTagTabBarDelegate && [self.insTagTabBarDelegate respondsToSelector:@selector(addButtonClick:)]) {
        [self.insTagTabBarDelegate addButtonClick:self];
    }
    
}
@end
