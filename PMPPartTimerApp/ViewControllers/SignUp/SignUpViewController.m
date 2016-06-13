//
//  SignUpViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SignUpViewController.h"
#import "PopUpViewController.h"
#import "TextFieldValidator.h"
#import "PreferenceVC.h"
#import "LoadingImageViewController.h"

@interface SignUpViewController ()
{
    UIButton *closeButton;
    PopUpViewController *popView;
    Service *s;
    LoadingImageViewController *li;
    BOOL flag;
}
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtFirstName;
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtLastName;
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtEmail;
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtPassword;
@property (strong, nonatomic) IBOutlet TextFieldValidator *txtConfirmPsw;

@end

@implementation SignUpViewController
@synthesize txtFirstName,txtLastName,txtEmail,txtPassword,txtConfirmPsw;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    txtFirstName.delegate = self;
    txtLastName.delegate = self ;
    txtEmail.delegate    = self;
    txtPassword.delegate =self;
    txtConfirmPsw.delegate= self;
    
    // chanage keyboard
    txtFirstName.keyboardType = UIKeyboardTypeAlphabet;
    txtLastName.keyboardType = UIKeyboardTypeAlphabet;
    self.txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.txtPassword.keyboardType = UIKeyboardTypeDefault;
    self.txtConfirmPsw.keyboardType = UIKeyboardTypeDefault;
    
    // for bottom line of textfield
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, txtFirstName.frame.size.height - borderWidth, 171, 30);
    border.borderWidth = borderWidth;
    [txtFirstName.layer addSublayer:border];
    txtFirstName.layer.masksToBounds = YES;
    
    CALayer *border1 = [CALayer layer];
    CGFloat borderWidth1 = 1;
    border1.borderColor =   [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border1.frame = CGRectMake(0, txtLastName.frame.size.height - borderWidth1,171, 30);
    border1.borderWidth = borderWidth1;
    [txtLastName.layer addSublayer:border1];
    txtLastName.layer.masksToBounds = YES;

  
    CALayer *border2 = [CALayer layer];
    CGFloat borderWidth2 = 1;
    border2.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border2.frame = CGRectMake(0, txtEmail.frame.size.height - borderWidth2, 360, 30);
    border2.borderWidth = borderWidth2;
    [txtEmail.layer addSublayer:border2];
    txtEmail.layer.masksToBounds = YES;

    CALayer *border3 = [CALayer layer];
    CGFloat borderWidth3 = 1;
    border3.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border3.frame = CGRectMake(0, txtPassword.frame.size.height - borderWidth3, 360,30);
    border3.borderWidth = borderWidth3;
    [txtPassword.layer addSublayer:border3];
    txtPassword.layer.masksToBounds = YES;

    CALayer *border4 = [CALayer layer];
    CGFloat borderWidth4 = 1;
    border4.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border4.frame = CGRectMake(0, txtConfirmPsw.frame.size.height - borderWidth4, 360,30);
    border4.borderWidth = borderWidth4;
    [txtConfirmPsw.layer addSublayer:border4];
    txtConfirmPsw.layer.masksToBounds = YES;
    _btnNext.hidden = true;
  
    
    s = [[Service alloc]init];
    s.serviceDelegate = self;
    
    self.scrollview.contentSize=CGSizeMake(self.view.frame.size.width,350);
    self.sendMessage = [[CommonMessage alloc]init];
    
    self.fb_Login.delegate = self;
    self.fb_Login.readPermissions = @[@"public_profile", @"email"];
    li = [[LoadingImageViewController alloc]init];
    flag = false;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
   // [self checkUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma back barbutton action
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma check button action
- (IBAction)Check:(id)sender {
    if ([sender isSelected]) {
       [sender setSelected:NO];
         _btnNext.hidden = true;
        
    } else {
        [sender setSelected:YES];
      _btnNext.hidden = false;
    }
}

#pragma textfield validate
/*
-(void)setupAlerts{
   // [txtEmail addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    //[txtUserName addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
   // txtUserName.validateOnResign=NO;
    
    [txtEmail addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
   // [txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
   // [txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
   // [txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
  //  [txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
   // txtPhone.isMandatory=NO;
}
*/
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == txtPassword || textField == txtConfirmPsw) {
        CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y -100);
        [self.scrollview setContentOffset:scrollPoint animated:YES];
    }
   
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollview setContentOffset:CGPointZero animated:YES];
}

