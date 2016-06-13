 //
//  JobDetailViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/21/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "JobDetailViewController.h"
#import "UIView+Animation.h"
#import "FakeHUD.h"
#import <Accounts/Accounts.h>
#import "SignInViewController.h"
#import "SuccessFailViewController.h"
#import "CommonMessage.h"
#import "TabViewController.h"
#import "ProfileMainViewController.h"
#import "BankAccountViewController.h"
#import "LoadingImageViewController.h"
@interface JobDetailViewController ()<UIAlertViewDelegate,UITabBarControllerDelegate>
{
    UIButton *button1 ;
    Service *s;
    NSArray *reportingArr;
    BOOL accept;
     LoadingImageViewController *li;
    BOOL bank;
}
@property (strong, nonatomic) IBOutlet UIView *v_requirement;
@property (strong, nonatomic) IBOutlet UIView *v_time;


// for facebook share
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *fbAccount;
@property (strong, nonatomic) NSString *slService;
@property(nonatomic,strong)SuccessFailViewController *popViewController;


@end

@implementation JobDetailViewController

@synthesize jd_jobimage,jd_title,jd_location,jd_date,jd_price,jd_hour,jobtitle,lcoation,jobdate,price,hour,jobimage,jobColor,jd_id;
@synthesize recipe;

@synthesize accountStore = _accountStore;
@synthesize fbAccount = _fbAccount;
@synthesize slService = _slService;

- (void)viewDidLoad {
    [super viewDidLoad];
      self.btnApplyjob.layer.cornerRadius = 18;
      self.btnApplyjob.clipsToBounds = YES;
    [self setBorderView:self.v_time];
    [self setBorderView:self.v_requirement];
   [self setBorderView:self.v_reporting];
    bank = false;
    
   
    
    // to store fb acc initialize
     self.accountStore = [[ACAccountStore alloc] init];
     NSLog(@"Price %@", self.jd_id);
 li = [[LoadingImageViewController alloc]init];
    s= [[Service alloc]init];
    s.serviceDelegate = self;
    self.jd_Scroll.backgroundColor = [UIColor clearColor];

    [self getJobDetail];
   
    self.btnFavourit.selected = false;
    self.jd_Scroll.delegate  = self;
       self.reportingTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    accept = false;
   
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ApplyCancelJob:(id)sender {
   
    [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"bg_btnCancel.png"]
                      forState:UIControlStateSelected];
     }
