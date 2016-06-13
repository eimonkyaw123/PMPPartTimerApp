//
//  ViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "ViewController.h"
#import "SignUpViewController.h"
#import "SignInViewController.h"
@interface ViewController ()

{
    NSInteger * pID ;
    NSString * sessionID;
}
@property (strong, nonatomic) IBOutlet FBLoginView *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIView *s_view;
@property(strong,nonatomic)Service *s;
@property(strong,nonatomic)LoadingImageViewController *li;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     self.navigationController.navigationBarHidden = YES;
    
     self.loginButton.layer.cornerRadius = 25;
   
    self.btnSignUp.layer.cornerRadius = 18;
    
    [[self.btnSignUp layer] setBorderWidth:2.0f];
    [[self.btnSignUp layer]setBorderColor:[UIColor whiteColor].CGColor];
    self.s_view = [[UIView alloc]init];
    self.s_view.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    self.s_view.layer.borderWidth = 2.0f;
    self.s_view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.s_view];
    
    self.loginButton.delegate = self;
    self.loginButton.readPermissions = @[@"public_profile", @"email"];
   // [self checkUser];
    self.s= [[Service alloc]init];
    self.s.serviceDelegate = self;
    self.li = [[LoadingImageViewController alloc]init];

}
-(void)viewWillAppear:(BOOL)animated
{
      [self checkUser];
    self.navigationController.navigationBarHidden = YES;
}

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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"User logged out.../");
    SignUpViewController * s = [[SignUpViewController alloc]init];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
*/

- (IBAction)SignUp:(id)sender {
   
}

-(void)checkUser
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   pID = [[userDefaults objectForKey:@"parttimerId"]integerValue];
     sessionID = [userDefaults objectForKey:@"sessionId"];
    
    NSLog(@"user ID :%d",pID);
    NSLog(@"sesion ID :%@",sessionID);
    if (pID !=0) {
        NSString * baseURL = @"http:/192.168.1.47:8080/api/parttimer/preferenceList.htm?json=";
        NSString *data=[NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",pID  ,sessionID];
       [self.li showLoading:self.view animated:YES];
        [self.s sendDataToServer:POST_METHOD JsonData:data sendURl:baseURL body:nil];

    }
    
}
-(void)ResponseFlashScreen:(NSDictionary*)cp
{
    [self.li showLoading:self.view animated:NO];
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [cp[@"responseCode"]integerValue];
    NSLog(@"Code %d",self.code);
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
        
    
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        
        [self.navigationController presentViewController:vc animated:true completion:nil];        //TabViewController *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
       // tb.s_id = sessionID;
       // tb.p_id = pID;
       // [tb setSelectedIndex:0];
       // [self presentModalViewController:tb animated:YES];

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
    else if (self.code == 1014)
    {
         [self performSegueWithIdentifier:@"Preference" sender:self];
    }
    else
    {
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:@"HTTP Error (500): Error occurred on server"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Preference"]) {
        
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     
        PreferenceVC *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        
        [self presentModalViewController:tb animated:YES];
    }
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [self.li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}


@end
