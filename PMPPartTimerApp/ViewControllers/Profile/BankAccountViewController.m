//
//  BankAccountViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "BankAccountViewController.h"

#import <QuartzCore/QuartzCore.h>
#import "CommonMessage.h"
#import "LoadingImageViewController.h"
@interface BankAccountViewController ()
{
    BOOL flag;
    NSMutableArray *arryData;
    Service *s;
    NSInteger userID;
    NSString *sessionID;
    UILabel *bankID;
    LoadingImageViewController *li;
}

@end

@implementation BankAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtAccountNo.delegate = self;
    self.txtAccountNo.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
   
    //button cornor
    self.btnAccountUpdate.layer.cornerRadius = 20;
    self.btnAccountUpdate.clipsToBounds = YES;
    
    
    // dropdown
    self.dropDownTableview.layer.borderWidth = 1;
    self.dropDownTableview.layer.borderColor = [UIColor grayColor].CGColor;
     //self.dropDownTableview.frame = CGRectMake(27, 150, 260, 129);
    arryData = [[NSMutableArray alloc]init];
   // arryData = [[NSMutableArray alloc] initWithObjects:@"POSB Saving", @"DBS ", @"OCBC Bank ", @"UOB ",nil];
    flag=1;
    self.dropDownTableview.hidden=YES;
    self.dropDownTableview.layer.cornerRadius=8;
    
    s= [[Service alloc]init];
    s.serviceDelegate = self;
     li = [[LoadingImageViewController alloc]init];
    // [li showLoading:self.view animated:YES];
    userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];

   
    bankID = [[UILabel alloc]init];
    
    
       self.sendMessage = [[CommonMessage alloc]init ];
   // [self getFilledBankData];
    

   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - add sub view
-(void)viewDidLayoutSubviews
{
    // bottom line
    [self setTextFieldbottomColor:self.txtAccountNo];
    [self setButtonBorder:self.btnBankType];
     self.dropDownTableview.frame = CGRectMake(13, 152, 300, 129);//336
    /*
    CALayer *border = [CALayer layer];
    border.backgroundColor = [UIColor blackColor].CGColor;
    
    border.frame = CGRectMake(0, self.btnBankType.frame.size.height - 1, self.btnBankType.frame.size.width, 1);
    [self.btnBankType.layer addSublayer:border];
     */
      // self.dropDownTableview.frame = CGRectMake(14, 77, 307, 172);
}




- (IBAction)BankTypeAction:(id)sender {
   // NSString *bankURL = @"http://192.168.1.47:8080/api/parttimer/getBankList.htm?json=";
     NSString *bankURL = @"http://ihughos.com/api/parttimer/getBankList.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"sessionId\":\"%@\"}",sessionID];
   // NSString *data = [NSString stringWithFormat:BankListJSON,sessionID];
    // [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_BANK_LIST] body:nil];
    

    if (flag==1) {
        flag=0;
        self.dropDownTableview.hidden=NO;
      
    }
    else{
        flag=1;
        self.dropDownTableview.hidden=YES;
       
    }
 

    
 }

- (IBAction)BankAccountAction:(id)sender {
    /*
     http://localhost:9090/api/parttimer/profileBankInfo.htm?json={"partTimerId":4,"bankName":"UOB","accNumber":"0100123071331"}
     */
  //  NSString *bankURL = @"http://192.168.1.47:8080/api/parttimer/profileBankInfo.htm?json=";
      NSString *bankURL = @"http://ihughos.com/api/parttimer/profileBankInfo.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"bankId\":\"%d\",\"accNumber\":\"%@\",\"sessionId\":\"%@\"}",userID,[bankID.text integerValue],self.txtAccountNo.text,sessionID];
   //  NSString *data = [NSString stringWithFormat:BankJSON,userID,[bankID.text integerValue],self.txtAccountNo.text,sessionID];
   
 [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_PROFILE_BANK_INFO] body:nil];

}