#pragma mark - server delegate
-(void)checkUser
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSInteger  pID = [[userDefaults objectForKey:@"parttimerId"]integerValue];
   NSString* sessionID = [userDefaults objectForKey:@"sessionId"];
    
    NSLog(@"user ID :%d",pID);
    NSLog(@"sesion ID :%@",sessionID);
    if ( pID ==0) {
        return;
    }
    else
    {
        NSString * baseURL = @"http:/192.168.1.47:8080/parttimer/checkPartTimerInfo.htm?json=";
      NSString *data=[NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",pID  ,sessionID];
         // NSString *data=[NSString stringWithFormat:CheckUserJSON,pID  ,sessionID];
        [li showLoading:self.view animated:YES];
        
        [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_SIGN_UP] body:nil];

    }
    
}
-(void)ResponseFlashScreen:(NSDictionary*)cp
{
    [li showLoading:self.view animated:NO];
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [cp[@"responseCode"]integerValue];
    self.message = cp[@"responseMessage"];
    self.data = cp[@"data"];

    if (self.code == 1) {
        self.message = cp[@"responseMessage"];
        flag = true;
       // UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //  PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        //vc.s_id = self.sessionID;
        // vc.p_id = self.partTimerID;
        // [self presentModalViewController:vc animated:YES];
      
        
    }
    else if (self.code == 1000)
    {
        
        
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
    if (self.code == 1002) {
        self.message = cp[@"responseMessage"];
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
    else if (self.code == 1016) {
        self.message = cp[@"responseMessage"];
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
        PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        
        [self.navigationController presentViewController:vc animated:true completion:nil];
    }
    
}

- (IBAction)SignUpAction:(id)sender {
  
    NSString *name = [NSString stringWithFormat:@"%@ %@",txtFirstName.text,txtLastName.text];
  
       /* correct url
     @"http://192.168.1.13:9090/api/parttimer/signup.htm?json={\"name\":\"Thet Htar\",\"email\":\"thethtar@gmail.com\",\"password\":\"111111\",\"confirmpassword\":\"111111\",\"deviceType\":\"0\",\"deviceId\":\"DB9C7000-FEA2-4015-93C5-CF2C3B8EE575\"}"
     
       let parameters = [ "user": ["email": "\(emailText.text!)","password": "\(passwordText.text!)"]]
     */
    
   // NSString *baseURL=[NSString stringWithFormat:@"http://192.168.1.47:8080/api/parttimer/signup.htm?json={\"firstName\":\"%@\",\"lastName\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"confirmpassword\":\"%@\",\"deviceType\":\"%@\",\"deviceId\":\"%@\"}",txtFirstName.text,txtLastName.text,txtEmail.text,txtPassword.text,txtConfirmPsw.text,@"1",[s getDeviceID ]];

  //  NSString *data=[NSString stringWithFormat:SignUpJSON,txtFirstName.text,txtLastName.text,txtEmail.text,txtPassword.text,txtConfirmPsw.text,@"1",[s getDeviceID ]];
  //  NSString *baseURL = [ NSString stringWithFormat:@"%@%@",SignUpURL,data];
     NSString *baseURL=[NSString stringWithFormat:@"http://ihughos.com/api/parttimer/signup.htm?json={\"firstName\":\"%@\",\"lastName\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"confirmpassword\":\"%@\",\"deviceType\":\"%@\",\"deviceId\":\"%@\"}",txtFirstName.text,txtLastName.text,txtEmail.text,txtPassword.text,txtConfirmPsw.text,@"1",[s getDeviceID ]];
    NSURL * url =[NSURL URLWithString:[baseURL  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession]; // for session id
  NSMutableURLRequest   *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
     
    
      NSError *error;
     NSURLResponse *response;
    serverConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    [serverConnection start];
    [li showLoading:self.view animated:YES];

    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [li showLoading:self.view animated:YES];
        });
    });

    NSString *error_msg;

     NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error  ];
     if (urlData != nil) {
     NSHTTPURLResponse *res= response;
     NSLog(@"Response code :%d",res.statusCode);
     if (res.statusCode >= 200 && res.statusCode <300) {
         NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
         NSLog(@"Response => %@",responseData);
         NSError * error;
     
         NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
         NSInteger success = [jsonData[@"responseCode"] integerValue];
         [li showLoading:self.view animated:NO];

         if (success ==1) {
             flag = true;
            NSMutableArray *r_data = jsonData[@"data"] ;
             NSLog(@"response message %@",jsonData[@"responseMessage"]);
             NSLog(@" response message %@",jsonData[@"data"]);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             
             [defaults setObject:[r_data  valueForKey:@"parttimerId"] forKey:@"parttimerId"];
             [defaults setObject:[r_data valueForKey:@"sessionId"] forKey:@"sessionId"];
             [defaults setObject:[r_data  valueForKey:@"userId"] forKey:@"userId"];
             [defaults synchronize];
            [self performSegueWithIdentifier:@"MySegue" sender:sender];
         }
         else if (success == 1006)
         {
             
             NSString *jsonString = [jsonData objectForKey:@"responseMessage"];
             CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
             DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:jsonString];
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
         else if (success == 1000)
         {
         
         
             if (jsonData[@"responseMessage"] != nil) {
                 NSLog(@"responseMessage :%@",jsonData[@"responseMessage"]);
 
                    
             NSMutableArray *copyArr = [[NSMutableArray alloc]init];
             self.data =  jsonData[@"data"];
             NSLog(@"data %@",jsonData[@"data"]);
             for (int i =0; i<self.data.count; i++) {
                 NSDictionary *jsonElement = self.data[i];
                 
                 // Add this question to the locations array
                 [copyArr addObject:jsonElement];
                 
             }
             
             
             NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
             NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
             
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
              [li showLoading:self.view animated:NO];
         }];
         
         [alertView setUseMotionEffects:true];
         
         // And launch the dialog
         [alertView show];

     }
     else
     {
     error_msg = @"Unknow Error";
     }
    
         CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
         DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Sign Up Failed!" message:error_msg];
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
         else if (success == 1014)
         {
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
             PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
             
             [self.navigationController presentViewController:vc animated:true completion:nil];

         }
     
     }
    else
     {
    
         
         CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
         DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Sign Up Failed!" message:@"Connection Failed"];
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

     else {
    
         CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
         DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Sign Up Failed!" message:error.localizedDescription];
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

#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MySegue"]) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //  PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        //vc.s_id = self.sessionID;
        // vc.p_id = self.partTimerID;
        // [self presentModalViewController:vc animated:YES];
        PreferenceVC *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
       
        [self presentModalViewController:tb animated:YES];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"MySegue"])
    {
        if (flag == false) {
            return NO;
        }
        
    }
    
    return YES;
    
}

