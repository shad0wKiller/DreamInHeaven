//
//  SecondViewController.h
//  InsTags
//
//  Created by 111 on 2019/6/3.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DinMyTugViewController : UIViewController
@property (nonatomic, strong) UICollectionView *collectionView;
- (instancetype)initWith:(NSString *)imagePath;
@end

