//
//  PasswordViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "CommonMessage.h"
#import "MBProgressHUD.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface PasswordViewController : UIViewController<UITextFieldDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRepeatPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnPasswordUpdate;
@property (strong, nonatomic) IBOutlet UIView *errorview;
- (IBAction)PasswordUpdateAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *all_view;
@property (strong, nonatomic) IBOutlet UITextView *txtError;

#pragma -  service delegate
-(void)ResponsePassword:(NSDictionary *)p;
@property(nonatomic)NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

@property(nonatomic,strong)CommonMessage *sendMessage;
@end
