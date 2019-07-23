//
//  TagListCollectionViewCell.h
//  InsTags
//
//  Created by 111 on 2019/6/6.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TagListCollectionViewCell;
@protocol TagListCollectionViewCellDelegate <NSObject, UITextViewDelegate>

- (void)cell:(TagListCollectionViewCell *)cell clickCopeButtonAtIndex:(NSInteger)index;
- (void)cell:(TagListCollectionViewCell *)cell clickPhotoButtonAtIndex:(NSInteger)index;
- (void)cell:(TagListCollectionViewCell *)cell clickfavourateButtonAtIndex:(NSInteger)index;

@end

@interface TagListCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id<TagListCollectionViewCellDelegate> delegate;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger tag_num;
@property (nonatomic, assign, readonly) BOOL showSelected;
- (void)showSeletedState:(BOOL)seleted;
@end

NS_ASSUME_NONNULL_END
