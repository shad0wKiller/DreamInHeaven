
#import "UIButton+Block.h"
#import "NSObject+Associative.h"

@implementation UIControl(Block)
static const char UIControl_Block_Key;
- (void)setOnClick:(void (^)(__kindof UIControl *control))onClick
{
    NSInteger flag = 0;
    if(self.onClick)
    {
        flag -= 1;
        
    }
    if (onClick)
    {
        
        flag += 1;
    }
    [self setCopyNonatomicProperty:onClick byKey:&UIControl_Block_Key];
    
    switch (flag) {
        case -1:
            [self removeTarget:self
                        action:@selector(_UIControl_On_Click)
              forControlEvents:UIControlEventTouchUpInside];
            break;
        case 0:
            break;
        case 1:
        default:
            [self addTarget:self
                     action:@selector(_UIControl_On_Click)
           forControlEvents:UIControlEventTouchUpInside];
            break;
    }
    
}

- (void(^)(__kindof UIControl *control))onClick
{
    return [self getAssociativeValue:&UIControl_Block_Key];
}

- (void)_UIControl_On_Click
{
    if (self.onClick)
    {
        self.onClick(self);
    }
}

@end
