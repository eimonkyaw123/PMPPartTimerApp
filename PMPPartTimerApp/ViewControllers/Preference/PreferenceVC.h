//
//  PreferenceVC.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/5/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Constant.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "SignInViewController.h"
#import "MBProgressHUD.h"
#import "CommonMessage.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface PreferenceVC : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UITableView *preferenceTable;
@property (nonatomic,strong)NSString* s_id;
@property (nonatomic)NSInteger  p_id;
- (IBAction)CallTabViewControllerAction:(id)sender;

#pragma - service delegate
-(void)ResponsePreferenceData:(NSDictionary*)pd;
-(void)ResponsePReferenceInfo:(NSDictionary*)pInfo;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong)CommonMessage *sendMessage;
@property(nonatomic,strong)NSString *btn_Title;
@end