- (IBAction)Alert:(id)sender {
    /*
    FakeHUD *theSubView = [FakeHUD newFakeHUD];
    theSubView.frame = CGRectMake(50, 150, theSubView.frame.size.width, theSubView.frame.size.height);
    [self.view addSubviewWithFadeAnimation:theSubView duration:1.0 option:UIViewAnimationOptionCurveEaseInOut];
     */
    /*
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Successfully accept job.Would you like to share this text" message:@"Happy and lucky days" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
      [alertView show];
*/
    /*
    [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"bg_btnCancel.png"]
                                forState:UIControlStateSelected];

    SLComposeViewController *fbVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    [fbVC setInitialText:@"Hello Facebook"];
    [fbVC addURL:[NSURL URLWithString:@"http://stackoverflow.com/questions/4385363/publishing-links-to-users-wall-using-facebook-ios-sdk"]];
    // [fbVC addImage:[UIImage imageNamed:@"forest.jpg"]];
    
    [self presentViewController:fbVC animated:YES completion:nil];
     */
    if ([sender isSelected] == YES)
    {
         accept = false;
        [sender setSelected:NO];
        if ([self.btnApplyjob.titleLabel.text isEqualToString:@"Apply for Job"]) {
            [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"grey-btn.png"] forState:UIControlStateNormal];
           
             [self getAcceptJob];
        }
        else if ([self.btnApplyjob.titleLabel.text isEqualToString:@"Cancel"]){
            
            [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"04-appicon-bg.png"] forState:UIControlStateNormal];
                [self getCancelJob];
            
        }
        
    }
    else
    {
        accept = true;
        [sender setSelected:YES];
        if ([self.btnApplyjob.titleLabel.text isEqualToString:@"Apply for Job"]) {
            [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"grey-btn.png"] forState:UIControlStateNormal];
            
             [self getAcceptJob];
        }
        else if ([self.btnApplyjob.titleLabel.text isEqualToString:@"Cancel"]){
            
            [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"04-appicon-bg.png"] forState:UIControlStateNormal];
            
        }
        
    }

   
    
   
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSArray *permissions = @[@"email", @"publish_actions"];
        
        // Set the dictionary that will be passed on to request
        // account access
        
        NSDictionary *fbInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"1762250287330919", ACFacebookAppIdKey,
                                permissions, ACFacebookPermissionsKey,
                                ACFacebookAudienceOnlyMe, ACFacebookAudienceKey,
                                nil];
        
        // Get the Facebook account type for the access request
        
        ACAccountType *fbAccountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
        
        // Request access to the Facebook account with the access info
        
        [self.accountStore requestAccessToAccountsWithType:fbAccountType options:fbInfo completion:^(BOOL granted, NSError *error) {
            if (granted) {
                // If access granted, then get the Facebook account info
                
                NSArray *accounts = [self.accountStore accountsWithAccountType:fbAccountType];
                
                self.fbAccount = [accounts lastObject];
                
                // Set the service type for this request. This will be
                // used by the share input flow to configure it's UI.
                self.slService = SLServiceTypeFacebook;
                
                // Since this handler can be called on an arbitrary queue
                // will show the UI in the main thread.
                
                // [self performSelectorOnMainThread:@selector(sendFacebookRequest:) withObject:[[alertView textFieldAtIndex:0] text] waitUntilDone:NO];
                [self performSelectorOnMainThread:@selector(sendFacebookRequest:) withObject:alertView.message waitUntilDone:NO];
                
            } else {
                NSLog(@"Access not granted");
            }
        }];
    }
}

- (void) sendFacebookRequest:(NSString *)message {
    // Put together the post parameters. The status message
    // is passed in the message parameter key.
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:message, @"message", nil];
    
    // Set up the Facebook Graph API URL for posting to a user's timeline
    NSURL *requestURL = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    
    // Set up the request, passing all the required parameters
    SLRequest *fbShareRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodPOST URL:requestURL parameters:params];
    
    // Set up the account for this request
    fbShareRequest.account = self.fbAccount;
    
    // Perform the request
    [fbShareRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        // In the completion handler, echo back the response
        // which should the Facebook post ID
        
        NSString *response = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"returned info: %@", response);
    }];
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

- (IBAction)FavouritAction:(id)sender {
    if (self.btnFavourit.selected) {
        self.btnFavourit.selected = false;
    }
    else
    {
        self.btnFavourit.selected = true;

        [li showLoading:self.jd_Scroll animated:YES];

        [self postFavourit];
    }

}

-(void)postFavourit
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    
    NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/favouriteInfo.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}",userID,self.jd_id ,sessionID];
    // NSString *data = [NSString stringWithFormat:MakeFavouritJSON,userID,self.jd_id ,sessionID];
    [li showLoading:self.jd_Scroll animated:YES];

    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_FAVOURIT] body:nil];

}

#pragma - load Data
-(void)getJobDetail
{

    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    
   // NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/jobDetail.htm?json=";
     NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/jobDetail.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"id\":\"%@\",\"sessionId\":\"%@\"}",self.jd_id ,sessionID];
   //  NSString *data = [NSString stringWithFormat:JobDetailJSON,self.jd_id ,sessionID];
     [li showLoading:self.jd_Scroll animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_JOB_DETAIL] body:nil];
    
}

