//
//  JobListCell.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *j_image;

@property (strong, nonatomic) IBOutlet UILabel *j_title;
@property (strong, nonatomic) IBOutlet UILabel *j_date;
@property (strong, nonatomic) IBOutlet UILabel *j_place;
@property (strong, nonatomic) IBOutlet UILabel *j_price;
@property (strong, nonatomic) IBOutlet UILabel *j_unit;
@property (strong, nonatomic) IBOutlet UIImageView *j_location;
@property (strong, nonatomic) IBOutlet UIView *j_imgbackview;
@property (strong, nonatomic) IBOutlet UILabel *j_id;
@end
