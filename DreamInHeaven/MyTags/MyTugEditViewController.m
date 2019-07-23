//
//  MyTugEditViewController.m
//  InsTags
//
//  Created by 111 on 2019/6/11.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "MyTugEditViewController.h"
#import "UIView+quickLayoutInit.h"
#import "FNTFoundation.h"
#import "Const.h"
#import "SVProgressHUD.h"
#import "DiNTugsStorageManager.h"

@interface MyTugEditViewController ()
@property (nonatomic, copy) TagModelItem *modelItem;
@property (nonatomic, strong) UITextView *editTagTextView;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation MyTugEditViewController
- (instancetype)initWithModelItem:(TagModelItem *)modeItem{
    self = [super init];
    if (self) {
        self.modelItem = modeItem;
    }
    return self;
    
}
- (void)loadView{
    
    [super loadView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_panGes)];
    [self.view addGestureRecognizer:pan];
    
    self.editTagTextView = [[UITextView alloc] init];
    self.editTagTextView.font = TagContentFont;
    self.editTagTextView.textColor = Color_53;
    self.editTagTextView.layer.borderColor = C_RGB(0xe4e4e4).CGColor;
    self.editTagTextView.layer.borderWidth = 1;
    [self.view addSubview:self.editTagTextView];
    
    self.saveButton = [[UIButton alloc] init];
    [self.saveButton addTarget:self action:@selector(_saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitle:@"save" forState:UIControlStateNormal];
    [self.saveButton setBackgroundColor:C_RGB(0x46bc7c)];
    self.saveButton.layer.cornerRadius = 4;
    [self.view addSubview:self.saveButton];
    
    [self _layoutSubViews];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(_back)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.title = @"Edit Tags";
    self.editTagTextView.text = self.modelItem.content;
    self.view.backgroundColor = C_RGB(0xffffff);
    
}
- (void)_panGes{
    
    [self.editTagTextView resignFirstResponder];
}
- (void)_layoutSubViews{
    
    [self.editTagTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(20 + 64);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(200);
        
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.editTagTextView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(40);
    }];
}

- (void)_saveButtonClick:(UIButton *)sender{
    
    if (self.saveButtonClickBlock) {
        self.modelItem.content = self.editTagTextView.text;
        self.saveButtonClickBlock(self.modelItem);
    }
    [SVProgressHUD showWithStatus:@"saving..."];
    [[DiNTugsStorageManager manager] addTagModelItem:self.modelItem];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self _back];
    });
}

- (void)_back{
    
    [self.navigationController popViewControllerAnimated:YES];
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
