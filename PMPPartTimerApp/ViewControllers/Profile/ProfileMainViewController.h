//
//  ProfileMainViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileMainViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnBankAccount;
@property (strong, nonatomic) IBOutlet UIButton *btnPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnProfileDetail;
- (IBAction)BankAccountAction:(id)sender;
- (IBAction)ProfilePasswordAction:(id)sender;
- (IBAction)ViewMyDetailAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *DetailContainer;
@property(nonatomic,strong) UITabBarController *tabBarVC;
- (void)resetButtons:(UIButton*)btn;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController ;
- (void)setupViews;
- (BOOL)tabBarController:(UITabBarController *)aTabBar
shouldSelectViewController:(UIViewController *)viewController;
@end
