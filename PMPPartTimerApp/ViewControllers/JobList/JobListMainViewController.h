//
//  JobListMainViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverView.h"

@interface JobListMainViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *btnNewJob;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIButton *btnPassJob;
- (IBAction)GotoNewJob:(id)sender;
- (IBAction)GotoSignUp:(id)sender;
- (IBAction)GotoPassJob:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSortBy;
- (IBAction)SortbyAction:(id)sender;
@property(nonatomic,assign)NSString  *sortedName;
@property (strong, nonatomic) IBOutlet UIView *sortView;
- (IBAction)GotToPrefernce:(id)sender;

@end
