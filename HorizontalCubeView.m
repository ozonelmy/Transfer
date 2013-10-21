//
//  HorizontalCubeView.m
//  Transfer
//
//  Created by mengyan.luo on 13-10-18.
//  Copyright (c) 2013年 MTime. All rights reserved.
//

#import "HorizontalCubeView.h"
#import <QuartzCore/QuartzCore.h>

#define DEGREE_TO_RADIANS(d) ((d) * M_PI / 180.f)

#define HORIZONTALPOINTZ -160
#define M34 -0.001

@implementation HorizontalCubeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithViews:(NSArray *)views frame:(CGRect)rect {
    self = [super initWithFrame:rect];
    if (self) {
        self.views = views;
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    _startPoint = [touch locationInView:self].x;
    if ([_delegate respondsToSelector:@selector(cubeViewWillRotate:)]) {
        [_delegate cubeViewWillRotate:self];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGFloat movePoint = [touch locationInView:self].x;
    _currentAngle = (movePoint - _startPoint) / CGRectGetWidth(self.bounds) * _eachAngle + _lastStoppingAngle;
    [self rotateCubeToDegree:_currentAngle];
    if ([_delegate respondsToSelector:@selector(cubeViewIsRotating:)]) {
        [_delegate cubeViewIsRotating:self];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    double mul = round(_currentAngle / _eachAngle);
    _lastStoppingAngle = _currentAngle = _eachAngle * mul;
    [UIView transitionWithView:self duration:.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.userInteractionEnabled = NO;
        [self rotateCubeToDegree:_currentAngle];
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        NSUInteger index = abs(mul) % [_views count];
        UIView *view = [_views objectAtIndex:index];
        [self bringSubviewToFront:view];
        if ([_delegate respondsToSelector:@selector(cubeView:didRotateToViewAtIndex:)]) {
            [_delegate cubeView:self didRotateToViewAtIndex:index];
        }
    }];
}

- (void) resetSubviews:(NSArray *)views {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in views) {
        view.frame = self.bounds;
        [self addSubview:view];
    }
    _eachAngle = 360.f / [views count];
    CGFloat radians = DEGREE_TO_RADIANS((180.f - _eachAngle) / 2);
    double tanDegree = tan(radians);
    CGFloat width = CGRectGetWidth(self.bounds) / 2;
    _horizontalPointZ = tanDegree * width;
    [self rotateCubeToDegree:0.f];
}

- (void) rotateCubeToDegree:(CGFloat)degree {
    CATransform3D transform3d = CATransform3DIdentity;
    transform3d.m34 = M34;
    transform3d = CATransform3DTranslate(transform3d, 0, 0, -160);
    for (int i = 0; i < self.count; i++) {
        CATransform3D temp = CATransform3DRotate(transform3d, DEGREE_TO_RADIANS((degree +  _eachAngle * i)), 0, 1, 0);
        UIView *view = [_views objectAtIndex:i];
        view.layer.anchorPointZ = -_horizontalPointZ;
        view.layer.transform = temp;
    }
}

- (NSUInteger) count {
    return [_views count];
}

- (void) setViews:(NSArray *)views {
    NSAssert([views count] > 2, @"There must be at least 3 views");
    [_views autorelease];
    _views = [views retain];
    [self resetSubviews:_views];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
