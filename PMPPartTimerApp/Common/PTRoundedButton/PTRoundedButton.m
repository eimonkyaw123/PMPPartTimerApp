//
//  PTRoundedButton.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "PTRoundedButton.h"

@implementation PTRoundedButton

- (void)setTopLeft:(BOOL)topLeft {
    _topLeft = topLeft;
    _corners |= UIRectCornerTopLeft;
}

- (void)setTopRigth:(BOOL)topRigth {
    _topRigth = topRigth;
    _corners |= UIRectCornerTopRight;
}

- (void)setBottomLeft:(BOOL)bottomLeft {
    _bottomLeft = bottomLeft;
    _corners |= UIRectCornerBottomLeft;
}

- (void)setBottomRigth:(BOOL)bottomRigth {
    _bottomRigth = bottomRigth;
    _corners |= UIRectCornerBottomRight;
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.backgroundColor = fillColor;
}

- (void)setCornerRadius:(int)cornerRadius {
    _cornerRadius = cornerRadius;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:self.bounds
                          byRoundingCorners:_corners
                                cornerRadii:CGSizeMake(_cornerRadius, _cornerRadius+10)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;

}


@end
