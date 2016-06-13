//
//  SignupJobListViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "PopoverView.h"

@interface SignupJobListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UIButton *btnDropDown;
- (IBAction)ChooseFavouritAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblFavourit;

#pragma -  service delegate
-(void)ResponseSignedUpJob:(NSDictionary *)SJ;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property (strong, nonatomic) IBOutlet UIView *noSignupJob;
@property(nonatomic,strong) NSArray * data;
@end
