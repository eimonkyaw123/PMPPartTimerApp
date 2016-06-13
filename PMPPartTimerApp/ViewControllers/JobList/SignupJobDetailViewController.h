//
//  SignupJobDetailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupJobDetailViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *t_view;
@property (strong, nonatomic) IBOutlet UIView *r_view;
@property (strong, nonatomic) IBOutlet UIView *requirement_view;


@property (strong, nonatomic) IBOutlet UIButton *btnApply;

@property(nonatomic,strong)NSString *detail_Title;
@property(nonatomic,strong)NSString *detail_Date;
@property(nonatomic,strong)UIImage *detail_Image;
@property(nonatomic,strong)NSString *detail_Location;
@property(nonatomic,strong)NSString *detail_Time;
@property(nonatomic,strong)NSString *detail_Price;

@property (strong, nonatomic) IBOutlet UILabel *jdTitle;
@property (strong, nonatomic) IBOutlet UILabel *jdLocation;
@property (strong, nonatomic) IBOutlet UILabel *jdDate;
@property (strong, nonatomic) IBOutlet UILabel *jdPrice;
@property (strong, nonatomic) IBOutlet UILabel *jdTime;
@property (strong, nonatomic) IBOutlet UIButton *btnFavourit;
- (IBAction)FavouritAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *jdImage;
@end
