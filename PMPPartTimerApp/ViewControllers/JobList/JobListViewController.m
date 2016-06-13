//
//  jlistViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "JobListViewController.h"
#import "JobListCell.h"
#import "JobDetailViewController.h"
#import "JobDetail.h"
#import "LoadingImageViewController.h"
@interface JobListViewController ()
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
    int ListType;
    Service *s;

    int page;
    BOOL isPageRefreshing;
    LoadingImageViewController *li;
}

@end

@implementation JobListViewController
@synthesize filter;
- (void)viewDidLoad {
    [super viewDidLoad];
  
    recipes = [[NSMutableArray alloc]init];
    s= [[Service alloc]init];
    ListType = 1;
    s.serviceDelegate = self;
    page = 1;
  //  self.tableview.layoutMargins = UIEdgeInsetsZero;
  //  self.tableview.separatorInset = UIEdgeInsetsZero;
   // self.tableview.scrollEnabled = YES;
    [self getNewJobList:page chooseType:ListType];
    ////[self.tableview sizeToFit];
  //  self.tableview.frame = CGRectMake(0,52,400,800);
  // self.tableview.contentSize=CGSizeMake(self.view.frame.size.width,600);
 //appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
       self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    li = [[LoadingImageViewController alloc]init];
    self.noJobList.hidden = true;
    NSLog(@"Filter %@",filter);
   
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self adjustHeightOfTableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
     NSLog(@"Setting numberOfRowsInSection to %lu",(unsigned long)[recipes count]);
    return recipes.count ;//[recipes count];//[title count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobListCell     *cell = (JobListCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSMutableArray* json = [recipes objectAtIndex:indexPath.row];
    NSLog(@"data %@",json);
    NSString *c_dateTime = [NSString stringWithFormat:@"%@,%@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"date"],[[recipes objectAtIndex:indexPath.row]objectForKey:@"time"]];
    cell.j_title.text= [[recipes objectAtIndex:indexPath.row]objectForKey:@"jobTypeName"];
    cell.j_date.text = c_dateTime;//[[recipes objectAtIndex:indexPath.row]objectForKey:@"date"];
    cell.j_location.image  = [UIImage imageNamed:@"ic-common-loc@2x.png"];

    /*
     
     [self.image setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"placeholder.png"]]; 
     */
    
//    NSString *imageURL = @"http://192.168.1.47:8080/employer/uploadImage/jobGroup/24711941293566_favicon.png";
  //  NSData *urlData= [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    
  //  cell.j_image.image  = [UIImage imageWithData:urlData];//[UIImage imageNamed:@"ic-job-pref-usher-color@2x.png"];
  cell.j_image.image  = [UIImage imageNamed:@"ic-signup-logo@2x.png"];;
    cell.j_image.frame  = CGRectMake(cell.j_image.frame.origin.x, cell.j_image.frame.origin.y,
                                     cell.j_image.image.size.width, cell.j_image.image.size.height);
    cell.j_place.text = [[recipes objectAtIndex:indexPath.row]objectForKey:@"postalcodedivision"];
    cell.j_price.text =[NSString stringWithFormat:@"$%@", [[recipes objectAtIndex:indexPath.row]objectForKey:@"total"]];
    cell.j_unit.text = @"per hour";
    cell.j_id.hidden = true;
    cell.j_id.text =[NSString stringWithFormat:@"%@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"id"]];
     NSLog(@"description %@",[[recipes objectAtIndex:indexPath.row]objectForKey:@"id"]);
      // [cell setNeedsUpdateConstraints];
    //[cell updateConstraintsIfNeeded ];
       return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
         [self performSegueWithIdentifier:@"JobListDetail" sender:self];
}
- (void)adjustHeightOfTableview
{
    CGFloat height = self.tableview.contentSize.height;
    CGFloat maxHeight = self.tableview.superview.frame.size.height - self.tableview.frame.origin.y;
    
    // if the height of the content is greater than the maxHeight of
    // total space on the screen, limit the height to the size of the
    // superview.
    
    if (height > maxHeight)
        height = maxHeight;
    
    // now set the height constraint accordingly
    
    [UIView animateWithDuration:0.25 animations:^{
        self.tableViewHeightConstraint.constant = height;
        [self.view setNeedsUpdateConstraints];
    }];
}
#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"JobListDetail"]) {
        
        NSIndexPath * i =[self.tableview indexPathForSelectedRow];
        JobListCell *c = (JobListCell*)[self.tableview cellForRowAtIndexPath:i];
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
        JobDetailViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"JobDetailViewController"];
       
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
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath isEqual:((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject])]){
        //end of loading
        
    }
}
-(void)tableViewScrollToBottomAnimated:(BOOL)animated {
    NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
    [self.tableview selectRowAtIndexPath:myIndexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
}
-(void)getNewJobList:(int)page1 chooseType:(int)type
{
    /*
     http://localhost:9090/api/parttimer/jobList.htm?json={"partTimerId":4,"pageNo":1,"sortBy":1}
     */
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    
    //NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/jobList.htm?json=";
     NSString *ProfilePSW = @"http://ihughos.com/api/parttimer/jobList.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"pageNo\":\"%d\",\"sortBy\":\"%d\",\"filter\":\"%@\",\"sessionId\":\"%@\"}",userID,page1,ListType ,@"new",sessionID ];
    // NSString *data = [NSString stringWithFormat:JobListJSON,userID,page1,ListType ,@"new",sessionID ];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_JOB_LIST] body:nil];
    
}

#pragma service delegate
-(void)ResponseNewJob:(NSDictionary *)NJ
{
     [li showLoading:self.view animated:NO];
    isPageRefreshing=NO;
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [NJ[@"responseCode"]integerValue];
    self.message = NJ[@"responseMessage"];
    if (self.code == 1002) {
        
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
    else if ( self.code == 1)
    {
        self.noJobList.hidden = false;
        // [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([NJ[@"data"] count]>0) {
            self.data = NJ[@"data"];
            NSLog(@"message %@",NJ[@"responseMessage"]);
            NSLog(@"data %@",NJ[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            recipes = copyArr;
            [self.tableview reloadData];
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

- (IBAction)ChooseTypeAction:(id)sender {
    UIButton *showBtn = sender;
    
    PopoverView *popoverView = [PopoverView new];
    
    popoverView.menuTitles   = @[@"Highest pay", @"Job Type", @"Favorites", @"Earliest date", @"Latest date"];
    __weak __typeof(&*self)weakSelf = self;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        
        weakSelf.lblType.text = popoverView.menuTitles[index];
        
    }];
    if ([self.lblType.text isEqualToString:@"Highest pay"]) {
        ListType = 1;
        [self getNewJobList:page chooseType:ListType];
    }
    else if ([self.lblType.text isEqualToString:@"Job Type"])
    {
        ListType = 2;
         [self getNewJobList:page chooseType:ListType];
    }
    else if ([self.lblType.text isEqualToString:@"Earliest date"])
    {
        ListType = 3;
         [self getNewJobList:page chooseType:ListType];
    }
    else if ([self.lblType.text isEqualToString: @"Latest date"])
    {
        ListType =4;
         [self getNewJobList:page chooseType:ListType];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.tableview.contentOffset.y >= (self.tableview.contentSize.height - self.tableview.bounds.size.height))
    {
        if(isPageRefreshing==NO){
            isPageRefreshing=YES;
            [self getNewJobList:page++ chooseType:ListType];//getNewJobList:page++];
            [self.tableview reloadData];
            NSLog(@"called %d",page);
        }
    }
     [li showLoading:self.view animated:NO];
}




@end
