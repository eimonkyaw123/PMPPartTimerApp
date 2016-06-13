//
//  SignInViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/28/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SignInViewController.h"
#import "TabViewController.h"
#import "TextFieldValidator.h"
#import "LoadingImageViewController.h"
@interface SignInViewController ()<UITextFieldDelegate>
{
    Service *s;
    BOOL flag;
    LoadingImageViewController *li ;
}
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
      self.navigationController.navigationBar.topItem.title = @"";
    self.btnLogin.layer.cornerRadius = 18;
    self.btnLogin.clipsToBounds = YES;
    
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
    self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.txtPassword.keyboardType = UIKeyboardTypeDefault;
    
    s=[[Service alloc]init];
    s.serviceDelegate = self;
   // [self setupAlerts];
     li = [[LoadingImageViewController alloc]init];
    self.sendMessage = [[CommonMessage alloc]init];
    flag = false;
   
}
-(void)viewDidLayoutSubviews
{
    [self setTextFieldbottomColor:self.txtPassword];
    [self setTextFieldbottomColor:self.txtEmail];
}
- (void)viewDidUnload
{
  //  [self setTxtEmail:nil];
  //  [self setTxtPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma textfield validator setup
-(void)setupAlerts{
    self.txtEmail.presentInView = self.view ;
    self.txtPassword.presentInView = self.view ;
    
    [self.txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    [self.txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
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

#pragma textfield custom control
-(void)setTextFieldbottomColor:(UITextField*)textfield
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor = [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height - borderWidth, textfield.frame.size.width, textfield.frame.size.height);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
}

- (IBAction)SignInAction:(id)sender {
   // if ([self.txtEmail validate]  ) {//& [self.txtPassword validate]
       // NSString * baseURL = @"http://192.168.1.47:8080/api/login.htm?json=";
    NSString * baseURL = @"http://ihughos.com/api/login.htm?json=";

    NSString *data=[NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"appCode\":\"%@\"}",self.txtEmail.text,self.txtPassword.text,APP_CODE];
     // NSString *data=[NSString stringWithFormat:SignInJSON,self.txtEmail.text,self.txtPassword.text,APP_CODE];
    
   
   // [li startAnimation];
        //[request setValue:[NSString stringWithFormat:@"Basic %@",authValue] forHTTPHeaderField:@"Authorization"];
    /*
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
     */
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
             [li showLoading:self.view animated:YES];
        });
    });

    
        [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_LOGIN] body:nil];
    [li showLoading:self.view animated:NO];
       // [self performSegueWithIdentifier:@"GotoProfile" sender:sender];
  //  }
   
  }
