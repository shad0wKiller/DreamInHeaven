//
//  TagListCollectionViewController.m
//  InsTags
//
//  Created by 111 on 2019/6/6.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "TagListCollectionViewController.h"
#import "TagListCollectionViewCell.h"
#import "FNTFoundation.h"
#import <AFNetworking.h>
#import "NSObject+YYModel.h"
#import "UIView+setFrame.h"
#import "TagModelItem.h"
#import "SVProgressHUD.h"
#import "NSObject+YYModel.h"
#import "DiNTugsStorageManager.h"
#import "DiNTugsShareManager.h"

@interface TagListCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, TagListCollectionViewCellDelegate>
@property (nonatomic, copy) NSString *tagId;
@property (nonatomic, strong) NSArray <TagModelItem *> *tagList;
@property (nonatomic, strong) NSMutableArray <TagModelItem *> *collectionTagIdList;
@end

@implementation TagListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)initWithTagId:(NSString *)tagId{
    
    //创建一个流式布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置每个cell间的最小水平间距
    layout.minimumInteritemSpacing = 0;
    //设置每个cell间的行间距
    layout.minimumLineSpacing = 10;
    //设置每一组距离四周的内边距
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    layout.estimatedItemSize = CGSizeMake(ScreenWidth-20, 100.0);
    
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        self.tagId = tagId;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(_back)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = C_RGB(0xF3F3F3);
    // Register cell classes
    [self.collectionView registerClass:[TagListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self _requestData];
    // Do any additional setup after loading the view.
}
- (void)_back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)_requestData{
    
    NSString *name = [NSString stringWithFormat:@"tag_list_%@",self.tagId];
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dataObject = [responseObject objectForKey:@"data"];
    if (dataObject) {
        NSArray *dataList = [dataObject objectForKey:@"list"];
        if (dataList.count) {
            NSMutableArray *tempTagList = [[NSMutableArray alloc] initWithCapacity:dataList.count];
            [[dataObject objectForKey:@"list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TagModelItem *modelItem = [TagModelItem yy_modelWithDictionary:obj];
                [tempTagList addObject:modelItem];
            }];
            self.tagList = [tempTagList copy];
            [self.collectionView reloadData];
            [SVProgressHUD dismiss];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }
}

- (void)_requestDataFromRemote{
    
    WEAKREF(self);
    NSString *url = [NSString stringWithFormat:@"",self.tagId];
    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dataObject = [responseObject objectForKey:@"data"];
        if (dataObject) {
            NSArray *dataList = [dataObject objectForKey:@"list"];
            if (dataList.count) {
                NSMutableArray *tempTagList = [[NSMutableArray alloc] initWithCapacity:dataList.count];
                [[dataObject objectForKey:@"list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    TagModelItem *modelItem = [TagModelItem yy_modelWithDictionary:obj];
                    [tempTagList addObject:modelItem];
                }];
                self.tagList = [tempTagList copy];
                [wself.collectionView reloadData];
                [SVProgressHUD dismiss];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"加载失败"];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    TagModelItem *modelItem = [self.tagList objectAtIndex:indexPath.item];
    cell.name = modelItem.name;
    cell.content = modelItem.content;
    cell.tag_num = modelItem.tag_num;
    cell.delegate = self;
    [cell showSeletedState:[[DiNTugsStorageManager manager] hasStoredForModeItem:modelItem]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(CellWidth, CellHeight);
//}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/
#pragma mark -
- (void)cell:(TagListCollectionViewCell *)cell clickCopeButtonAtIndex:(NSInteger)index{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TagModelItem *modelItem = [self.tagList objectAtIndex:indexPath.item];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = modelItem.content;

    [SVProgressHUD showImage:nil status:@"Tag was copied to Clipboard"];
    
}
- (void)cell:(TagListCollectionViewCell *)cell clickPhotoButtonAtIndex:(NSInteger)index{
    
    [SVProgressHUD showImage:nil status:@"Tag was copied to Clipboard \n Paste tag into Instagram Caption box to show"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DiNTugsShareManager PostShareToInstagram:@""];
    });
}
- (void)cell:(TagListCollectionViewCell *)cell clickfavourateButtonAtIndex:(NSInteger)index{
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TagModelItem *modelItem = [self.tagList objectAtIndex:indexPath.item];
    
    if ([[DiNTugsStorageManager manager] hasStoredForModeItem:modelItem]) {
//        [[InsTagsStorageManager manager] removeTagModelItem:modelItem];
        [SVProgressHUD showImage:nil status:@"has favorited"];
    }else{
        [[DiNTugsStorageManager manager] addTagModelItem:modelItem];
    }
    
#ifdef DEBUG
    [[[DiNTugsStorageManager manager] allTagsHasStored] enumerateObjectsUsingBlock:^(TagModelItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"---------%@", [obj yy_modelToJSONObject]);
    }];
#endif
    
    
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}
@end
