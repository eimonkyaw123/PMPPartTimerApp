//
//  SignInViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/28/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Constant.h"
#import "PreferenceVC.h"
#import "TextFieldValidator.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "CommonMessage.h"
#import "SuccessFailViewController.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface SignInViewController : UIViewController<ServiceDelegate,UIAlertViewDelegate,CustomIOSAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtEmail;

@property (strong, nonatomic) IBOutlet TextFieldValidator *txtPassword;


- (IBAction)SignInAction:(id)sender;

#pragma service delegate
-(void)ResponseLogInData:(NSDictionary*)loginData;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

// send data
@property(nonatomic,strong)NSString *sessionID;
@property(nonatomic)NSInteger partTimerID;

// for success/failure popup
@property (strong, nonatomic) SuccessFailViewController *popViewController;
@property   (strong,nonatomic)CommonMessage *sendMessage;
@end
