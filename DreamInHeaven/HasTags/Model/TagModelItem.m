//
//  TagModelItem.m
//  InsTags
//
//  Created by 111 on 2019/6/9.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "TagModelItem.h"

@implementation TagModelItem
- (id)copyWithZone:(NSZone *)zone {
    TagModelItem *instance = [[TagModelItem alloc] init];
    if (instance) {
        instance.content = [self.content copyWithZone:zone];
        instance.createtime = self.createtime;
        instance.id = self.id;
        instance.like_num = self.like_num;
        instance.name = [self.name copyWithZone:zone];
        instance.type_id = self.type_id;
        instance.tag_num = self.tag_num;
    }
    return instance;
}
@end
