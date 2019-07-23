//
//  InsTagsPhotoManager.m
//  InsTags
//
//  Created by 111 on 2019/6/13.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DiNTugsPhotoManager.h"
#import "SynthesizeSingleton.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DiNTugsPhotoManager ()

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *imagePath;

@end

@implementation DiNTugsPhotoManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DiNTugsPhotoManager);

+ (DiNTugsPhotoManager *) manager{
    
    return [DiNTugsPhotoManager sharedInstance];
}

- (void)savePhoto:(UIImage *)photo andAsset:(PHAsset *)asset andInfo:(NSDictionary *)info{
    
    [DiNTugsPhotoManager manager].photo = photo;
    NSString *filePath = [info valueForKey:@"PHImageFileSandboxExtensionTokenKey"];
    NSURL *filePathURL = [info valueForKey:@"PHImageFileURLKey"];
    if (filePathURL && filePathURL.absoluteString.length > 0) {
//        _imagePath = filePathURL.absoluteString;
        _imagePath = filePath;
    }
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"InsShare/pic.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
//    UIImageWriteToSavedPhotosAlbum(photo, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
//    [UIImagePNGRepresentation(photo) writeToFile:imagePath atomically:YES];
    [self createNewAlbumAndSavePhoto:photo];
//    _imagePath = imagePath;
}

#pragma mark 系统的完成保存图片的方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if (error != NULL) {
        msg = @"保存图片失败" ;
    } else {
        msg = @"保存图片成功" ;
    }
}

- (void)createNewAlbumAndSavePhoto:(UIImage *)photo{
    
    NSString *collectionTitle = @"InsTags";
    __block PHAssetCollection *collection = nil;
    PHFetchResult<PHAssetCollection *> *results =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *getCollection in results) {
        if ([getCollection.localizedTitle isEqualToString:collectionTitle]) {
            collection = getCollection;
        }
    }
    __block NSString *assetIdentifier = nil;
    __block NSString *collectionIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        if (!collection) {
            collectionIdentifier =  [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                if (!collection) {
                    collection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionIdentifier] options:nil].lastObject;
                }
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetIdentifier] options:nil].lastObject;
                PHAssetCollectionChangeRequest *requestCollection = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                // 添加进自定义的相册
                [requestCollection addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    
                }
            }];
        }
    }];
}

- (void)savePhotoOld:(UIImage *)photo{
    
    __block ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    
    NSDictionary *infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    if (!infoDict) {
        infoDict = [NSBundle mainBundle].infoDictionary;
    }
    NSString *appName = [infoDict valueForKey:@"CFBundleDisplayName"];
    if (!appName) appName = [infoDict valueForKey:@"CFBundleName"];
    
    [lib addAssetsGroupAlbumWithName:appName resultBlock:^(ALAssetsGroup *group) {
        [lib writeImageToSavedPhotosAlbum:photo.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            
                //assetURL即地址
            
                NSLog(@"assetURL = %@, error = %@", assetURL, error);
            
                //将地址存入字典中。可根据自己需要做其他操作
            
            _imagePath = assetURL.absoluteString;
            lib = nil;
            
        }];
        
    } failureBlock:^(NSError *error) {
        
    }];
}

@end
