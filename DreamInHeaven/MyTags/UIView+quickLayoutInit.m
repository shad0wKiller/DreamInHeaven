
#import "UIView+quickLayoutInit.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "UIColor+QuickInit.h"
#import "UIButton+Block.h"

@interface __AutoLayoutButton : UIButton

@end

@implementation __AutoLayoutButton

- (CGSize) intrinsicContentSize {
    
    CGSize s = [super intrinsicContentSize];
    
    return CGSizeMake(s.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right,
                      s.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom);
    
}

@end

@implementation UIView (quickLayoutInit)

- (UILabel*)addLabelWithFont:(UIFont *)font
                       color:(UIColor*)color
                       lines:(NSInteger)lines
                        text:(NSString *)text
                  constraint:(void(^)(MASConstraintMaker *make))block
{
    UILabel *lbl = [[UILabel alloc] init];
    [self addSubview:lbl];
    lbl.font = font;
    if (color)
    {
        lbl.textColor = color;
    }
    if (block)
    {
        [lbl mas_makeConstraints:block];
    }
    lbl.numberOfLines = lines;
    if (text.length)
    {
        lbl.text = text;
    }
    return lbl;
}


- (UILabel*)addLabelWithFontSize:(NSInteger)fontSize
                           color:(UIColor*)color
                           lines:(NSInteger)lines
                            text:(NSString *)text
                      constraint:(void(^)(MASConstraintMaker *make))block
{
    UILabel *lbl = [[UILabel alloc] init];
    [self addSubview:lbl];
    lbl.font = [UIFont systemFontOfSize:fontSize];
    if (color)
    {
        lbl.textColor = color;
    }
    if (block)
    {
        [lbl mas_makeConstraints:block];
    }
    lbl.numberOfLines = lines;
    if (text.length)
    {
        lbl.text = text;
    }
    return lbl;
}

- (UIImageView*)addImageViewWithConstraint:(void(^)(MASConstraintMaker *make))block
{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
    
    if (block)
    {
        [imageView mas_makeConstraints:block];
    }
    return imageView;
}

- (UIImageView*)addImageViewWithImage:(UIImage*)image
                           constraint:(void(^)(MASConstraintMaker *make))block
{
    UIImageView *imageView = [self addImageViewWithConstraint:block];
    if (image)
    {
        imageView.image = image;
    }
    return imageView;
}

- (UIImageView*)addImageViewWithImageName:(NSString *)imageName
                               constraint:(void (^)(MASConstraintMaker *))block
{
    UIImageView *imageView = [self addImageViewWithConstraint:block];
    if (imageName.length)
    {
        imageView.image = [UIImage imageNamed:imageName];
    }
    return imageView;
}

- (UIImageView*)addImageViewWithImageURL:(NSString *)aUrl
                              constraint:(void (^)(MASConstraintMaker *))block
{
    UIImageView *imageView = [self addImageViewWithConstraint:block];
    if (aUrl.length)
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:aUrl]];
    }
    return imageView;
}

- (UIControl*)addControlWithConstraint:(void(^)(MASConstraintMaker *make))block
{
    UIControl *ctrl = [[UIControl alloc] init];
    [self addSubview:ctrl];
    if (block) {
        [ctrl mas_makeConstraints:block];
    }
    return ctrl;
}

- (UIControl*)addControlWithOnClick:(void(^)())onClick
                         constraint:(void(^)(MASConstraintMaker *make))block
{
    UIControl *ctrl = [[UIControl alloc] init];
    if (onClick) {
        [ctrl setOnClick:^(__kindof UIControl *c) {
            onClick();
        }];
    }
    [self addSubview:ctrl];
    if (block) {
        [ctrl mas_makeConstraints:block];
    }
    return ctrl;
}

- (UIButton*)addButtonWithTitle:(NSString*)title
                          color:(UIColor *)color
                        onClick:(void(^)())onClick
                     constraint:(void(^)(MASConstraintMaker *make))block
{
    UIButton *btn = [[__AutoLayoutButton alloc] init];
    if (title)
    {
        [btn setTitle:title forState:0];
    }
    if (color)
    {
        [btn setTitleColor:color forState:0];
    }
    if (onClick) {
        [btn setOnClick:^(__kindof UIControl *c) {
            onClick();
        }];
    }
    [self addSubview:btn];
    if (block) {
        [btn mas_makeConstraints:block];
    }
    return btn;
}

