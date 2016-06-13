//
//  SettingViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/2/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    UISwitch *newjobAlert;
    UISwitch *newsAlert;
    UISwitch *workRemainder;
    Service *s;
    int newjobFlag;
    int newsFlag;
    int remainderFlag;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     newjobAlert = [[UISwitch alloc] initWithFrame:CGRectMake(257, 125, 0, 0)];
    newjobAlert.onTintColor = [UIColor grayColor];
    [newjobAlert addTarget:self action:@selector(changeNewJobSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:newjobAlert];
    
    newsAlert = [[UISwitch alloc] initWithFrame:CGRectMake(257, 180, 0, 0)];
    newsAlert.onTintColor = [UIColor grayColor];

    [newsAlert addTarget:self action:@selector(changeNewsSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:newsAlert];
    
    workRemainder = [[UISwitch alloc] initWithFrame:CGRectMake(257, 234, 0, 0)];
    workRemainder.onTintColor = [UIColor grayColor];

    [workRemainder addTarget:self action:@selector(changeWorkRemainderSwitch:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:workRemainder];
    
    s=[[Service alloc]init];
    s.serviceDelegate = self;
    
    newjobFlag = 0;
    newsFlag = 0;
    remainderFlag = 0;
    [self getSettingInfo];
  
    }
- (void)changeNewJobSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Switch is ON");
        newjobFlag = 1;
    } else{
        NSLog(@"Switch is OFF");
        newjobFlag = 0;
    }
    [self postSetting];
}
- (void)changeNewsSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Switch is ON");
        newsFlag = 1;
    } else{
        NSLog(@"Switch is OFF");
         newsFlag = 0;
    }
     [self postSetting];
}

- (void)changeWorkRemainderSwitch:(id)sender{
    if([sender isOn]){
        NSLog(@"Switch is ON");
        remainderFlag = 1;
    } else{
        NSLog(@"Switch is OFF");
        remainderFlag = 0;
    }
     [self postSetting];
}

-(void)viewWillLayoutSubviews
{}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - call server function
-(void)postSetting
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
  //  NSString *settingInfo = @"http://192.168.1.47:8080/api/parttimer/noti-setting.htm?json=";
      NSString *settingInfo = @"http://ihughos.com/api/parttimer/noti-setting.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"newjobalert\":\"%d\",\"newsalert\":\"%d\",\"workremainder\":\"%d\",\"sessionId\":\"%@\"}",userID,newjobFlag,newsFlag,remainderFlag,sessionID];
    
  //  NSString *data = [NSString stringWithFormat:SettingJSON,userID,newjobFlag,newsFlag,remainderFlag,sessionID];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_NOTI_SETTING] body:nil];
}

-(void)getSettingInfo
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    //NSString *settingInfo = @"http://192.168.1.47:8080/api/parttimer/noti-setting-list.htm?json=";
    NSString *settingInfo = @"http://ihughos.com/api/parttimer/noti-setting-list.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",userID,sessionID];
   //  NSString *data = [NSString stringWithFormat:GetSettingJSON,userID,sessionID];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_NOTI_SETTING_LIST] body:nil];
}
#pragma marks- service delegate
-(void)ResponseSettingInfo:(NSDictionary *)si
{
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [si[@"responseCode"]integerValue];
    if (self.code == 1002) {
        self.message = si[@"responseMessage"];
        NSLog(@" response message %@",si[@"responseMessage"]);
    }
    else if ( self.code == 1)
    {
        
        self.message = si[@"responseMessage"];
        self.data = si[@"data"];
        NSLog(@"response message %@",si[@"responseMessage"]);
        NSLog(@" response message %@",si[@"data"]);
        self.message = si[@"responseMessage"];
        if ([si[@"data"] count]>0) {
            self.data = si[@"data"];
            NSLog(@"message %@",si[@"responseMessage"]);
            NSLog(@"data %@",si[@"data"]);
            if ([si[@"data"]count ]>0) {
                NSString *d_newjob =  [NSString stringWithFormat:@"%@",si[@"data"][@"newjobalert"]];
                NSString *d_news= [NSString stringWithFormat:@"%@",si[@"data"][@"newsalert"]];
                 NSString *d_remainder =   [NSString stringWithFormat:@"%@",si[@"data"][@"workremainder"]];
                if ([d_newjob isEqualToString:@"1"]) {
                    [newjobAlert setOn:YES animated:YES];
                }
                else
                {
                   [newjobAlert setOn:false animated:YES];
                }
                
                if ([d_news isEqualToString:@"1"]) {
                    [newsAlert setOn:YES animated:YES];
                }
                else
                {
                    [newsAlert setOn:false animated:YES];
                }

                
                if ([d_remainder isEqualToString:@"1"]) {
                    [workRemainder setOn:YES animated:YES];
                }
                else
                {
                    [workRemainder setOn:false animated:YES];
                }

            }
        }
        
    }
}
@end
