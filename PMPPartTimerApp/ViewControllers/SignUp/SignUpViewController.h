//
//  SignUpViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"
#import "Service.h"
#import <FacebookSDK/FacebookSDK.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "CommonMessage.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface SignUpViewController : UIViewController<UITextFieldDelegate,ServiceDelegate,FBLoginViewDelegate,CustomIOSAlertViewDelegate>
{
     NSURLConnection *serverConnection;
    NSMutableData *mutableData;
}
-(void)goBack;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)SignUpAction:(id)sender;
-(void)ResponseFlashScreen:(NSDictionary*)cp;
//@property(nonatomic, retain) NSString *sessiondIDandTokenResponse;
//delegate service
-(void)ResponseSignUpData:(NSDictionary *)d;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong)NSString *userID;
@property(nonatomic)NSInteger partTimerID;
@property(nonatomic,strong)NSString  *sessionID;

@property(nonatomic,strong)CommonMessage *sendMessage;
@property (strong, nonatomic) IBOutlet FBLoginView *fb_Login;
@end
