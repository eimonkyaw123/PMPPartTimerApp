//
//  JobDetailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/21/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobListViewController.h"
#import "JobDetail.h"
#import <Social/Social.h>
#import<Accounts/Accounts.h>
#import "Service.h"
#import "FavouritViewController.h"
#import <MapKit/MapKit.h>
#import "DBMapSelectorManager.h"
#import "CommonMessage.h"
#import "ReportingView.h"
#import "ReportingCell.h"
#import "CustomIOSAlertView.h"
#import "DemoAlertView.h"
#import "Constant.h"
@interface JobDetailViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate,ServiceDelegate,UIScrollViewDelegate,DBMapSelectorManagerDelegate,UITableViewDelegate,UITableViewDataSource,CustomIOSAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *jd_jobimage;
@property (strong, nonatomic) IBOutlet UILabel *jd_title;
@property (strong, nonatomic) IBOutlet UILabel *jd_location;
@property (strong, nonatomic) IBOutlet UILabel *jd_date;

@property (strong, nonatomic) IBOutlet UIButton *btnApplyjob;
@property (strong, nonatomic) IBOutlet UILabel *jd_price;

@property (strong, nonatomic) IBOutlet UILabel *jd_hour;
@property (strong, nonatomic) IBOutlet UITextView *jd_requirements;
@property (strong, nonatomic) IBOutlet UITextView *jd_locationDetail;
@property (strong, nonatomic) IBOutlet UILabel *jd_reportingPerson;
@property (strong, nonatomic) IBOutlet UILabel *jd_contactNo;

@property (nonatomic, strong) NSString *jobtitle;
@property (nonatomic, strong) NSString *lcoation;
@property (nonatomic, strong) NSString *jobdate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *jd_id;
@property (nonatomic, strong) UIImage *jobimage;
@property(nonatomic)UIColor *jobColor;

@property(nonatomic)JobListViewController   *jlist;
- (IBAction)Alert:(id)sender;
@property (nonatomic, strong) JobDetail *recipe;

@property (strong, nonatomic) IBOutlet UIButton *btnFavourit;
- (IBAction)FavouritAction:(id)sender;

#pragma -  service delegate
-(void)ResponseJobDetail:(NSDictionary *)ND;
-(void)ResponseAcceptJob:(NSDictionary *)AJ;
-(void)ResponseCancelJob:(NSDictionary *)CJ;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;

@property (strong, nonatomic) IBOutlet UIView *v_reporting;
@property (strong, nonatomic) IBOutlet UIScrollView *jd_Scroll;
@property (strong, nonatomic) IBOutlet UILabel *lblNoti;

@property (strong, nonatomic) IBOutlet MKMapView *mk;

@property (strong, nonatomic) IBOutlet UITableView *reportingTbl;

@property (nonatomic, strong) DBMapSelectorManager      *mapSelectorManager;

@property (nonatomic,strong)CommonMessage *sendMessage;
@end
