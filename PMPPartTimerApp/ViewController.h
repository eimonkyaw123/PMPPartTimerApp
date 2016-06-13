//
//  ViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "Service.h"
#import "LoadingImageViewController.h"
#import "TabViewController.h"
#import "CustomIOSAlertView.h"
@interface ViewController : UIViewController<FBLoginViewDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>

#pragma - service delegate
-(void)ResponseFlashScreen:(NSDictionary*)cp;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@end

