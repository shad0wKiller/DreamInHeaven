//
//  FirstViewController.m
//  InsTags
//
//  Created by 111 on 2019/6/3.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "DiNHusTugViewController.h"
#import "FNTFoundation.h"
#import "UIView+quickLayoutInit.h"
#import "UIView+setFrame.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/NSObject+YYModel.h>
#import "UIImageView+WebCache.h"
#import "HasTagTypeModel.h"
#import "NSObject+YYModel.h"
#import "TagListCollectionViewController.h"
#import "SVProgressHUD.h"

#define CellSpace 8
#define CellCount 3
#define CellWidth (ScreenWidth - CellSpace * (CellCount - 1))/3
#define CellHeight CellWidth

@interface IconCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation IconCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_configSubViews];
    }
    return self;
}

- (void)p_configSubViews {
    WEAKREF(self);
    self.backgroundColor = C_RGB(0xffffff);
    
    _iconView = [self addImageViewWithImage:nil
                                 constraint:^(MASConstraintMaker *make) {
                                     make.centerX.mas_equalTo(wself.mas_centerX);
                                     make.centerY.mas_equalTo(wself.centerY).offset(-10);
                                     make.width.height.mas_equalTo(wself.mas_width).multipliedBy(0.7);
                                 }];
    _titleLabel = [self addLabelWithFont:[UIFont systemFontOfSize:14]
                                   color:C_RGB(0x111111)
                                   lines:0 text:@""
                              constraint:^(MASConstraintMaker *make) {
                                  make.bottom.mas_equalTo(wself.mas_bottom).offset(-5);
                                  make.width.mas_equalTo(wself.mas_width);
                              }];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
}
- (void)setIconUrl:(NSString *)iconUrl andTitle:(NSString *)title{
    
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:iconUrl]];
    [_iconView setImage:[UIImage imageNamed:iconUrl]];
    [_titleLabel setText:title];
}

@end

@interface DiNHusTugViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSArray *tagTypeList;
@property (nonatomic, strong) UIView *emptyView;
@property (nonatomic, strong) UIButton *reloadButton;
@end

@implementation DiNHusTugViewController

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"HasTags";
    _myCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = CellSpace;
        layout.minimumLineSpacing = CellSpace;
        layout;
    })];
    _myCollectionView.backgroundColor = C_RGB(0xF3F3F3);
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [self.view addSubview:_myCollectionView];
    [_myCollectionView registerClass:[IconCollectionViewCell class] forCellWithReuseIdentifier:@"iconIdentifier"];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setMaximumDismissTimeInterval:1.0f];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    WEAKREF(self);
    self.reloadButton = [self.view addButtonWithTitle:@"重新加载" color:C_RGB(0xa4a4a4) onClick:^{
        wself.reloadButton.hidden = YES;
        [wself _requestData];
    } constraint:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(wself.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(200);
    }];
    self.reloadButton.hidden = YES;
    
    [self _requestData];
}

- (void)_requestData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tag_type_list" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dataObject = [responseObject objectForKey:@"data"];
    if (dataObject) {
        NSArray *dataList = [dataObject objectForKey:@"list"];
        if (dataList.count) {
            NSMutableArray *tempTagTypeList = [NSMutableArray arrayWithCapacity:dataList.count];
            [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                HasTagTypeModel *modelItem = [HasTagTypeModel yy_modelWithDictionary:obj];
                [tempTagTypeList addObject:modelItem];
            }];
            self.tagTypeList = [tempTagTypeList copy];
            [self.myCollectionView reloadData];
            [SVProgressHUD dismiss];
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        self.reloadButton.hidden = NO;
    }
}

- (void)_requestDataFromRemote{
    
    WEAKREF(self);
    [[AFHTTPSessionManager manager] GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dataObject = [responseObject objectForKey:@"data"];
        if (dataObject) {
            NSArray *dataList = [dataObject objectForKey:@"list"];
            if (dataList.count) {
                NSMutableArray *tempTagTypeList = [NSMutableArray arrayWithCapacity:dataList.count];
                [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    HasTagTypeModel *modelItem = [HasTagTypeModel yy_modelWithDictionary:obj];
                    [tempTagTypeList addObject:modelItem];
                }];
                self.tagTypeList = [tempTagTypeList copy];
                [wself.myCollectionView reloadData];
                [SVProgressHUD dismiss];
            }
        }else{
            [SVProgressHUD showErrorWithStatus:@"加载失败"];
            self.reloadButton.hidden = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        self.reloadButton.hidden = NO;
    }];
}

#pragma mark - UICollectionView delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CellWidth, CellHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tagTypeList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"iconIdentifier" forIndexPath:indexPath];
    HasTagTypeModel *tagTypeItem = self.tagTypeList[indexPath.item];
    NSString *iconUrl = tagTypeItem.url;
    NSString *title = [NSString stringWithFormat:@"# %@",tagTypeItem.name];
    [cell setIconUrl:iconUrl andTitle:title];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HasTagTypeModel *tagTypeItem = self.tagTypeList[indexPath.item];
    self.hidesBottomBarWhenPushed = YES;
    TagListCollectionViewController *tagListVC = [[TagListCollectionViewController alloc] initWithTagId:tagTypeItem.name];
    tagListVC.title = [NSString stringWithFormat:@"# %@",tagTypeItem.name];
    [self.navigationController pushViewController:tagListVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
@end
