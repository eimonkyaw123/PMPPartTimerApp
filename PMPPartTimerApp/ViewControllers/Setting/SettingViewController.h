//
//  SettingViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/2/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Constant.h"
@interface SettingViewController : UIViewController<ServiceDelegate>

#pragma -service delegate
-(void)ResponseSettingInfo:(NSDictionary *)si;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@end
