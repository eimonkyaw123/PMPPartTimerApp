//
//  NewsMainViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/27/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "NewsMainViewController.h"
#import "NewsListCell.h"
#import "NewsDetail.h"
#import "PopoverView.h"
#import "LoadingImageViewController.h"
#import "NewsDetailViewController.h"
@interface NewsMainViewController ()
{
     NSMutableArray *news_List;
    Service *s;
    
    int page;
    BOOL isPageRefreshing;
    LoadingImageViewController *li;
}
@property (nonatomic, strong) NewsListCell *prototypeCell;
@property (nonatomic) CGFloat expandedCellHeight;
@property (strong, nonatomic) NSMutableArray *expandedIndexPaths;
@end

@implementation NewsMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // fix width tablecell with viewcontroller width
    self.newsList_tableview.layoutMargins = UIEdgeInsetsZero;
    self.newsList_tableview.separatorInset = UIEdgeInsetsZero;
   
    // server delegate
    s=[[Service alloc]init];
    s.serviceDelegate = self;
     page = 1;
    [self getNewUpdate:page];
    news_List = [[NSMutableArray alloc]init];
   self.noNewsUpadte.hidden = true;
    appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
   
     self.newsList_tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    li = [[LoadingImageViewController alloc]init];
     self.expandedIndexPaths = [NSMutableArray array];
   }


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
     [self getNewUpdate:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      NSLog(@"Setting numberOfRowsInSection to %lu",(unsigned long)[news_List count]);
    // Return the number of rows in the section.
    return [news_List count];//[title count];
}
-(void)tableViewScrollToBottomAnimated:(BOOL)animated {
    NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
    [self.newsList_tableview selectRowAtIndexPath:myIndexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   NewsListCell     *cell = (NewsListCell *)[tableView dequeueReusableCellWithIdentifier:@"NewsList"];
       NSDictionary* json  = [news_List objectAtIndex:indexPath.row];
   
    NSLog(@"date %@",[news_List objectAtIndex:indexPath.row]);
    cell.newsDate.text =json[@"date"];
    cell.newsMessage.text =  json[@"message"];
cell.newsMessage.numberOfLines = 3;
   
    [cell configureText: cell.newsMessage.text forExpandedState:[self.expandedIndexPaths containsObject:indexPath]];
    //  cell.secondaryLabel.text = [self.descArray objectAtIndex:indexPath.row];
    //  [cell configureText:[self.descArray objectAtIndex:indexPath.row] forExpandedState:[self.expandedIndexPaths containsObject:indexPath]];
    cell.delegate = self;

    // fix width tablecell with viewcontroller width
    cell.layoutMargins = UIEdgeInsetsZero;
   
    return cell;
}


-(void)getNewUpdate:(int)page1
{
      NSInteger  userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"userId"]integerValue];
  
   NSString * sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
 //   NSString *updateNews = @"http://192.168.1.47:8080/api/parttimer/newsUpdateList.htm?json=";
       NSString *updateNews = @"http://ihughos.com/api/parttimer/newsUpdateList.htm?json=";
     NSString *data=[NSString stringWithFormat:@"{\"userId\":\"%d\",\"sessionId\":\"%@\",\"pageNo\":\"%d\"}",userID,sessionID,page1];
     //NSString *data=[NSString stringWithFormat:NewsJSON,userID,sessionID,page1];
  
    [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_NEWS_UPDATE_LIST] body:nil];
}

#pragma service delegate
-(void)ResponseUpdateNews:(NSDictionary *)NJ
{
     isPageRefreshing=NO;
  //  [MBProgressHUD hideHUDForView:self.view animated:YES];
  //  [li stopAnimation];
    //[li removeFromParentViewController];
   // [li dismissViewControllerAnimated:YES completion:nil];
     [li showLoading:self.view animated:NO];
   
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
            news_List = copyArr;
            [self.newsList_tableview reloadData];
        }
        
        else
        {
            self.noNewsUpadte.hidden =true;
        }
        
        
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if(self.newsList_tableview.contentOffset.y >= (self.newsList_tableview.contentSize.height - self.newsList_tableview.bounds.size.height))
    {
        if(isPageRefreshing==NO){
            isPageRefreshing=YES;
          
            [self getNewUpdate:page++];//getNewJobList:page++];
            [self.newsList_tableview reloadData];
            NSLog(@"called %d",page);
        }
         [li showLoading:self.view animated:NO];
    }
}


#pragma mark - read more function //
- (void)didTapOnMoreButton:(NewsListCell *)cell {
   [self performSegueWithIdentifier:@"NewsDetail" sender:cell];
    /*
    NSIndexPath *indexPath = [self.newsList_tableview indexPathForCell:cell];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewsDetailViewController    *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    NSDictionary* rd_Data  = [news_List objectAtIndex:indexPath.row];
    
    vc.ndDate =rd_Data[@"date"];
    vc.ndMessage=  rd_Data[@"message"];
    NSLog(@"date %@",rd_Data[@"date"]);
    
    NSLog(@"%@",[news_List objectAtIndex:indexPath.row]);
    
    
   
    
    
    [self presentModalViewController:vc animated:YES];
    
   // NSIndexPath *indexPath = [self.newsList_tableview indexPathForCell:cell];
     //[self performSegueWithIdentifier:@"NewsDetail" sender:self];
    /*
     NSLog(@" NEws :%@", [news_List objectAtIndex:indexPath.row]);
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NewsDetailViewController    *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
    NSDictionary* rd_Data  = [news_List objectAtIndex:indexPath.row];
    
    vc.ndDate =rd_Data[@"date"];
    vc.ndMessage=  rd_Data[@"message"];
    NSLog(@"date %@",rd_Data[@"date"]);
 
    NSLog(@"%@",[news_List objectAtIndex:indexPath.row]);
    [self.navigationController presentModalViewController:vc animated:YES   ];
    */
    //:vc animated:true completion:nil];
    /*
     if (indexPath == nil)return;
     if ([self.expandedIndexPaths containsObject:indexPath]) {
     [self.expandedIndexPaths removeObject:indexPath];
     }else {
     [self.expandedIndexPaths addObject:indexPath];
     }
     [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewsDetail"]) {
        
      //   NSIndexPath *indexPath = [self.newsList_tableview indexPathForCell:sender];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        NewsDetailViewController    *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"NewsDetailViewController"];
     //   NSDictionary* rd_Data  = [news_List objectAtIndex:indexPath.row];
        
        
        vc= [segue destinationViewController];
        
        NewsListCell * cell = sender;
        NSIndexPath * ip = [self.newsList_tableview indexPathForCell:cell];
         NSDictionary* rd_Data  = [news_List objectAtIndex:ip.row];
        vc.ndDate =rd_Data[@"date"];
        vc.ndMessage=  rd_Data[@"message"];
        NSLog(@"date %@",rd_Data[@"date"]);
        
        NSLog(@"%@",[news_List objectAtIndex:ip.row]);
        

        [self.navigationController presentModalViewController:vc animated:YES];
    }
}

@end