-(void)ResponseJobDetail:(NSDictionary *)ND
{
    [li showLoading:self.jd_Scroll animated:NO];
    [li removeFromParentViewController];

    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [ND[@"responseCode"]integerValue];
     self.message = ND[@"responseMessage"];
    if ( self.code == 1)
    {
       
         NSMutableArray *arryData=[[NSMutableArray alloc]init];
        self.message = ND[@"responseMessage"];
        self.data = ND[@"data"];
        NSLog(@"message %@",ND[@"responseMessage"]);
        NSLog(@"data %@",ND[@"data"]);
        
        NSLog(@"job type :%@", ND[@"data"][@"reportPersonList"]);
        if ([ND[@"data"]count ]>0) {
            self.jd_title.text =  ND[@"data"][@"jobTypeName"];
            self.jd_date.text = ND[@"data"][@"date"];
            self.jd_location.text =  ND[@"data"][@"postalcodedivision"];
            self.jd_requirements.text = ND[@"data"][@"requirement"];
            self.jd_hour.text = ND[@"data"][@"time"];
            self.jd_price.text = [NSString stringWithFormat:@"$ %@",ND[@"data"][@"total"]];
            NSString *latitude = ND[@"data"][@"latitude"];
            NSString *longitude = ND[@"data"][@"longitude"];
            float lat =  [latitude floatValue];
            float lg = [longitude floatValue];
            //[self loadMapKit:lat lo:lg];
            NSString *location = @"570503";

            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder geocodeAddressString:location
                         completionHandler:^(NSArray* placemarks, NSError* error){
                             if (placemarks && placemarks.count > 0) {
                                 CLPlacemark *placemark = [placemarks lastObject];
                                 
                                 NSLog(@"%f", placemark.location.coordinate.latitude);
                                 NSLog(@"%f", placemark.location.coordinate.longitude);
                                 [self loadMapKit:placemark.location.coordinate.latitude lo: placemark.location.coordinate.longitude];
                             }
                         }
             ];

            arryData = ND[@"data"][@"reportPersonList"];
            if ([arryData count]>0) {
                /*
                for (int k =0; k< arryData.count; k++) {
                    NSLog(@"contactNo :%@",arryData[k][@"contactNo"] );
                    NSLog(@"name :%@",arryData[k][@"name"] );
                }
                 */
                for (int i =0; i<arryData.count; i++) {
                    NSDictionary *jsonElement = arryData[i];
                    
                    // Add this question to the locations array
                    [copyArr addObject:jsonElement];
                    
                }
                NSLog(@"copy %@",copyArr);
                reportingArr  = copyArr;
                self.jd_Scroll.contentSize= CGSizeMake(self.view.frame.size.width, self.jd_Scroll.frame.size.height + self.reportingTbl.frame.size.height);
            }
            
                }
        else if (accept == true)

        {
            [self.btnApplyjob setBackgroundImage:[UIImage imageNamed:@"bg_btnCancel.png"]
                                        forState:UIControlStateSelected];
            
            SLComposeViewController *fbVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [fbVC setInitialText:@"Hey! I've got a job via HugHippo.  Download mobile application here: http://www.hughippo.com/download"];
            
            [self presentViewController:fbVC animated:YES completion:nil];

        }
        
    }
    else if (self.code == 1000)
    {
            
            NSMutableArray *copyArr = [[NSMutableArray alloc]init];
            self.data =  ND[@"data"];
            NSLog(@"data %@",ND[@"data"]);
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
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];

    }
    else if (self.code == 1002) {
        self.message = ND[@"responseMessage"];
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
    else if (self.code == 1010)
    {
        self.message = ND[@"responseMessage"];
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
        TabViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
        [self tabBarController:vc didSelectViewController:self];
       [self presentModalViewController:vc animated:YES];
    }
    else if (self.code == 1011)
    {
        self.message = ND[@"responseMessage"];
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
        TabViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
        [self tabBarController:vc didSelectViewController:self];
      
        
       // [self presentViewController:pm animated:true completion:^{[pm.tabBarVC setSelectedIndex:1]; pm.btnBankAccount.selected = true; pm.btnPassword.selected= false; pm.btnProfileDetail.selected = false;}];
      
        ProfileMainViewController *pm = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileMainViewController"];
        [pm setupViews];
        
       // [self presentViewController:pm animated:true completion:^{[pm.tabBarVC setSelectedIndex:1]; pm.btnBankAccount.selected = true; pm.btnPassword.selected= false; pm.btnProfileDetail.selected = false;}];
        /*
        BankAccountViewController *firstVC = [[pm.tabBarVC viewControllers] objectAtIndex:1];
        [pm.tabBarVC.selectedViewController.view removeFromSuperview];
        [pm.view insertSubview:firstVC.view belowSubview:pm.tabBarVC.view];
        [pm.tabBarVC setSelectedIndex:1];
        pm.tabBarVC.selectedViewController = firstVC;
*/
        [pm.tabBarVC.delegate tabBarController:pm.tabBarVC shouldSelectViewController:[[pm.tabBarVC viewControllers] objectAtIndex:1]];
        [pm.tabBarVC setSelectedIndex:1];
             
    }
    else
    {
         self.message = ND[@"responseMessage"];
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
- (void)tabBarController:(TabViewController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
   
        [tabBarController setSelectedIndex:2];
  }

-(void)getAcceptJob
{
      NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];

   // NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/acceptJob.htm?json=";
     NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/acceptJob.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}",userID ,self.jd_id ,sessionID];
     // NSString *data = [NSString stringWithFormat:AcceptJobJSON ,userID ,self.jd_id ,sessionID];
    [li showLoading:self.jd_Scroll animated:YES];


    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_ACCEPT_JOB] body:nil];
}

