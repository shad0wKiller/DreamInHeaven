
#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (quickLayoutInit)

// label
- (UILabel*)addLabelWithFont:(UIFont *)font
                       color:(UIColor*)color
                       lines:(NSInteger)lines
                        text:(NSString *)text
                  constraint:(void(^)(MASConstraintMaker *make))block;

- (UILabel*)addLabelWithFontSize:(NSInteger)fontSize
                           color:(UIColor*)color
                           lines:(NSInteger)lines
                            text:(NSString*)text
                      constraint:(void(^)(MASConstraintMaker *make))block;

// image
- (UIImageView*)addImageViewWithImage:(UIImage*)image
                           constraint:(void(^)(MASConstraintMaker *make))block;
- (UIImageView*)addImageViewWithImageName:(NSString*)imageName
                               constraint:(void(^)(MASConstraintMaker *make))block;
- (UIImageView*)addImageViewWithImageURL:(NSString*)aUrl
                              constraint:(void(^)(MASConstraintMaker *make))block;
- (UIImageView*)addImageViewWithConstraint:(void(^)(MASConstraintMaker *make))block;

// control
- (UIControl*)addControlWithConstraint:(void(^)(MASConstraintMaker *make))block;
- (UIControl*)addControlWithOnClick:(void(^)())onClick
                         constraint:(void(^)(MASConstraintMaker *make))block;

// button
- (UIButton*)addButtonWithTitle:(NSString*)title
                          color:(UIColor*)color
                        onClick:(void(^)())onClick
                     constraint:(void(^)(MASConstraintMaker *make))block;

- (UIButton*)addButtonWithImage:(UIImage*)image
                        onClick:(void(^)())onClick
                     constraint:(void(^)(MASConstraintMaker *make))block;

- (UIButton*)addButtonWithUrl:(NSString*)url
                      onClick:(void(^)())onClick
                   constraint:(void(^)(MASConstraintMaker *make))block;

- (UIButton*)addButtonWithConstraint:(void(^)(MASConstraintMaker *make))block;
// @param fontsize = 0 use default size
// @param contentInsets : insets of title and image as a whole
- (UIButton *)addButtonWithTitle:(NSString *)title fontSize:(CGFloat)fontSize color:(UIColor *)color image:(UIImage *)image imageSize:(CGSize)imageSize horizontalGapBetweenImageAndTitle:(CGFloat)hGap isImageLeft:(BOOL)isImageLeft contentInsets:(UIEdgeInsets)contentInsets onClick:(void (^)())onClick constraint:(void (^)(MASConstraintMaker *make))block;

// view
- (UIView*)addViewWithColor:(UIColor*)color
                 constraint:(void(^)(MASConstraintMaker *make))block;

- (UIView *)addFooterLineViewWithConstraint:(void(^)(MASConstraintMaker *make))block;

// 通用
- (id)addSubviewClass:(Class)classs
           constraint:(void(^)(MASConstraintMaker *make))block;
- (id)addSubviewClass:(Class)classs
         initialFrame:(CGRect)initialFrame
           constraint:(void (^)(MASConstraintMaker *))block;

@end


