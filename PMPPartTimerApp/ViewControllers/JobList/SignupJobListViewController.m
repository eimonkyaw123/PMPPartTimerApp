//
//  SignupJobListViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SignupJobListViewController.h"
#import "JobListCell.h"
#import "JobDetail.h"
#import "SignupJobDetailViewController.h"

@interface SignupJobListViewController ()
{
    NSArray *recipes;
    NSString *detailTitle;
    NSString *detailDate;
    UIImage *detailImage;
    NSString *detailLocation;
    NSString *detailTime;
    NSString *detailPrice;
    Service *s;
     NSString *ListType;
}
@end

@implementation SignupJobListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JobDetail *jd2 = [JobDetail new];
    jd2.jobtitle = @"JXCK Wedding Banquet";
    jd2.jobdate =@"29 Mar 2016";
    jd2.jobimage = @"ic-job-list-banquet@2x.png";
    jd2.lcoation = @"Central ,Waiter";
    jd2.hour = @" 12pm - 3pm";
    jd2.price = @"$12";
    jd2.jobColor = [UIColor purpleColor];
     recipes = [NSArray arrayWithObjects:jd2, nil];

    self.tableview.layoutMargins = UIEdgeInsetsZero;
    self.tableview.separatorInset = UIEdgeInsetsZero;
    ListType = @"1";
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
    JobDetail *recipe = [recipes objectAtIndex:indexPath.row];
    cell.j_image.image = [UIImage imageNamed:recipe.jobimage];;
    //cell.j_image.tintColor  =recipe.jobColor;
    cell.j_date.text = [NSString stringWithFormat:@"%@, %@",recipe.jobdate,recipe.hour];//recipe.jobdate;
    cell.j_location.image  = [UIImage imageNamed:@"ic-common-loc@2x.png"];
    cell.j_place.text = recipe.lcoation;
    cell.j_price.text = recipe.price;
    cell.j_price.textColor = [UIColor redColor];
    cell.j_title.text= recipe.jobtitle;
    cell.j_unit.text = @"per hour";
    cell.j_imgbackview.backgroundColor  = recipe.jobColor;
     cell.layoutMargins = UIEdgeInsetsZero;
    /*
     cell.j_image.image = [UIImage imageNamed:[img objectAtIndex:indexPath.row]];;
     cell.j_image.tintColor  =[cArr objectAtIndex:indexPath.row];
     cell.j_date.text = [jobDateTime objectAtIndex:indexPath.row];
     cell.j_location.image  = [UIImage imageNamed:@"ic-common-loc@2x.png"];
     cell.j_place.text = [place objectAtIndex:indexPath.row];
     cell.j_price.text = [price objectAtIndex:indexPath.row];
     cell.j_price.textColor = [UIColor redColor];
     cell.j_title.text= [title objectAtIndex:indexPath.row];
     cell.j_unit.text = @"per hour";
     cell.j_imgbackview.backgroundColor  = [cArr objectAtIndex:indexPath.row];
     */
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self performSegueWithIdentifier:@"Detail" sender:self];
    /*
     JobDetailViewController *j = [[JobDetailViewController alloc]init];
     j.recipe = [recipes objectAtIndex:indexPath.row];
     [self.navigationController presentModalViewController:j animated:YES];
     */
    
   //[self performSegueWithIdentifier:@"Detail" sender:self];
    /*
     j.jobtitle = [title objectAtIndex:indexPath.row];
     j.jd_location =[place objectAtIndex:indexPath.row];
     j.jd_price =[price objectAtIndex:indexPath.row];
     j.jd_date =[jobDate objectAtIndex:indexPath.row];
     j.jd_hour =[jobTime objectAtIndex:indexPath.row];
     /*
     if ([_delegate respondsToSelector:@selector(JobDetailData:location:date:price:hour:jimg:jColor:)])
     {
     [_delegate JobDetailData:[title objectAtIndex:indexPath.row] location:[place objectAtIndex:indexPath.row] date:[jobDate objectAtIndex:indexPath.row] price: [price objectAtIndex:indexPath.row] hour:[jobTime objectAtIndex:indexPath.row] jimg:[img objectAtIndex:indexPath.row] jColor: [cArr objectAtIndex:indexPath.row]];
     
     }
     */
    
    
    //:j animated:YES];
    
}
#pragma Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Detail"]) {
        
        NSIndexPath * i =[self.tableview indexPathForSelectedRow];
        JobListCell *c = (JobListCell*)[self.tableview cellForRowAtIndexPath:i];
        detailTitle = c.j_title.text;
        detailImage = c.j_image.image;
    
        NSString *models = c.j_date.text;
        NSArray *modelsAsArray = [models componentsSeparatedByString:@","];
        NSLog(@"Date%@", [modelsAsArray objectAtIndex:0]);
        NSLog(@"Time%@", [modelsAsArray objectAtIndex:1]);
        detailDate =  [modelsAsArray objectAtIndex:0];
        detailTime = [modelsAsArray objectAtIndex:1];
        
        detailPrice = c.j_price.text;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SignupJobDetailViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SignupJobDetailViewController"];
        vc.detail_Title = detailTitle;
        vc.detail_Time = detailTime;
        vc.detail_Price = detailPrice;
        vc.detail_Location = detailLocation;
        vc.detail_Image = detailImage;
        vc.detail_Date = detailDate;
        
       
        [self.navigationController presentModalViewController:vc animated:YES];
    }
}

- (IBAction)ChooseFavouritAction:(id)sender {
    UIButton *showBtn = sender;
    
    PopoverView *popoverView = [PopoverView new];
    
    popoverView.menuTitles   = @[@"Highest pay", @"Job Type", @"Favorites", @"Earliest date", @"Latest date"];
    __weak __typeof(&*self)weakSelf = self;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        
        weakSelf.lblFavourit.text = popoverView.menuTitles[index];
        
    }];
    if ([self.lblFavourit.text isEqualToString:@"Highest pay"]) {
        ListType = @"1";
    }
    else if ([self.lblFavourit.text isEqualToString:@"Job Type"])
    {
        ListType = @"2";
    }
    else if ([self.lblFavourit.text isEqualToString:@"Earliest date"])
    {
        ListType = @"3";
    }
    else if ([self.lblFavourit.text isEqualToString: @"Latest date"])
    {
        ListType = @"4";
    }
}

-(void)getPastJobList
{
    /*
     http://localhost:9090/api/parttimer/jobList.htm?json={"partTimerId":4,"pageNo":1,"sortBy":1}
     */
    NSInteger userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    NSString *sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    
    NSString *ProfilePSW = @"http://192.168.1.47:8080/api/parttimer/jobList.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"pageNo\":\"%d\",\"sortBy\":\"%@\",\"filter\":\"%@\",\"sessionId\":\"%@\"}",userID,1,ListType ,@"past",sessionID ];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:ProfilePSW body:nil];
    
}

#pragma service delegate
-(void)ResponseNewJob:(NSDictionary *)NJ
{
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [NJ[@"responseCode"]integerValue];
    if (self.code == 1002) {
        self.message = NJ[@"responseMessage"];
        NSLog(@"message %@",NJ[@"responseMessage"]);
    }
    else if ( self.code == 1)
    {
        
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
    
}


@end
