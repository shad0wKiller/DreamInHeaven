//
//  SecondViewController.m
//  InsTags
//
//  Created by 111 on 2019/6/3.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DinMyTugViewController.h"
#import "FNTFoundation.h"
#import "SVProgressHUD.h"
#import "TagListCollectionViewCell.h"
#import "DiNTugsStorageManager.h"
#import "TagModelItem.h"
#import "NSObject+YYModel.h"
#import "MyTugEditViewController.h"
#import "DiNTugsShareManager.h"
#import "UIView+quickLayoutInit.h"
#import "UIView+setFrame.h"

@interface DinMyTugViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, TagListCollectionViewCellDelegate>

@property (nonatomic, strong) NSArray <TagModelItem *> *tagList;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy) NSString *imagePath;
@end

@implementation DinMyTugViewController
static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWith:(NSString *)imagePath{
    
    self = [super init];
    if (self) {
        self.imagePath = imagePath;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MyTags";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(_back)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    // Do any additional setup after loading the view.
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:({
        //创建一个流式布局对象
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置每个cell间的最小水平间距
        layout.minimumInteritemSpacing = 0;
        //设置每个cell间的行间距
        layout.minimumLineSpacing = 10;
        //设置每一组距离四周的内边距
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
        layout.estimatedItemSize = CGSizeMake(ScreenWidth-20, 100.0);
        layout;
    })];
    _collectionView.backgroundColor = C_RGB(0xF3F3F3);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    self.collectionView.backgroundColor = C_RGB(0xF3F3F3);
    // Register cell classes
    [self.collectionView registerClass:[TagListCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    WEAKREF(self);
    self.reloadButton = [self.view addButtonWithTitle:@"Favorite tags please!" color:C_RGB(0xa4a4a4) onClick:^{
        [wself.tabBarController setSelectedIndex:0];
    } constraint:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(wself.view);
        make.height.mas_equalTo(wself.view.width);
        make.width.mas_equalTo(200);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData{
    
    self.tagList = [[DiNTugsStorageManager manager] allTagsHasStored];
    self.reloadButton.hidden = self.tagList.count;
    [self.collectionView reloadData];
}

- (void)_back{
    
    [self.navigationController popViewControllerAnimated:YES];
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
    UIButton *editButton = [cell valueForKeyPath:@"favourateButton"];
    if (editButton && [editButton isKindOfClass:[UIButton class]]) {
        [editButton setImage:[UIImage imageNamed:@"tag_edit"] forState:UIControlStateNormal];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DiNTugsShareManager PostShareToInstagram:self.imagePath];
    });
    
}
- (void)cell:(TagListCollectionViewCell *)cell clickfavourateButtonAtIndex:(NSInteger)index{
    self.hidesBottomBarWhenPushed = YES;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    TagModelItem *modelItem = [self.tagList objectAtIndex:indexPath.item];
    MyTugEditViewController *editVC = [[MyTugEditViewController alloc] initWithModelItem:modelItem];
    WEAKREF(self);
    WEAKREF(modelItem);
    [editVC setSaveButtonClickBlock:^(TagModelItem * _Nonnull modelItem) {
        wmodelItem.content = modelItem.content;
        [wself.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    [self.navigationController pushViewController:editVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
