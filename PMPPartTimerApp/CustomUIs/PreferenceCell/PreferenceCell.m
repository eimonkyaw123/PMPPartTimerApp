//
//  PreferenceCell.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/29/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "PreferenceCell.h"

@implementation PreferenceCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryView = self.btnCheck  ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)isPreferenceSelectedAction:(id)sender {
    if (self.btnCheck.selected) {
        self.btnCheck.selected = false ;
    }
    else
    {
        self.btnCheck.selected = true;
    }


}

@end
