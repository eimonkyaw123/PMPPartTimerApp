//
//  JobListCell.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "JobListCell.h"

@implementation JobListCell
@synthesize j_image,j_date,j_unit,j_title,j_price,j_place,j_location,j_id;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
