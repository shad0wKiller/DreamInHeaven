//
//  TagListCollectionViewCell.m
//  InsTags
//
//  Created by 111 on 2019/6/6.
//  Copyright © 2019 zhaoyg. All rights reserved.
//

#import "TagListCollectionViewCell.h"
#import "Const.h"
#import "UIView+setFrame.h"

#define BottomButtonImageWidth 27
#define SpaceBettwenView 10

@interface TagListCollectionViewCell ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *bodyView;
@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *divideLine;
@property (nonatomic, strong) UIButton *copeButton;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UIButton *favourateButton;

@property (nonatomic, assign) BOOL showSelected;
@end

@implementation TagListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        WEAKREF(self);
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 4;
        
        self.headerView = [self.contentView addViewWithColor:nil constraint:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wself);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        
        self.titleLabel = [self.headerView addLabelWithFontSize:22 color:nil lines:0 text:@"" constraint:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(wself.headerView);
            make.left.mas_equalTo(0);
        }];
        
        self.tagLabel = [self.headerView addLabelWithFontSize:16 color:C_RGB(0xffffff) lines:1 text:@"" constraint:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(wself.titleLabel.mas_centerY);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(25);
        }];
        self.tagLabel.backgroundColor = C_RGB(0x589cfb);
        self.tagLabel.clipsToBounds = YES;
        self.tagLabel.layer.cornerRadius = 12.5;
        
        self.contentLabel = [self.contentView addLabelWithFont:TagContentFont color:Color_53 lines:0 text:@"" constraint:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wself.headerView.mas_bottom).offset(SpaceBettwenView);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        self.divideLine = [self.contentView addFooterLineViewWithConstraint:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wself.contentLabel.mas_bottom).offset(SpaceBettwenView);
            make.left.right.mas_equalTo(wself.contentLabel);
            make.height.mas_equalTo(1);
        }];
        self.footerView = [self.contentView addViewWithColor:nil constraint:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(wself.divideLine.mas_bottom);
            make.height.mas_equalTo(BottomButtonImageWidth * 2);
        }];

        self.copeButton = [self.footerView addButtonWithImage:[UIImage imageNamed:@"tag_copy"] onClick:^{
            
            [wself _bottomButtonClick:wself.copeButton];
            
        } constraint:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(wself.footerView);
            make.left.mas_equalTo(0);
        }];
        
        self.photoButton = [self.footerView addButtonWithImage:[UIImage imageNamed:@"tag_ins"] onClick:^{
            
            [wself _bottomButtonClick:wself.photoButton];
            
        } constraint:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(wself.footerView.mas_centerX);
            make.centerY.mas_equalTo(wself.copeButton);
        }];
        
        self.favourateButton = [self.footerView addButtonWithImage:[UIImage imageNamed:@"tag_like"] onClick:^{
            
            [wself _bottomButtonClick:wself.favourateButton];
            
        } constraint:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(wself.copeButton);
            make.right.mas_equalTo(0);
        }];
        [self.favourateButton setImage:[UIImage imageNamed:@"tag_liked"] forState:UIControlStateSelected];
        
        [@[self.copeButton, self.photoButton, self.favourateButton] enumerateObjectsUsingBlock:^(UIButton *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.tag = idx;
        }];
        
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
}
- (void)showSeletedState:(BOOL)seleted{
    _showSelected = seleted;
    self.favourateButton.selected = seleted;
}
#pragma mark - Setter

- (void)setName:(NSString *)name{
    
    _name = name;
    self.titleLabel.text = name;
}

- (void)setContent:(NSString *)content{
    _content = content;
    self.contentLabel.text = content;
}

- (void)setTag_num:(NSInteger)tag_num{
    _tag_num = tag_num;
    self.tagLabel.text = [NSString stringWithFormat:@" %ld Tags ", (long)tag_num];
}

- (void)_bottomButtonClick:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cell:clickCopeButtonAtIndex:)]) {
                [self.delegate cell:self clickCopeButtonAtIndex:sender.tag];
            }
        }
            break;
        case 1:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cell:clickPhotoButtonAtIndex:)]) {
                [self.delegate cell:self clickPhotoButtonAtIndex:sender.tag];
            }
        }
            break;
        case 2:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(cell:clickfavourateButtonAtIndex:)]) {
                [self.delegate cell:self clickfavourateButtonAtIndex:sender.tag];
            }
        }
            break;
            
        default:
            break;
    }
    
}
-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height= self.footerView.bottom;
    layoutAttributes.frame= cellFrame;
    return layoutAttributes;
}
@end
