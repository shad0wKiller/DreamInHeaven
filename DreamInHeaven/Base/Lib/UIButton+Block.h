
#import <UIKit/UIKit.h>

@interface UIControl(Block)

@property (nonatomic, copy) void(^onClick)(__kindof UIControl *control);

@end
