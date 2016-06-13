//
//  BankAccountViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "Service.h"
#import "CommonMessage.h"
#import "MBProgressHUD.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface BankAccountViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtAccountNo;
@property (strong, nonatomic) IBOutlet UIButton *btnBankType;
@property (strong, nonatomic) IBOutlet UIButton *btnAccountUpdate;

- (IBAction)BankTypeAction:(id)sender;
- (IBAction)BankAccountAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *dropDownTableview;

#pragma - service 
-(void)ResponseBankAccount:(NSDictionary *)BA;
-(void)ResponseBankList:(NSDictionary*)BL;
@property(nonatomic) NSInteger   code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

@property(nonatomic,strong)CommonMessage  *sendMessage;
@end
