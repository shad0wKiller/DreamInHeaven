//
//  EmptyIndicator.h
//

#import <UIKit/UIKit.h>
typedef void(^EmptyIndicatorTipContainerClick)();
@interface EmptyIndicator : UIView
@property(nonatomic, strong)NSString* emptyText;
@property(nonatomic, strong)NSString* failedText;
@property(nonatomic, strong)NSString *subTitleText;
@property(nonatomic, assign)CGFloat emptyOffsetTop; // 显示空信息时，显示区域的偏移（考虑tableview有header）
@property (nonatomic, readonly)UIControl *emptyViewTipContainer;
@end
