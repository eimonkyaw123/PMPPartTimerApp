//
//  FavouritViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "JobDetail.h"
#import "FavouritDetailViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "CustomIOSAlertView.h"
#import "Constant.h"
@interface FavouritViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>{
    AppDelegate *appDelegate;
}

@property (strong, nonatomic) IBOutlet UITableView *f_tableview;

#pragma -  service delegate
-(void)ResponseNewJob:(NSDictionary *)NJ;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

@property (nonatomic, strong) NSString *jd_id;
@end
