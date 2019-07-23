//
//  TagListViewController.m
//  InsTags
//
//  Created by 111 on 2019/6/6.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "TagListViewController.h"

@interface TagListViewController ()
@property (nonatomic, copy) NSString *tagId;
@end

@implementation TagListViewController
- (instancetype)initWithTagId:(NSString *)tagId{
    
    self = [super init];
    if (self) {
        self.tagId = tagId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
