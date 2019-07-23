//
//  InsTagsStorageManager.h
//  InsTags
//
//  Created by 111 on 2019/6/10.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TagModelItem;
NS_ASSUME_NONNULL_BEGIN

@interface DiNTugsStorageManager : NSObject

+ (DiNTugsStorageManager *) manager;

- (void)addTagModelItem:(TagModelItem *)modelItem;
- (void)removeTagModelItem:(TagModelItem *)modelItem;
- (BOOL)hasStoredForTypeId:(NSInteger)typeId andTagId:(NSInteger)tagId;
- (BOOL)hasStoredForModeItem:(TagModelItem *)modelItem;

- (TagModelItem *)tagModelItemForTypeId:(NSInteger)typeId andTagId:(NSInteger)tagId;

- (NSArray <TagModelItem *> *)allTagsHasStored;

@end

NS_ASSUME_NONNULL_END