- (UIButton*)addButtonWithConstraint:(void(^)(MASConstraintMaker *make))block
{
    UIButton *btn = [[__AutoLayoutButton alloc] init];
    [self addSubview:btn];
    if (block) {
        [btn mas_makeConstraints:block];
    }
    return btn;
}

- (UIButton*)addButtonWithImage:(UIImage*)image
                        onClick:(void(^)())onClick
                     constraint:(void(^)(MASConstraintMaker *make))block
{
    UIButton *btn = [[__AutoLayoutButton alloc] init];
    if (onClick) {
        [btn setOnClick:^(__kindof UIControl *c) {
            onClick();
        }];
    }
    [btn setImage:image forState:0];
    [self addSubview:btn];
    if (block) {
        [btn mas_makeConstraints:block];
    }
    return btn;
}

- (UIButton*)addButtonWithUrl:(NSString*)url
                      onClick:(void(^)())onClick
                   constraint:(void(^)(MASConstraintMaker *make))block
{
    UIButton *btn = [[__AutoLayoutButton alloc] init];
    if (onClick) {
        [btn setOnClick:^(__kindof UIControl *c) {
            onClick();
        }];
    }
    [btn sd_setImageWithURL:[NSURL URLWithString:url] forState:0];
    
    [self addSubview:btn];
    if (block) {
        [btn mas_makeConstraints:block];
    }
    return btn;
}

- (UIButton *)addButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)color image:(UIImage *)image imageSize:(CGSize)imageSize horizontalGapBetweenImageAndTitle:(CGFloat)hGap isImageLeft:(BOOL)isImageLeft contentInsets:(UIEdgeInsets)contentInsets onClick:(void (^)())onClick constraint:(void (^)(MASConstraintMaker *make))block
{
    UIButton *btn = [[__AutoLayoutButton alloc] init];
    [self addSubview:btn];
    if (onClick) {
        [btn setOnClick:^(__kindof UIControl *c) {
            onClick();
        }];
    }
    [btn setImage:image forState:0];
    [btn setTitle:title forState:0];
    [btn setTitleColor:color forState:0];
    btn.adjustsImageWhenHighlighted = NO;
    
    if (fontSize != 0) {
        btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    }
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:btn.titleLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGRect labelTitleRect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    
    CGFloat width = contentInsets.left + imageSize.width + hGap + CGRectGetWidth(labelTitleRect) + contentInsets.right;
    CGFloat height = MAX(imageSize.height, CGRectGetHeight(labelTitleRect)) + contentInsets.top + contentInsets.bottom;
    
    if (isImageLeft) {
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(contentInsets.top, contentInsets.left, contentInsets.bottom, contentInsets.right + hGap);
        btn.titleEdgeInsets = UIEdgeInsetsMake(contentInsets.top, contentInsets.left + hGap, contentInsets.bottom, contentInsets.right);
    } else {
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(contentInsets.top, width - imageSize.width -  contentInsets.right, contentInsets.bottom, contentInsets.right);
        btn.titleEdgeInsets = UIEdgeInsetsMake(contentInsets.top, contentInsets.left - hGap, contentInsets.bottom, contentInsets.right + hGap + imageSize.width);
    }
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
    if (block) {
        [btn mas_updateConstraints:block];
    }
    
    return btn;
}

- (UIView*)addViewWithColor:(UIColor*)color
                 constraint:(void(^)(MASConstraintMaker *make))block
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = color;
    [self addSubview:v];
    if (block) {
        [v mas_makeConstraints:block];
    }
    return v;
}

- (UIView *)addFooterLineViewWithConstraint:(void(^)(MASConstraintMaker *make))block
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = C_RGB(0XF6F7F9);
    [self addSubview:v];
    if (block) {
        [v mas_makeConstraints:block];
    }
    return v;
}


- (id)addSubviewClass:(Class)classs
           constraint:(void (^)(MASConstraintMaker *))block
{
    return [self addSubviewClass:classs initialFrame:CGRectZero constraint:block];
}

- (id)addSubviewClass:(Class)classs
         initialFrame:(CGRect)initialFrame
           constraint:(void (^)(MASConstraintMaker *))block
{
    NSAssert([classs isSubclassOfClass:[UIView class]], @"必须是UIView或子类");
    
    if (![classs isSubclassOfClass:[UIView class]]
        && classs != [UIView class])
    {
        return nil;
    }
    UIView *view = [[classs alloc] initWithFrame:initialFrame];
    [self addSubview:view];
    if (block)
    {
        [view mas_makeConstraints:block];
    }
    return view;
}

@end
