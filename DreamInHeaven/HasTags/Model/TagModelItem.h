//
//  TagModelItem.h
//  InsTags
//
//  Created by 111 on 2019/6/9.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagModelItem : NSObject<NSCopying>
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSTimeInterval createtime;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger like_num;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger tag_num;
@property (nonatomic, assign) NSInteger type_id;
@end

NS_ASSUME_NONNULL_END
