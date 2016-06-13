//
//  ForgetPasswordViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/4/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Constant.h"
#import "TextFieldValidator.h"
#import "CommonMessage.h"
#import "MBProgressHUD.h"
#import "CustomIOSAlertView.h"
#import "Constant.h"
@interface ForgetPasswordViewController : UIViewController<UITextFieldDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>
{
    Service *s;
}
@property (strong, nonatomic) IBOutlet TextFieldValidator *f_eMail;

- (IBAction)SendAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;

#pragma - service delegate
-(void)ResponseChangePassword:(NSDictionary*)cp;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

@property(nonatomic,strong)CommonMessage    *sendMessage;
@end
