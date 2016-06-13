//
//  PasswordViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "PasswordViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SuccessFailViewController.h"
#import "CommonMessage.h"
#import "SignInViewController.h"
#import "LoadingImageViewController.h"
@interface PasswordViewController ()
{
    Service *s;
    NSInteger userID;
    NSString *sessionID;
    LoadingImageViewController *li;
}
@property(nonatomic,strong)SuccessFailViewController *popViewController;

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //textfield delegate
    self.txtOldPassword.delegate =self;
    self.txtNewPassword.delegate = self;
    self.txtRepeatPassword.delegate =self;

    
    
    //button cornor
    self.btnPasswordUpdate.layer.cornerRadius = 18;
    self.btnPasswordUpdate.clipsToBounds = YES;
    
    //error view
    self.errorview.layer.borderColor = [UIColor redColor].CGColor;
     self.errorview.layer.borderWidth = 3.0f;
    
    self.errorview.hidden= true;
//  self.all_view.frame = CGRectMake(0, 15, self.all_view.frame.size.width, self.all_view.frame.size.height);
    
    //service delegate
    s= [[Service alloc]init];
    s.serviceDelegate = self;
    self.sendMessage = [[CommonMessage alloc]init];
    li = [[LoadingImageViewController alloc]init];
    

}
-(void)viewDidLayoutSubviews
{
    // textfield border
    [self setTextFieldbottomColor:self.txtOldPassword];
    [self setTextFieldbottomColor:self.txtNewPassword];
    [self setTextFieldbottomColor:self.txtRepeatPassword];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma textfield custom control
-(void)setTextFieldbottomColor:(UITextField*)textfield
{
    CALayer *border = [CALayer layer];
    
    CGFloat borderWidth = 1;
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height - borderWidth, textfield.frame.size.width, textfield.frame.size.height);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = true;
    
}

#pragma textfield Delegate function
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    // [txtView resignFirstResponder];
    return NO;
}

- (IBAction)PasswordUpdateAction:(id)sender {
        /*
     http://localhost:9090/api/parttimer/profileChangePassword.htm?json={"partTimerId":4,"oldpassword":"111111","password":"111111"}
    */
    userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    //NSString *ProfilePSW = @"http://192.168.1.47:8080/api/profileChangePassword.htm?json=";
    NSString *ProfilePSW = @"http://ihughos.com/api/profileChangePassword.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"userId\":\"%d\",\"oldPassword\":\"%@\",\"password\":\"%@\",\"repeatPassword\":\"%@\",\"sessionId\":\"%@\"}",userID,self.txtOldPassword.text,self.txtNewPassword.text,self.txtRepeatPassword.text,sessionID];
   // NSString *data = [NSString stringWithFormat:ChangePasswordJSON,userID,self.txtOldPassword.text,self.txtNewPassword.text,self.txtRepeatPassword.text,sessionID];

  [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_PROFILE_CHANGE_PASSWORD] body:nil];
    

}
#pragma service delegate
-(void)ResponsePassword:(NSDictionary *)p
{
    [li showLoading:self.view animated:NO];

   // NSString *error_msg;
       self.code = [p[@"responseCode"]integerValue];
    self.message = p[@"responseMessage"];

    if (self.code == 1) {
        self.message = p[@"responseMessage"];
        
    }
    else if(self.code == 1002)
    {
        
         self.message = p[@"responseMessage"];
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
        // Add some custom content to the alert view
        [alertView setContainerView:alert];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];


        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SignInViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
        
        [self.navigationController presentViewController:vc animated:true completion:nil];
    }
      else if (self.code == 1000)
    {
        
            NSMutableArray *copyArr = [[NSMutableArray alloc]init];
            self.data =  p[@"data"];
            NSLog(@"data %@",p[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            
            
            NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
            NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
            
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
        // Add some custom content to the alert view
        [alertView setContainerView:alert];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];


    }
    else
    {
        
        self.message = p[@"responseMessage"];
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
        // Add some custom content to the alert view
        [alertView setContainerView:alert];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];

    }
    }

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

-(void)showErrorView
{
    if (self.errorview.hidden) {
        self.errorview.hidden= false;
        
        self.all_view.frame = CGRectMake(-10, 60, self.all_view.frame.size.width-10, self.all_view.frame.size.height);
        
    }
    else
    {
        self.errorview.hidden= true;
        self.all_view.frame = CGRectMake(-10, 15, self.all_view.frame.size.width, self.all_view.frame.size.height);
        
        
    }

}
@end
