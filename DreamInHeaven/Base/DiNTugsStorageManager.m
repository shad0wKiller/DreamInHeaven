//
//  InsTagsStorageManager.m
//  InsTags
//
//  Created by 111 on 2019/6/10.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DiNTugsStorageManager.h"
#import "SynthesizeSingleton.h"
#import "TagModelItem.h"
#import "NSObject+YYModel.h"

#define kTAGMODELLISTSTORAGEKEY @"tagModelItemStrorageKey"

#define STORAGE_ID(__TYPEID__,__TAGID__)    \
[NSString stringWithFormat:@"%@_%@", @(__TYPEID__),@(__TAGID__)]\

#define TAG_MODELITEM_STORAGE_ID(__MODELITEM__)    \
[NSString stringWithFormat:@"%@_%@", @(__MODELITEM__.type_id),@(__MODELITEM__.id)]\

#define STORAGE_OBJ_FROM_ITEM(__MODELITEM__)    \
[__MODELITEM__ yy_modelToJSONObject]\

#define TAG_MODEL_ITEM_FROM_JSONOBJ(__JSONOBJ__) [TagModelItem yy_modelWithDictionary:__JSONOBJ__]\

@implementation DiNTugsStorageManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DiNTugsStorageManager);
+ (DiNTugsStorageManager *) manager{

    return [self.class sharedInstance];
}
+ (NSString *)storageId:(TagModelItem *)modelItem{
    
    return [NSString stringWithFormat:@"%@_%@", @(modelItem.type_id),@(modelItem.id)];
}
- (void)addTagModelItem:(TagModelItem *)modelItem{
    if (modelItem && [modelItem isKindOfClass:TagModelItem.class]) {
        [[NSUserDefaults standardUserDefaults] setObject:STORAGE_OBJ_FROM_ITEM(modelItem) forKey:TAG_MODELITEM_STORAGE_ID(modelItem)];
        NSArray *oldList = [self allTagIdsHasStored];
        NSMutableArray *muArray = [NSMutableArray arrayWithArray:oldList?:@[]];
        if (![muArray containsObject:TAG_MODELITEM_STORAGE_ID(modelItem)]) {
            [muArray addObject:TAG_MODELITEM_STORAGE_ID(modelItem)];
            [[NSUserDefaults standardUserDefaults] setObject:[muArray copy] forKey:kTAGMODELLISTSTORAGEKEY];

        }
    }
}
- (void)removeTagModelItem:(TagModelItem *)modelItem{
    if (modelItem && [modelItem isKindOfClass:TagModelItem.class]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:TAG_MODELITEM_STORAGE_ID(modelItem)]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:TAG_MODELITEM_STORAGE_ID(modelItem)];
            NSArray *oldList = [self allTagIdsHasStored];
            NSMutableArray *muArray = [NSMutableArray arrayWithArray:oldList];
            [muArray removeObject:TAG_MODELITEM_STORAGE_ID(modelItem)];
            [[NSUserDefaults standardUserDefaults] setObject:[muArray copy] forKey:kTAGMODELLISTSTORAGEKEY];
        }
    }
}

- (BOOL)hasStoredForTypeId:(NSInteger)typeId andTagId:(NSInteger)tagId{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:STORAGE_ID(typeId, tagId)] ? YES : NO;
}
- (BOOL)hasStoredForModeItem:(TagModelItem *)modelItem{
    return [[NSUserDefaults standardUserDefaults] objectForKey:TAG_MODELITEM_STORAGE_ID(modelItem)] ? YES : NO;
}

- (TagModelItem *)tagModelItemForTypeId:(NSInteger)typeId andTagId:(NSInteger)tagId{
    
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:STORAGE_ID(typeId, tagId)];
    if (obj && [obj isKindOfClass:NSDictionary.class]) {
        return TAG_MODEL_ITEM_FROM_JSONOBJ(obj);
    }
    return nil;
}

- (NSArray <NSString *> *)allTagIdsHasStored{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kTAGMODELLISTSTORAGEKEY];
}

- (NSArray <TagModelItem *> *)allTagsHasStored{
    
    NSArray <NSString *> *ids = [self allTagIdsHasStored];
    if (ids.count) {
        __block NSMutableArray *tagItems = [NSMutableArray arrayWithCapacity:ids.count];
        [ids enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id tagObj = [[NSUserDefaults standardUserDefaults] objectForKey:obj];
            if (tagObj && [tagObj isKindOfClass:NSDictionary.class]) {
                TagModelItem *item = [TagModelItem yy_modelWithDictionary:tagObj];
                [tagItems addObject:item];
            }
        }];
        return tagItems;
    }
    return nil;
}
@end
