

#import <UIKit/UIKit.h>

@interface UIView(setFrame)

@property (nonatomic, assign) CGFloat x; // =frameX
@property (nonatomic, assign) CGFloat y; // =frameY
@property (nonatomic, assign) CGFloat left; // =frameX
@property (nonatomic, assign) CGFloat right; // =frameXAndWidth
@property (nonatomic, assign) CGFloat top; // =frameY
@property (nonatomic, assign) CGFloat bottom; // =frameYAndHeight
@property (nonatomic, assign) CGPoint origin; // =frameOrigin
@property (nonatomic, assign) CGFloat width; // =frameWidth
@property (nonatomic, assign) CGFloat height; // =frameHeight
@property (nonatomic, assign) CGSize size; // =frameSize

@property (nonatomic, assign) CGFloat frameX;
@property (nonatomic, assign) CGFloat frameY;
@property (nonatomic, assign) CGPoint frameOrigin;
@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;
@property (nonatomic, assign) CGSize frameSize;

@property (nonatomic, assign) CGFloat frameXAndWidth;
@property (nonatomic, assign) CGFloat frameYAndHeight;

@property (nonatomic, readonly) CGPoint boundsCenter;
@property (nonatomic, readonly) CGFloat boundsCenterX;
@property (nonatomic, readonly) CGFloat boundsCenterY;
@property (nonatomic, readonly) CGFloat boundsX;
@property (nonatomic, readonly) CGFloat boundsY;
@property (nonatomic, readonly) CGFloat boundsWidth;
@property (nonatomic, readonly) CGFloat boundsHeight;
@property (nonatomic, assign) CGSize boundsSize;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint leftTop;
@property (nonatomic, assign) CGPoint leftCenter;
@property (nonatomic, assign) CGPoint leftBottom;
@property (nonatomic, assign) CGPoint topCenter;
@property (nonatomic, assign) CGPoint bottomCenter;
@property (nonatomic, assign) CGPoint rightTop;
@property (nonatomic, assign) CGPoint rightCenter;
@property (nonatomic, assign) CGPoint rightBottom;

@end