#pragma textfield custom control
-(void)setTextFieldbottomColor:(UITextField*)textfield
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height - borderWidth, textfield.frame.size.width, textfield.frame.size.height);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;
    
}

-(void)setButtonBorder:(UIButton*)b
{
    CALayer *border = [CALayer layer];
    border.backgroundColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    
    border.frame = CGRectMake(0, b.frame.size.height - 1, b.frame.size.width, 1);
    [b.layer addSublayer:border];
}
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

#pragma dropdown delegate
- (void)viewDidUnload {
    
    self.btnBankType=nil;
    self.dropDownTableview  =nil;
   
    arryData=nil;
     [super viewDidUnload];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arryData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }

    // Set up the cell...
    cell.textLabel.font=[UIFont fontWithName:@"Arial" size:16];
    cell.textLabel.textColor = [UIColor blackColor]; //[UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1];
    
    cell.textLabel.text = [[arryData objectAtIndex:indexPath.row]objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bankID.text =[[arryData objectAtIndex:indexPath.row]objectForKey:@"id"];
    NSLog(@"bnak id %@",bankID.text);
    [self.btnBankType setTitle:[[arryData objectAtIndex:indexPath.row]objectForKey:@"name"] forState:UIControlStateNormal];
   
    if (flag==1) {
        flag=0;
        self.dropDownTableview.hidden=NO;
        self.dropDownTableview.frame = CGRectMake(14, 67, 307, 82);
        
    }
    else{
        flag=1;
        self.dropDownTableview.hidden=YES;
        
    }

}

#pragma service delegate
-(void)ResponseBankAccount:(NSDictionary *)BA
{
     [li showLoading:self.view animated:NO];
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [BA[@"responseCode"]integerValue];
    self.message = BA[@"responseMessage"];
    if (self.code == 1) {
        self.message = BA[@"responseMessage"];
        if ([BA[@"data"] count]>0) {
            self.data = BA[@"data"];
            NSLog(@"message %@",BA[@"responseMessage"]);
            NSLog(@"data %@",BA[@"data"]);
         //   NSString *fs =BA[@"data"][@"firstName"];
           // if ([fs isEqualToString:@""]) {
                for (int i =0; i<self.data.count; i++) {
                    NSDictionary *jsonElement = self.data[i];
                    
                    // Add this question to the locations array
                    [copyArr addObject:jsonElement];
                    
                }
                arryData = copyArr;
                [self.dropDownTableview reloadData];
           // }
          //  else
           // {
            /*
                NSIndexPath* selectedCellIndexPath= [NSIndexPath indexPathForRow:(int)BA[@"data"][@"bankId"] inSection:0];
                [self.dropDownTableview selectRowAtIndexPath:selectedCellIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                self.txtAccountNo.text = BA[@"data"][@"accNumber"];
               UITableViewCell * c = [self.dropDownTableview cellForRowAtIndexPath:selectedCellIndexPath];//tableView.cellForRowAtIndexPath(indexPath)
                self.btnBankType.titleLabel.text = c.textLabel.text;
             */
          //  }
           
        }
      
    }
    else if (self.code == 1000)
    {
            NSMutableArray *copyArr = [[NSMutableArray alloc]init];
            self.data =  BA[@"data"];
            NSLog(@"data %@",BA[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            
            
            NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
            NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
            
        
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
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if ([alertView tag]==0) {
        [self getFilledBankData];
    }
    [alertView close];
}
-(void)getFilledBankData
{
  //  NSString *bankURL = @"http://192.168.1.47:8080/api/parttimer/getPartTimerInfo.htm?json=";
      NSString *bankURL = @"http://ihughos.com/api/parttimer/getPartTimerInfo.htm?json=";
    NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",userID,sessionID];
     // NSString *data = [NSString stringWithFormat:GetBankDataJSON,userID,sessionID];
    
    [li showLoading:self.view animated:YES];
    [s sendDataToServer:POST_METHOD JsonData:data sendURl:bankURL body:nil];
}
@end
