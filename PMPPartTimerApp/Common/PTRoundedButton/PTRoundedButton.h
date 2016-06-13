//
//  PTRoundedButton.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface PTRoundedButton : UIButton
{
    UIRectCorner _corners;
}
@property (nonatomic) IBInspectable BOOL    topLeft;
@property (nonatomic) IBInspectable BOOL    topRigth;
@property (nonatomic) IBInspectable BOOL    bottomLeft;
@property (nonatomic) IBInspectable BOOL    bottomRigth;
@property (nonatomic) IBInspectable int     cornerRadius;
@property (nonatomic) IBInspectable UIColor *fillColor;

@end
