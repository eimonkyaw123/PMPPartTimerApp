//
//  PreferenceVC.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/5/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "PreferenceVC.h"
#import "PreferenceDetail.h"
#import "PreferenceCell.h"
#import "JobListMainViewController.h"
#import "TabViewController.h"
#import "LoadingImageViewController.h"
#import "CustomIOSAlertView.h"
@interface PreferenceVC ()
{
    NSMutableArray *preference_List;
    Service *s;
    NSMutableDictionary *choosePreferenceList;
    NSInteger isPreference ;
    NSString *sessionID;
    NSInteger userID;
    NSString *js;
    NSInteger jobTypeId ;
    
    
   // NSMutableDictionary *j;
  //  NSMutableDictionary *weight;
   // NSMutableDictionary * preferenceArr;
    NSMutableArray *chooseItem;
    NSMutableArray* json;
    BOOL flag;
    LoadingImageViewController *li;
    CustomIOSAlertView  *c;

     }

@end

@implementation PreferenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    s = [[Service alloc]init];
    s.serviceDelegate = self;

    preference_List= [[NSMutableArray alloc]init];
    choosePreferenceList =[[NSMutableDictionary alloc]init];
    chooseItem = [[NSMutableArray alloc]init];
    
    json = [[NSMutableArray alloc]init];
    
    [self loadPreferenceList];
    [self.preferenceTable reloadData];
    self.preferenceTable.layoutMargins = UIEdgeInsetsZero;
    self.preferenceTable.separatorInset = UIEdgeInsetsZero;
    flag = false;
    li = [[LoadingImageViewController alloc]init];
    c=[[CustomIOSAlertView alloc]init];
    c.delegate = self;
    NSLog(@"%@",self.btnNext.titleLabel.text);
     NSLog(@"%@",self.btn_Title);
    if (self.btn_Title != nil) {
        if ([self.btnNext.titleLabel.text isEqualToString:@"NEXT"]) {
            [self.btnNext setTitle:@"Done" forState:UIControlStateNormal];
        }
    }
   
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [preference_List count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PreferenceCell     *cell = (PreferenceCell *)[tableView dequeueReusableCellWithIdentifier:@"pCell"];
     NSMutableArray* json = [preference_List objectAtIndex:indexPath.row];
    NSLog(@"data %@",json);
    NSLog(@"description %@",[json valueForKey:@"description"]);
    NSString * jobTypeName = [json valueForKey:@"jobTypeName"];
      jobTypeId = [[json valueForKey:@"jobTypeId"]integerValue];
     isPreference = [[json valueForKey:@"isPreference"]integerValue];
         NSString * description = [json valueForKey:@"description"];
    NSString * imagePath1 = [json valueForKey:@"imagePath"];
    
    
    NSLog(@"imagePath %@",imagePath1);
    if (![json valueForKey:@"imagePath"]) {
         cell.p_Image.image  = [UIImage imageNamed:@"ic-signup-logo@2x.png"];
    }
    else
    {
        NSString *imageURL = [json valueForKey:@"imagePath"];
        NSData *urlData= [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        
        cell.p_Image.image  = [UIImage imageWithData:urlData];
    }
   
    cell.p_Title.text =jobTypeName;
    cell.p_Description.text = description;
  // cell.p_Image.image  = [UIImage imageNamed:@"ic-job-pref-usher-color@2x.png"];//
  //  NSURL *url = [NSURL URLWithString:imagePath];
    
   // cell.p_Image.image  = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:url]];
   // cell.p_Image.frame  = CGRectMake(cell.p_Image.frame.origin.x, cell.p_Image.frame.origin.y,
                           //          cell.p_Image.image.size.width, cell.p_Image.image.size.height);
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBox setImage:[UIImage imageNamed:@"ic-common-uncheck.png"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"ic-common-checked.png"] forState:UIControlStateSelected];
    checkBox.frame = CGRectMake(0, 0, 50, 30);
    checkBox.userInteractionEnabled = YES;
   [checkBox addTarget:self action:@selector(didCheckTask:) forControlEvents:UIControlEventTouchDown];
    cell.accessoryView = checkBox;
    
    // put the index path in the button's tag
    checkBox.tag = [indexPath row];
    NSLog(@"button %d",[indexPath row]);
    if (isPreference == 1) {
        checkBox.selected = true;

        [chooseItem addObject:[json valueForKey:@"jobTypeId"]];
        NSLog(@"selected id %@",chooseItem);

    }
    else
    {
        checkBox.selected = false;
    }

    
        return cell;
    
}
-(NSString*)getJsonStringByDictionary:(NSMutableArray*)dictionary{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


- (void)didCheckTask:(UIButton *)button
{
       // toggle checkbox
    /*
    if (isPreference == 1) {
        button.selected = true;
         self.btnNext.hidden = false ;
    }
    else
    {
        button.selected = false;
         self.btnNext.hidden = false ;
    }
*/
   button.selected = !button.selected;
    PreferenceCell *cell = (PreferenceCell *)button.superview;
    NSIndexPath * indexpath = [self.preferenceTable indexPathForCell:cell];
    NSString *strCatID =[[NSString alloc]init];
    json = [preference_List objectAtIndex:indexpath.row];
    NSString *jID =[json valueForKey:@"jobTypeId"];
    if (button.selected) {
      //  NSInteger flag = 1;
        self.btnNext.hidden = false ;
        
       
        NSLog(@"description %@",[json valueForKey:@"description"]);
        NSLog(@"description %@",[json valueForKey:@"jobTypeId"]);
        [chooseItem addObject:[json valueForKey:@"jobTypeId"]];
         NSLog(@"count %@",chooseItem);
    
    }
    else
    {
        /*
        for (NSString* item in chooseItem)
        {
            if (item == jID) {
                [chooseItem removeObject:item];
            }
        }
         */
       // NSMutableArray *myArray;
     
     
        [chooseItem removeObjectAtIndex:indexpath.row];
       
        self.btnNext.hidden = false ;
    }
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Tab"]) {
       
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TabViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
        [vc setSelectedIndex:2];
        [self presentModalViewController:vc animated:YES];
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Tab"])
    {
        if (flag == false) {
            return NO;
        }
    }
    
    return YES;
    
}

- (IBAction)CallTabViewControllerAction:(id)sender {
    
    ///
    NSMutableArray *d = [[NSMutableArray alloc]init  ];
    for (int i =0; i<chooseItem.count; i++) {
        NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
        
        [postDict setValue:chooseItem[i] forKey:@"jobTypeId"];
        //  NSString *r =[NSString stringWithFormat:@"{jobTypeId:%@}",chooseItem[i]];
        [d addObject:postDict];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    
    // Checking the format
    NSString *urlString =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData =urlString;
    NSLog(@"%@",stringData);
    ///
     userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
   // NSString * baseURL = @"http://192.168.1.47:8080/api/parttimer/preferenceInfo.htm?json=";
    NSString * baseURL = @"http://ihughos.com/api/parttimer/preferenceInfo.htm?json=";
     NSInteger jobtype = 72;
       //  NSString *data1=[NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"partTimerId\":\"%d\",\"preferenceList\":[ {\"jobTypeId\":\"%d\" }]}",sessionID,userID,jobtype];
     NSString *data=[NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"partTimerId\":\"%d\",\"preferenceList\":%@}",sessionID,userID,stringData];
    // NSString *data=[NSString stringWithFormat:PerferenceJSON,sessionID,userID,stringData];
   
 [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_PREFERENCE_INFO] body:nil];
     }
-(void)loadPreferenceList
{
    userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
   sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
   // NSString * baseURL = @"http://192.168.1.47:8080/api/parttimer/preferenceList.htm?json=";
    NSString * baseURL = @"http://ihughos.com/api/parttimer/preferenceList.htm?json=";
    NSString *data=[NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",userID,sessionID];
     // NSString *data=[NSString stringWithFormat:LoadPerferenceJSON,userID,sessionID];
     [li showLoading:self.view animated:YES];

    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_PREFERENCE_LIST] body:nil];

}
#pragma service delegate
-(void)ResponsePreferenceData:(NSDictionary *)pd
{
  //  NSString *error_msg;
    [li showLoading:self.view animated:NO];
    self.sendMessage = [[CommonMessage alloc]init];
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [pd[@"responseCode"]integerValue];
    self.message = pd[@"responseMessage"];
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
               [li showLoading:self.view animated:NO];
          }];
          
          [alertView setUseMotionEffects:true];
          
          // And launch the dialog
          [alertView show];

        SignInViewController *signIn = [[SignInViewController alloc]init];
        [self.navigationController presentModalViewController:signIn animated:YES];
    }
    else if ( self.code == 1)
    {
       // [MBProgressHUD hideHUDForView:self.view animated:YES];
        flag = true;
        self.message = pd[@"responseMessage"];
        self.data = pd[@"data"];
        NSLog(@"data : %@",self.data);
        
       
            if ([self.data count]>0) {
                for (int i =0; i<self.data.count; i++) {
                    NSDictionary *jsonElement = self.data[i];
                    NSLog(@"present list : %@",jsonElement);
                    // Add this question to the locations array
                    /*
                    if ([self.data[i][@"isPreference"]integerValue] == 1) {
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                      
                        TabViewController *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
                        [tb setSelectedIndex:2];
                        [self presentModalViewController:tb animated:YES];
                        [self dismissViewControllerAnimated:YES completion:nil];
                        return;
                    }
                     */
                    [copyArr addObject:jsonElement];
                    
                }
                preference_List = copyArr;
                [self.preferenceTable reloadData];
                
                
            }

        
        
    }
    else
    {
      //  [self.sendMessage ShowMessage:self.view errorCode:[NSString stringWithFormat:@"%d",self.code] errorMessage:self.message title:@"Failure" image:[UIImage imageNamed:@"ic-common-error@2x.png"]];
        // Here we need to pass a full frame
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
             [li showLoading:self.view animated:NO];
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
   // if ([alertView tag] == 0) {
   //     [self CallTabViewControllerAction:self.btnNext];
   // }
    [li showLoading:self.view animated:NO];
    

}
@end
