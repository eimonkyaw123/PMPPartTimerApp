//
//  FavouritViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "FavouritViewController.h"
#import "JobListCell.h"
#import "JobDetailViewController.h"
#import "JobDetail.h"
#import "LoadingImageViewController.h"


@interface FavouritViewController ()
{
    NSMutableArray * title;
    NSMutableArray * jobDate;
    NSMutableArray * jobTime;
    NSMutableArray * jobDateTime;
    NSMutableArray * place;
    NSMutableArray * cArr;
    NSMutableArray *img;
    NSMutableArray *price;
    
    NSMutableArray *recipes;
    
    NSString *ListTitle;
    NSString *ListDate;
    UIImage *ListImage;
    NSString *ListLocation;
    NSString *ListTime;
    NSString *ListPrice;
    
    NSString *chooseType;
    Service *s;
    
    int page;
    BOOL isPageRefreshing;
 LoadingImageViewController *li;
    CustomIOSAlertView *a;
    
}
@end

@implementation FavouritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.f_tableview.layoutMargins = UIEdgeInsetsZero;
    self.f_tableview.separatorInset = UIEdgeInsetsZero;
    self.f_tableview.scrollEnabled = YES;
    
    recipes = [[NSMutableArray alloc]init];
    chooseType = @"1";
    
    // service delegate
      li = [[LoadingImageViewController alloc]init];
    s= [[Service alloc]init];
    s.serviceDelegate= self;
    
    [li showLoading:self.view animated:YES];
    a= [[CustomIOSAlertView alloc]init];
    a.delegate = self;
    page = 1;
    
    //server calll
    [self getfavouritList:page];
   

    self.f_tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[self getfavouritList:page];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [recipes count];//[title count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobListCell     *cell = (JobListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
      //  JobDetail *recipe = [recipes objectAtIndex:indexPath.row];
    NSString *c_dateTime = [NSString stringWithFormat:@"%@,%@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"date"],[[recipes objectAtIndex:indexPath.row]objectForKey:@"time"]];
 cell.j_title.text= [[recipes objectAtIndex:indexPath.row]objectForKey:@"jobTypeName"];
    cell.j_date.text = c_dateTime;//[[recipes objectAtIndex:indexPath.row]objectForKey:@"date"];
     cell.j_location.image  = [UIImage imageNamed:@"ic-common-loc@2x.png"];
      //cell.j_image.image = [UIImage imageNamed:@"ic-job-list-usher.png"];
    
    if (![[recipes objectAtIndex:indexPath.row]objectForKey:@"imagepath"]) {
        cell.j_image.image  = [UIImage imageNamed:@"ic-signup-logo@2x.png"];
        
    }
    else
    {
        NSString *imageURL = [[recipes objectAtIndex:indexPath.row]objectForKey:@"imagepath"];
        NSData *urlData= [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        
        cell.j_image.image  = [UIImage imageWithData:urlData];
    }

  //   cell.j_image.image  = [UIImage imageNamed:@"ic-job-pref-usher-color@2x.png"];
    cell.j_place.text = [[recipes objectAtIndex:indexPath.row]objectForKey:@"postalcodedivision"];
    cell.j_price.text =[NSString stringWithFormat:@"$%@", [[recipes objectAtIndex:indexPath.row]objectForKey:@"total"]];
    cell.j_unit.text = @"per hour";
    cell.j_id.hidden = true;
 cell.j_id.text =[NSString stringWithFormat:@"%@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"id"]];
     NSLog(@"id %@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"id"]);
    NSLog(@"id %@",cell.j_id.text);
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"favouritDetail" sender:self];
}
#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"favouritDetail"]) {
        
        NSIndexPath * i =[self.f_tableview indexPathForSelectedRow];
        JobListCell *c = (JobListCell*)[self.f_tableview cellForRowAtIndexPath:i];
        ListTitle = c.j_title.text;
        ListImage = c.j_image.image;
        
        NSString *detailID= c.j_id.text;
        NSString *models = c.j_date.text;
        NSArray *modelsAsArray = [models componentsSeparatedByString:@","];
        NSLog(@"Date%@", [modelsAsArray objectAtIndex:0]);
        NSLog(@"Time%@", [modelsAsArray objectAtIndex:1]);
        ListDate =  [modelsAsArray objectAtIndex:0];
        ListTime = [modelsAsArray objectAtIndex:1];
        
        ListPrice = c.j_price.text;
        ListLocation = c.j_place.text;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FavouritDetailViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"FavouritDetailViewController"];
       vc= [segue destinationViewController];
        vc.jobtitle = ListTitle;
        vc.hour = ListTime;
        vc.price = ListPrice;
        vc.lcoation = ListLocation;
        vc.jobimage = ListImage;
        vc.jobdate = ListDate;
        vc.jd_id = detailID ;
        
        
        [self.navigationController presentModalViewController:vc animated:YES];
    }
}

-(void)getfavouritList:(int)page1
{
   
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
     // NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/jobListFavourite.htm?json=";
       NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/jobListFavourite.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"pageNo\":\"%d\",\"sortBy\":\"%d\",\"sessionId\":\"%@\"}",userID,page,5,sessionID];
     // NSString *data = [NSString stringWithFormat:FavouritJSON,userID,page,5,sessionID];
     [li showLoading:self.view animated:YES];
     [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_JOB_LIST_FAVOURIT] body:nil];
    
}

#pragma service delegate
-(void)ResponseFavourit:(NSDictionary *)f
{
     [li showLoading:self.view animated:NO];
    isPageRefreshing=NO;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [f[@"responseCode"]integerValue];
    if (self.code == 1002) {
        self.message = f[@"responseMessage"];
         NSLog(@" response message %@",f[@"responseMessage"]);
      
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
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        SignInViewController *signIn = [[SignInViewController alloc]init];
        [self.navigationController presentModalViewController:signIn animated:YES];
    }
    else if ( self.code == 1)
    {
     
        self.message = f[@"responseMessage"];
        self.data = f[@"data"];
         NSLog(@"response message %@",f[@"responseMessage"]);
         NSLog(@" response message %@",f[@"data"]);
        self.message = f[@"responseMessage"];
        if ([f[@"data"] count]>0) {
            self.data = f[@"data"];
            NSLog(@"message %@",f[@"responseMessage"]);
            NSLog(@"data %@",f[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            recipes = copyArr;
            [self.f_tableview reloadData];
        }
        
        else
        {
            self.f_tableview.hidden = true;
          
        }
        
    }
    else
    {
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

#pragma mark - for paging
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.f_tableview.contentOffset.y >= (self.f_tableview.contentSize.height - self.f_tableview.bounds.size.height))
    {
        
        if(isPageRefreshing==NO){
             [li showLoading:self.view animated:YES];
            isPageRefreshing=YES;
          
            [self getfavouritList:page++];//getNewJobList:page++];
            [self.f_tableview reloadData];
            NSLog(@"called %d",page);
        }
         [li showLoading:self.view animated:NO];
    }
}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if ((int)[alertView tag]==0) {
        [self getfavouritList:page];
    }
    [alertView close];
}

@end
