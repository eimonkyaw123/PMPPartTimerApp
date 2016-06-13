//
//  FavouritDetailViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/24/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "FavouritDetailViewController.h"
#import "Service.h"
@interface FavouritDetailViewController ()
{
    Service *s;
}
@end

@implementation FavouritDetailViewController
@synthesize jobtitle,lcoation,jobdate,price,hour,jobimage,jobColor,jd_id;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
       NSLog(@"Price %@", self.jd_id);

   self.btnfavourit.selected = false;
    
    self.btnApply.layer.cornerRadius = 18;
    self.btnApply.clipsToBounds = YES;

    [self setBorderView:self.v_time];
    [self setBorderView:self.v_requirement];
    [self setBorderView:self.v_reporting];
 NSLog(@"Price %@", self.jd_id);
    s=[[Service alloc]init];
    s.serviceDelegate = self;
     [self getJobFavourit];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)jobApplyAction:(id)sender {
}
#pragma marks- border color

-(void)setBorderView:(UIView*)v
{
    //top border
    UIView *topBorder = [UIView new];     topBorder.backgroundColor = [UIColor lightGrayColor];
    NSInteger borderThickness = 1;
    topBorder.frame = CGRectMake(0, 0, 400, borderThickness);
    [v addSubview:topBorder];
    
    //bottom border
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, 24 - borderThickness, 400, borderThickness);
    [v addSubview:bottomBorder];
}
- (IBAction)favouritAction:(id)sender {
    if (self.btnfavourit.selected) {
        self.btnfavourit.selected = false;
    }
    else
    {
        self.btnfavourit.selected = true;
    }
    

}
#pragma - load Data
-(void)getJobFavourit
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    
    //NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/jobDetail.htm?json=";
    NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/jobDetail.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"id\":\"%@\",\"sessionId\":\"%@\"}",self.jd_id ,sessionID];
    // NSString *data = [NSString stringWithFormat:FavouritDetailJSON,self.jd_id ,sessionID];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_JOB_DETAIL] body:nil];
    
}
-(void)ResponseFavouritDetail:(NSDictionary *)FD
{
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [FD[@"responseCode"]integerValue];
    if (self.code == 1002) {
        self.message = FD[@"responseMessage"];
        NSLog(@"message %@",FD[@"responseMessage"]);
    }
    else if ( self.code == 1)
    {
        NSMutableArray *arryData=[[NSMutableArray alloc]init];
        self.message = FD[@"responseMessage"];
        self.data = FD[@"data"];
        NSLog(@"message %@",FD[@"responseMessage"]);
        NSLog(@"data %@",FD[@"data"]);
        
        NSLog(@"job type :%@", FD[@"data"][@"reportPersonList"]);
        if ([FD[@"data"]count ]>0) {
            self.f_Title.text =  FD[@"data"][@"jobTypeName"];
            self.f_date.text = FD[@"data"][@"date"];
            self.f_place.text =  FD[@"data"][@"postalcodedivision"];
            self.f_Requirement.text = FD[@"data"][@"requirement"];
            self.f_Time.text = FD[@"data"][@"time"];
            self.f_price.text = [NSString stringWithFormat:@"$ %@",FD[@"data"][@"total"]];
            
            arryData = FD[@"data"][@"reportPersonList"];
            if ([arryData count]>0) {
                self.f_reportingPerson.text =arryData[0];
                self.f_phoneNo.text = arryData[1];
                
            }
            
        }
        
        
    }
    else if (self.code == 1000)
    {
        /*
        NSMutableArray *copyArr = [[NSMutableArray alloc]init];
        self.data =  FD[@"data"];
        NSLog(@"data %@",FD[@"data"]);
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
            
            //  NSString *message = message[0];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([fieldCode isEqualToString:@"2007"] )
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        */
        
    }
    if (self.code == 1002) {
        self.message = FD[@"responseMessage"];
        NSLog(@"message %@",FD[@"responseMessage"]);
    }
    else if (self.code == 1005)
    {
        self.message =FD[@"responseMessage"];
        NSLog(@"message %@",FD[@"responseMessage"]);
    }
    else if (self.code == 1)
    {
        self.message = FD[@"responseMessage"];
        NSLog(@"message %@",FD[@"responseMessage"]);
        
    }
    
    
}
#pragma -scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // we are at the end
        self.lblTitle.text = self.f_Title.text;
        
    }
    else
    {
        self.lblTitle.text = @"Job Details";
    }
}

@end