/*
-(void)UpdateDevice:(id)sender
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    NSString * baseURL = @"http://192.168.1.47:8080/api/login.htm?json=";
    NSString *data=[NSString stringWithFormat:@"{\"DeviceId\":\"%@\",\"deviceType\":\"%@\",\"userId\":\"%d\",\"sessionId\":\"%@\"}",[s getDeviceID ],@"1",userID,sessionID];
    
    //[request setValue:[NSString stringWithFormat:@"Basic %@",authValue] forHTTPHeaderField:@"Authorization"];
    
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:baseURL body:nil];
    [self performSegueWithIdentifier:@"GotoProfile" sender:sender];

}
*/
#pragma service delegate
-(void)ResponseLogInData:(NSDictionary *)loginData
{
   // [MBProgressHUD hideHUDForView:self.view animated:YES];
   // loadingImage *subView = [[loadingImage alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
   // [subView.animationImageView stopAnimating];
     [li showLoading:self.view animated:NO];
     NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [loginData[@"responseCode"] integerValue];
    NSLog(@"sign in response code %d",self.code);
    NSLog(@"sign in response message %@",loginData[@"responseMessage"]);
    NSLog(@"sign in response data %@",loginData[@"data"]);
    if (self.code == 1) {
             if ([loginData[@"data"] count]>0) {
        NSMutableArray *r_data =loginData[@"data"];
        NSLog(@"response message %@",loginData[@"responseMessage"]);
        NSLog(@" response message %@",loginData[@"data"]);
               
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[r_data  valueForKey:@"parttimerId"] forKey:@"parttimerId"];
        [defaults setObject:[r_data valueForKey:@"sessionId"] forKey:@"sessionId"];
         [defaults setObject:[r_data  valueForKey:@"userId"] forKey:@"userId"];
        [defaults synchronize];
           
           NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
           NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
        //   NSString * baseURL = @"http://192.168.1.47:8080/api/update-device.htm?json=";
            NSString * baseURL = @"http://ihughos.com/api/update-device.htm?json=";
           NSString *data=[NSString stringWithFormat:@"{\"DeviceId\":\"%@\",\"deviceType\":\"%@\",\"userId\":\"%d\",\"sessionId\":\"%@\"}",[s getDeviceID ],@"1",userID,sessionID];
                //  NSString *data=[NSString stringWithFormat:UpdateDeviceJSON,[s getDeviceID ],@"1",userID,sessionID];
           
           //[request setValue:[NSString stringWithFormat:@"Basic %@",authValue] forHTTPHeaderField:@"Authorization"];
         //  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                 dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                     // Do something...
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [li showLoading:self.view animated:YES];
                     });
                 });

           [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_UPDATE_DEVICE] body:nil];
           flag = true;
          // [li stopAnimation];
       }
       
    }
    else if (self.code == 1000)
    {
        
        NSMutableArray *copyArr = [[NSMutableArray alloc]init];
        self.data =  loginData[@"data"];
        NSLog(@"data %@",loginData[@"data"]);
        for (int i =0; i<self.data.count; i++) {
            NSDictionary *jsonElement = self.data[i];
            
            // Add this question to the locations array
            [copyArr addObject:jsonElement];
            
        }
        
        
        NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
        NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
        
       // [self.sendMessage ShowMessage:self.view errorCode:fieldCode errorMessage:errorMessage title:@"Failure" image:[UIImage imageNamed:@"ic-common-error@2x.png"]];
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
             [li showLoading:self.view animated:NO];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];

        /*
        if ([fieldCode isEqualToString:@"2006"]) {
            
            self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
            [self.popViewController showInView:self.view withTitle:@"Failure" withImage:[UIImage imageNamed:@"ic-common-error@2x.png"] withMessage:errorMessage animated:YES];
          
           // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           // [alert show];
        }
        else if([fieldCode isEqualToString:@"2005"] )
        {
            self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
            [self.popViewController showInView:self.view withTitle:@"Failure" withImage:[UIImage imageNamed:@"ic-common-error@2x.png"] withMessage:errorMessage animated:YES];
           // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           // [alert show];
        }
        else if([fieldCode isEqualToString:@"2007"] )
        {
            self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
            [self.popViewController showInView:self.view withTitle:@"Failure" withImage:[UIImage imageNamed:@"ic-common-error@2x.png"] withMessage:errorMessage animated:YES];
                    //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            //[alert show];
        }
        else if([fieldCode isEqualToString:@"2002"] )
        {
            self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
            [self.popViewController showInView:self.view withTitle:@"Failure" withImage:[UIImage imageNamed:@"ic-common-error@2x.png"] withMessage:errorMessage animated:YES];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        */
    }
    else if (self.code == 1002)
    {
        
        self.message = [loginData objectForKey:@"responseMessage"];
       // [self.sendMessage ShowMessage:self.view errorCode:[NSString stringWithFormat:@"%d",self.code] errorMessage:self.message title:@"Failure" image:[UIImage imageNamed:@"ic-common-error@2x.png"]];
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
             [li showLoading:self.view animated:NO];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        SignInViewController *signIn = [[SignInViewController alloc]init];
        [self.navigationController presentModalViewController:signIn animated:YES];
    }

    else
    {
        self.message = [loginData objectForKey:@"responseMessage"];
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
             [li showLoading:self.view animated:NO];
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
// call login view
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0 && [alertView.title isEqualToString:@""]) {
        
    }
}
//
#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GotoProfile"]) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      //  PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        //vc.s_id = self.sessionID;
       // vc.p_id = self.partTimerID;
       // [self presentModalViewController:vc animated:YES];
        TabViewController *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
        tb.s_id = self.sessionID;
        tb.p_id = self.partTimerID;
         [tb setSelectedIndex:2];
        [self presentModalViewController:tb animated:YES];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"GotoProfile"])
    {
        if (flag == false) {
            return NO;
        }
        else if ([self.txtEmail.text isEqualToString:@"" ]|| [self.txtPassword.text isEqualToString:@""] ) {
            return NO;
        }
        
        
    }
    
    return YES;
    
}


@end
