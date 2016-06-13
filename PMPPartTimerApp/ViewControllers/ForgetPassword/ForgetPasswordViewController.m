//
//  ForgetPasswordViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/4/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.topItem.title = @"";
    self.btnSend.layer.cornerRadius = 18;
    self.btnSend.clipsToBounds = YES;
    
    s=[[Service alloc]init];
    s.serviceDelegate = self;
    self.f_eMail.delegate = self;
    self.f_eMail.keyboardType = UIKeyboardTypeEmailAddress;
    //  [self setupAlerts];
    self.sendMessage = [[CommonMessage alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    [self setTextFieldbottomColor:self.f_eMail];
   
}
-(void)setupAlerts{
    self.f_eMail.presentInView = self.view ;
    
    [self.f_eMail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
}

- (IBAction)SendAction:(id)sender {
    //if ([self.f_eMail validate]) {
       // NSString * baseURL = @"http://192.168.1.47:8080/api/forget-password.htm?json=";
     NSString * baseURL = @"http://ihughos.com/api/forget-password.htm?json=";
        NSString *data=[NSString stringWithFormat:@"{\"email\":\"%@\",\"appCode\":\"%@\"}",self.f_eMail.text,APP_CODE];
    // NSString *data=[NSString stringWithFormat:ForgetPasswordJSON,self.f_eMail.text,APP_CODE];
        
        //[request setValue:[NSString stringWithFormat:@"Basic %@",authValue] forHTTPHeaderField:@"Authorization"];
        
        [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_FORGET_PASSWORD] body:nil];
   // }
  
  //  NSString *data = [NSString stringWithFormat:FORGOT,@"4",self.f_eMail]
   // [s sendDataToServer:POST_METHOD JsonData:data sendURl:PreferenceURL];

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
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height - borderWidth, textfield.frame.size.width, textfield.frame.size.height);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
}

#pragma service delegate
-(void)ResponseChangePassword:(NSDictionary*)cp
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [cp[@"responseCode"]integerValue];
    /*
    self.message = pd[@"responseMessage"];
    self.data = pd[@"data"];
    for (int i =0; i<self.data.count; i++) {
        NSDictionary *jsonElement = self.data[i];
        
        // Add this question to the locations array
        [copyArr addObject:jsonElement];
        
    }
     */
    if (self.code == 1) {
        self.message = cp[@"responseMessage"];
        //[self.sendMessage ShowMessage:self.view errorCode:[NSString stringWithFormat:@"%d",self.code] errorMessage:@"Email with sent u soon.." title:@"Successful" image:[UIImage imageNamed:@"ic-common-checked@2x.png"]];
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-checked@2x.png" title:@"Successful" message:@"Email with sent u soon.."];
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
    else if (self.code == 1000)
    {
        /*
        NSMutableArray *copyArr = [[NSMutableArray alloc]init];
        self.data =  cp[@"data"];
        NSLog(@"data %@",cp[@"data"]);
        for (int i =0; i<self.data.count; i++) {
            NSDictionary *jsonElement = self.data[i];
            
            // Add this question to the locations array
            [copyArr addObject:jsonElement];
            
        }
        
        
        NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
        NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
        
        
        if ([fieldCode isEqualToString:@"2006"]) {
            
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([fieldCode isEqualToString:@"2005"] )
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([fieldCode isEqualToString:@"2007"] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([fieldCode isEqualToString:@"2002"] )
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
         */
       
            
            NSMutableArray *copyArr = [[NSMutableArray alloc]init];
            self.data =  cp[@"data"];
            NSLog(@"data %@",cp[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            
            
            NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
            NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
            
           // [self.sendMessage ShowMessage:self.view errorCode:fieldCode errorMessage:errorMessage title:@"Failure" image:[UIImage imageNamed:@"ic-common-error@2x.png"]];
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:errorMessage];
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
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

@end