#pragma  connection delegate
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    mutableData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"receiving session id and token data");
    NSString *sessiondIDandTokenResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"session id and token are %@", sessiondIDandTokenResponse);
    
    NSLog(@"parsing session id and token");
    
    NSArray *components = [sessiondIDandTokenResponse componentsSeparatedByString:@":"];
   NSString* kSessionId = [components objectAtIndex:0];
   NSString* kToken = [components objectAtIndex:1];
    
    NSLog(@"SessionID: %@", kSessionId);
    NSLog(@"Token: %@", kToken);

    [mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == serverConnection) {
        NSString *responseString = [[NSString alloc] initWithData:mutableData encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response: %@", responseString);
        
        
        //  if ([responseString isEqualToString:@"Added"]) {
        
        /* Make something on success */
        
        //  } else {
        
        /* Make something else if not completed with success */
        
        // }
        
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    /* Make something on failure */
   
    
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Connection Failed" message:@""];
    // Add some custom content to the alert view
    [alertView setContainerView:alert];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK",@"Retry", nil]];
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
// NSURLConnection Delegates
- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        NSLog(@"received authentication challenge");
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"USER"
                                                                    password:@"PASSWORD"
                                                                 persistence:NSURLCredentialPersistenceForSession];
        NSLog(@"credential created");
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        NSLog(@"responded to authentication challenge");
    }
    else {
        NSLog(@"previous authentication failure");
    }
}

#pragma  mark - facebook login
-(void)loginViewShowingLoggedInUser:(FBLoginView *)loginView{
    SignUpViewController *wc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]
                                instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    [self.navigationController pushViewController:wc animated:YES];
    
    
}


-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"%@", user);
}


-(void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
}


-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSLog(@"%@", [error localizedDescription]);
    
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if ((int)[alertView tag] ==1) {
        [serverConnection start];
    }
    [alertView close];
}


@end
