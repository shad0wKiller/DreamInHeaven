//
//  MyTugEditViewController.h
//  InsTags
//
//  Created by 111 on 2019/6/11.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModelItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyTugEditViewController : UIViewController

- (instancetype)initWithModelItem:(TagModelItem *)modeItem;
@property (nonatomic, copy) void(^saveButtonClickBlock)(TagModelItem *modelItem);
@end

NS_ASSUME_NONNULL_END
