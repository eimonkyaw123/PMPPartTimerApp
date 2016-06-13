//
//  jlistViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "PopoverView.h"
#import "AppDelegate.h"
#import "SignInViewController.h"
#import "Constant.h"
@interface JobListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>
{
      AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;

#pragma -  service delegate
-(void)ResponseNewJob:(NSDictionary *)NJ;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *jobID;
@property(nonatomic,strong) NSArray * data;
@property (strong, nonatomic) IBOutlet UIButton *btnChooseType;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
- (IBAction)ChooseTypeAction:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIView *noJobList;

@property(nonatomic,strong)NSString *filter;

@end
