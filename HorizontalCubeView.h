//
//  HorizontalCubeView.h
//  Transfer
//
//  Created by mengyan.luo on 13-10-18.
//  Copyright (c) 2013年 MTime. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HorizontalCubeView;
@protocol HorizontalCubeViewDelegate <NSObject>

- (void) cubeViewWillRotate:(HorizontalCubeView *) cubeView;
- (void) cubeViewIsRotating:(HorizontalCubeView *) cubeView;
- (void) cubeView:(HorizontalCubeView *)cubeView didRotateToViewAtIndex:(NSUInteger )index;

@end

@interface HorizontalCubeView : UIView {
    CGFloat _eachAngle;
    CGFloat _horizontalPointZ;
    CGFloat _startPoint;
    CGFloat _currentAngle;
    CGFloat _lastStoppingAngle;
}

//设定需要显示的views
@property (nonatomic, retain) NSArray * views;
//返回views的数量
@property (nonatomic, readonly) NSUInteger count;

@property (nonatomic, assign) id<HorizontalCubeViewDelegate> delegate;

- (id) initWithViews:(NSArray *)views frame:(CGRect)rect;

@end
