//
//  Service.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/16/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"    
#import "CallBackService.h"
#import "CommonMessage.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
@protocol ServiceDelegate<NSObject>
/// user login,signup
-(void)ResponseSignUpData:(NSDictionary *)d;
-(void)ResponseLogInData:(NSDictionary*)loginData;
-(void)ResponseChangePassword:(NSDictionary*)cp;
////

//// Preference
-(void)ResponsePreferenceData:(NSDictionary*)pd;
-(void)ResponsePReferenceInfo:(NSDictionary*)pInfo;
////

//// Profile
-(void)ResponseProfileDetail:(NSDictionary*)DetailData;
-(void)ResponseBankAccount:(NSDictionary*)BA;
-(void)ResponseBankList:(NSDictionary*)BL;
-(void)ResponsePassword:(NSDictionary*)p;
////

//// Home
-(void)ResponseNewJob:(NSDictionary*)NJ;
-(void)ResponseSignedUpJob:(NSDictionary*)SJ;
-(void)ResponsePastJob:(NSDictionary*)pj;
////

//// Job Detail
-(void)ResponseJobDetail:(NSDictionary *)ND;
-(void)ResponseAcceptJob:(NSDictionary *)AJ;
-(void)ResponseCancelJob:(NSDictionary *)CJ;
////

//// News
-(void)ResponseUpdateNews:(NSDictionary *)NJ;
////

//// Favourit
-(void)ResponseFavourit:(NSDictionary*)f;
-(void)ResponseFavouritDetail:(NSDictionary *)FD;

//// Setting
-(void)ResponseSettingInfo:(NSDictionary*)si;
-(void)ResponseFlashScreen:(NSDictionary*)cp;
@end

@interface Service : NSObject<NSURLConnectionDelegate,CustomIOSAlertViewDelegate>
{
    NSURLConnection *serverConnection;

     NSMutableData *mutableData;
    NSMutableURLRequest *request;
    
}
@property(nonatomic, retain) NSString *sessiondIDandTokenResponse;
@property(nonatomic,assign)id<ServiceDelegate> serviceDelegate;
@property(nonatomic)NSURLConnection *serverConnection;
@property(nonatomic,strong)CommonMessage     *sendMessage;
//@property(nonatomic,strong)CallBackService* callbackDelegate;
#pragma method
-(NSString*)getDeviceID;
-(void)sendDataToServer:(NSString*)methodName JsonData:(NSString*)j_Data sendURl:(NSString*)u body:(NSMutableDictionary*)b;
@property (nonatomic,strong) CustomIOSAlertView * customAlert;

@end