-(void)getCancelJob
{
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    

   // NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/cancelJob.htm?json=";
     NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/cancelJob.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"jobId\":\"%@\",\"sessionId\":\"%@\"}",userID ,self.jd_id,sessionID];
    // NSString *data = [NSString stringWithFormat:CancelJobJSON,userID ,self.jd_id,sessionID];
    [li showLoading:self.jd_Scroll animated:YES];

    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_CANCEL_JOB] body:nil];
}



#pragma -scrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        // we are at the end
        self.lblNoti.text = self.jd_title.text;

    }
    else
    {
        self.lblNoti.text = @"Job Details";
    }
}

#pragma  - load mapkit
- (DBMapSelectorManager *)mapSelectorManager {
    if (nil == _mapSelectorManager) {
        _mapSelectorManager = [[DBMapSelectorManager alloc] initWithMapView:self.mk];
        _mapSelectorManager.delegate = self;
    }
    return _mapSelectorManager;
}

-(void)loadMapKit:(float)latitude lo:(float)longitude
{
    self.mk.showsUserLocation = YES;
    
    // Set map selector settings
    self.mapSelectorManager.circleCoordinate =CLLocationCoordinate2DMake(latitude, longitude);
    self.mapSelectorManager.circleRadius = 3000;
    self.mapSelectorManager.circleRadiusMax = 25000;
    [self.mapSelectorManager applySelectorSettings];
    
    self.mapSelectorManager.fillColor = [UIColor redColor];//_fillColorDict[fillColorKey];
    
    self.mapSelectorManager.strokeColor = [UIColor clearColor];
    
    self.mapSelectorManager.editingType = DBMapSelectorEditingTypeNone;
    self.mapSelectorManager.fillInside =1;
}
#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    return [self.mapSelectorManager mapView:mapView viewForAnnotation:annotation];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    [self.mapSelectorManager mapView:mapView annotationView:annotationView didChangeDragState:newState fromOldState:oldState];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    return [self.mapSelectorManager mapView:mapView rendererForOverlay:overlay];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.mapSelectorManager mapView:mapView regionDidChangeAnimated:animated];
}

#pragma  mark - reporting person tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    return [reportingArr count] ;//[recipes count];//[title count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportingCell     *cell = (ReportingCell *)[tableView dequeueReusableCellWithIdentifier:@"ReportingCell"];
    NSMutableArray* json = [reportingArr objectAtIndex:indexPath.row];
    NSLog(@"data %@",json);
    
    cell.rp_name.text= [[reportingArr objectAtIndex:indexPath.row]objectForKey:@"name"];
     cell.rp_Ph.text= [[reportingArr objectAtIndex:indexPath.row]objectForKey:@"contactNo"];
    
    return cell;
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.jd_Scroll animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}

@end
