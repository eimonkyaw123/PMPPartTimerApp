//
//  FavouritDetailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/24/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import <MapKit/MapKit.h>
#import "DBMapSelectorManager.h"
#import "Constant.h"
@interface FavouritDetailViewController : UIViewController<ServiceDelegate,UIScrollViewDelegate,DBMapSelectorManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *f_Title;
@property (strong, nonatomic) IBOutlet UILabel *f_location;
@property (strong, nonatomic) IBOutlet UILabel *f_date;
@property (strong, nonatomic) IBOutlet UILabel *f_price;
@property (strong, nonatomic) IBOutlet UILabel *f_Time;

@property (strong, nonatomic) IBOutlet UITextView *f_Requirement;
@property (strong, nonatomic) IBOutlet UILabel *f_place;
@property (strong, nonatomic) IBOutlet UITextView *f_PlaceDetail;
@property (strong, nonatomic) IBOutlet UIButton *btnApply;
- (IBAction)jobApplyAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *f_phoneNo;
@property (strong, nonatomic) IBOutlet UILabel *f_reportingPerson;
@property (strong, nonatomic) IBOutlet UIView *contactView;
- (IBAction)favouritAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnfavourit;
@property (strong, nonatomic) IBOutlet UIView *v_time;
@property (strong, nonatomic) IBOutlet UIView *v_requirement;
@property (strong, nonatomic) IBOutlet UIView *v_reporting;

@property (nonatomic, strong) NSString *jobtitle;
@property (nonatomic, strong) NSString *lcoation;
@property (nonatomic, strong) NSString *jobdate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) UIImage *jobimage;

@property (nonatomic, strong) NSString *jd_id;
@property(nonatomic)UIColor *jobColor;
-(void)ResponseFavouritDetail:(NSDictionary *)FD;
@property(nonatomic) NSInteger code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@property (strong, nonatomic) IBOutlet UIScrollView *lbl_scroll;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (nonatomic, strong) DBMapSelectorManager      *mapSelectorManager;
@property (strong, nonatomic) IBOutlet MKMapView *mk;
@end
