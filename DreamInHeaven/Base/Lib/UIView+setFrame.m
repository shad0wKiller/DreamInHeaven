
#import "UIView+setFrame.h"

@implementation UIView(setFrame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

///

- (void)setFrameX:(CGFloat)frameX
{
    CGRect frame = self.frame;
    frame.origin.x = frameX;
    self.frame = frame;
}

- (CGFloat)frameX
{
    return self.frame.origin.x;
}

- (void)setFrameY:(CGFloat)frameY
{
    CGRect frame = self.frame;
    frame.origin.y = frameY;
    self.frame = frame;
}

- (CGFloat)frameY
{
    return self.frame.origin.y;
}

- (void)setFrameWidth:(CGFloat)frameWidth
{
    CGRect frame = self.frame;
    frame.size.width = frameWidth;
    self.frame = frame;
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameHeight:(CGFloat)frameHeight
{
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    self.frame = frame;
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameOrigin:(CGPoint)frameOrigin
{
    CGRect frame = self.frame;
    frame.origin = frameOrigin;
    self.frame = frame;
}

- (CGPoint)frameOrigin
{
    return self.frame.origin;
}

- (void)setFrameSize:(CGSize)frameSize
{
    CGRect frame = self.frame;
    frame.size = frameSize;
    self.frame = frame;
}

- (CGSize)frameSize
{
    return self.frame.size;
}

- (CGFloat)frameXAndWidth
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)frameYAndHeight
{
    return CGRectGetMaxY(self.frame);
}

- (void)setFrameXAndWidth:(CGFloat)frameXAndWidth
{
    CGRect rect = self.frame;
    rect.origin.x = frameXAndWidth - rect.size.width;
    self.frame = rect;
}

- (void)setFrameYAndHeight:(CGFloat)frameYAndHeight
{
    CGRect rect = self.frame;
    rect.origin.y = frameYAndHeight - rect.size.height;
    self.frame = rect;
}

- (CGPoint)boundsCenter
{
    return CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2,
                       self.bounds.origin.y + self.bounds.size.height / 2);
}

- (CGFloat)boundsCenterX
{
    return self.bounds.origin.x + self.bounds.size.width / 2;
}

- (CGFloat)boundsCenterY
{
    return self.bounds.origin.y + self.bounds.size.height / 2;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}

- (CGFloat)boundsX
{
    return self.bounds.origin.x;
}

- (CGFloat)boundsY
{
    return self.bounds.origin.y;
}

- (CGFloat)boundsWidth
{
    return self.bounds.size.width;
}

- (CGFloat)boundsHeight
{
    return self.bounds.size.height;
}

- (void)setBoundsSize:(CGSize)boundsSize
{
    CGRect bounds = self.bounds;
    bounds.size = boundsSize;
    self.bounds = bounds;
}

- (CGSize)boundsSize
{
    return self.bounds.size;
}

///////////////////



// 1
- (CGPoint)leftTop
{
    return self.frameOrigin;
}

- (void)setLeftTop:(CGPoint)leftTop
{
    self.frameOrigin = leftTop;
}

// 2
- (CGPoint)leftCenter
{
    return CGPointMake(self.frameX, self.centerY);
}

- (void)setLeftCenter:(CGPoint)leftCenter
{
    self.center = CGPointMake(leftCenter.x + self.frameWidth / 2,
                              leftCenter.y);
}

// 3
- (CGPoint)leftBottom
{
    return CGPointMake(self.frameX, self.centerY + self.frameHeight / 2);
}

- (void)setLeftBottom:(CGPoint)leftBottom
{
    self.center = CGPointMake(leftBottom.x + self.frameWidth / 2,
                              leftBottom.y - self.frameHeight / 2);
}

// 4
- (CGPoint)topCenter
{
    return CGPointMake(self.centerX, self.frameY);
}

- (void)setTopCenter:(CGPoint)topCenter
{
    self.center = CGPointMake(topCenter.x,
                              topCenter.y + self.frameHeight / 2);
}

// 5
- (CGPoint)bottomCenter
{
    return CGPointMake(self.centerX, self.frameYAndHeight);
}

- (void)setBottomCenter:(CGPoint)bottomCenter
{
    self.center = CGPointMake(bottomCenter.x,
                              bottomCenter.y - self.frameHeight / 2);
}

// 6
- (CGPoint)rightTop
{
    return CGPointMake(self.frameXAndWidth, self.frameY);
}

- (void)setRightTop:(CGPoint)rightTop
{
    self.center = CGPointMake(rightTop.x - self.frameWidth / 2,
                              rightTop.y + self.frameHeight / 2);
}

// 7
- (CGPoint)rightCenter
{
    return CGPointMake(self.frameXAndWidth, self.centerY);
}

- (void)setRightCenter:(CGPoint)rightCenter
{
    self.center = CGPointMake(rightCenter.x - self.frameWidth / 2,
                              rightCenter.y);
}

// 8
- (CGPoint)rightBottom
{
    return CGPointMake(self.frameXAndWidth, self.frameYAndHeight);
}

- (void)setRightBottom:(CGPoint)rightBottom
{
    self.center = CGPointMake(rightBottom.x - self.frameWidth / 2,
                              rightBottom.y - self.frameHeight / 2);
}

@end
