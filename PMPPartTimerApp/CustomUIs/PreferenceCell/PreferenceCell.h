//
//  PreferenceCell.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/29/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreferenceVC.h"

@interface PreferenceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *p_Image;
@property (strong, nonatomic) IBOutlet UILabel *p_Title;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property (strong, nonatomic) IBOutlet UILabel *p_Description;
- (IBAction)isPreferenceSelectedAction:(id)sender;
@property(nonatomic,strong)PreferenceVC *pvc;
@end
