//
//  MyDetailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PMCalendar.h"
#import "Service.h"
#import "Constant.h"
#import "CommonMessage.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "LoadingImageViewController.h"
#import "Constant.h"
@interface MyDetailViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,PMCalendarControllerDelegate,UIActionSheetDelegate,ServiceDelegate,CustomIOSAlertViewDelegate>
{
   // UIDatePicker *datePicker;
    UIDatePicker *datePicker;
    Service *s;
   
        
        NSURLConnection *serverConnection;
        NSMutableData *returnData;
   
   
    }
@property (strong, nonatomic) IBOutlet UITextView *txtDTTitle;
@property (strong, nonatomic) IBOutlet UIScrollView *mydetailScrollview;
@property (strong, nonatomic) IBOutlet UIImageView *frontImg;
@property (strong, nonatomic) IBOutlet UIImageView *backImg;
@property (strong, nonatomic) IBOutlet UITextField *txtDTFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtDTLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtDTEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtDTNRIC;
@property (strong, nonatomic) IBOutlet UITextField *txtDTGender;
@property (strong, nonatomic) IBOutlet UITextField *txtDTDOB    ;
@property (strong, nonatomic) IBOutlet UITextField *txtDTMobile;
@property (strong, nonatomic) IBOutlet UITextField *txtSchoolName;
@property (strong, nonatomic) IBOutlet UITextField *txtExpiryOfStudentCard;
@property (strong, nonatomic) IBOutlet UIButton *btnUpdate;
- (IBAction)UpdateProfileAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnFront;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)isStudentAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnStudent;
@property (strong, nonatomic) IBOutlet UILabel *lblSchoolName;
@property (strong, nonatomic) IBOutlet UILabel *lblExpiry;
- (IBAction)ShowCalendar:(id)sender;
- (IBAction)ChooseGenderAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblGender;
@property (strong, nonatomic) IBOutlet UIButton *btnGender;
@property (strong, nonatomic) IBOutlet UILabel *lbluniformSize;
- (IBAction)ChooseUniformAction:(id)sender;

#pragma -  service delegate
-(void)ResponseProfileDetail:(NSDictionary *)DetailData;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@property(nonatomic,strong) NSString *sessionID;
@property(nonatomic)NSInteger   *p_id;

@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) NSString *str1;

- (IBAction)hideKeyboard:(id)sender;

@property(nonatomic,strong)CommonMessage *sendMessage;
@end
