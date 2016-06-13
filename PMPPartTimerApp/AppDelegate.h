//
//  AppDelegate.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MBProgressHUD *actIndicator;
}

@property (strong, nonatomic) UIWindow *window;

-(void)showIndicator:(NSString *)withTitleString view1:(UIView *)currentView;
-(void)hideIndicator;
@end

