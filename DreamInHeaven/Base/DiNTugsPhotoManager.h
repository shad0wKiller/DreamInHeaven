//
//  InsTagsPhotoManager.h
//  InsTags
//
//  Created by 111 on 2019/6/13.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PHAsset;
@interface DiNTugsPhotoManager : NSObject

+ (DiNTugsPhotoManager *) manager;

- (void)savePhoto:(UIImage *)photo andAsset:(PHAsset *)asset andInfo:(NSDictionary *)info;

- (void)savePhotoOld:(UIImage *)photo;
- (void)createNewAlbumAndSavePhoto:(UIImage *)photo;

@property (nonatomic, strong, readonly) UIImage *photo;
@property (nonatomic, strong, readonly) NSString *imagePath;
@end

NS_ASSUME_NONNULL_END
