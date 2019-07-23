//
//  DiNHotTugViewController.m
//  DreamInHeaven
//
//  Created by 111 on 2019/7/23.
//  Copyright © 2019 ciwei. All rights reserved.
//

#import "DiNHotTugViewController.h"
#import "TagModelItem.h"
#import "HasTagTypeModel.h"
#import <YYModel/NSObject+YYModel.h>
@interface DiNHotTugViewController ()
@property (nonatomic, strong) NSArray <TagModelItem *> *tagList;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, strong) NSMutableArray *names;
@property (nonatomic, strong) NSMutableArray *typeIds;
@end

@implementation DiNHotTugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"HotTags";
    self.names = [NSMutableArray new];
    self.typeIds = [NSMutableArray new];
    self.reloadButton.hidden = YES;
    
    [self getNames];
    
}
- (void)reloadData{
    NSMutableArray *tempTagList = [[NSMutableArray alloc] init];
    [self.names enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = [NSString stringWithFormat:@"tag_list_%@",obj];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
        // 将文件数据化
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        // 对数据进行JSON格式化并返回字典形式
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSDictionary *dataObject = [responseObject objectForKey:@"data"];
        NSArray *dataList = [dataObject objectForKey:@"list"];
        if (dataList.count) {
            [[dataObject objectForKey:@"list"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TagModelItem *modelItem = [TagModelItem yy_modelWithDictionary:obj];
                [tempTagList addObject:modelItem];
            }];
        }
    }];
    self.tagList = [tempTagList copy];
    [self.collectionView reloadData];
}

- (void)getNames{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tag_type_list" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *dataObject = [responseObject objectForKey:@"data"];
    
    NSArray *dataList = [dataObject objectForKey:@"list"];
    if (dataList.count) {
        [dataList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HasTagTypeModel *modelItem = [HasTagTypeModel yy_modelWithDictionary:obj];
            [self.names addObject:modelItem.name];
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
