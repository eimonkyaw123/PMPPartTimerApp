//
//  TabViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/5/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()<UITabBarControllerDelegate>
@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self.tabBarController setSelectedIndex:2];
   // self.navigationController.navigationBar.topItem.title = @"Welcome Felicia";
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
     self.navigationController.navigationBarHidden = YES;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"pattern-scaled-bg.png"] forBarMetrics:UIBarMetricsDefault];//04-appicon-bg.png
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

   
   // self.selectedIndex   = 2;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (self.selectedIndex == 0) {
        
    } else if (self.selectedIndex == 1) {
        
    } else if (self.selectedIndex == 2) {
        
        [self setSelectedIndex:0];
        
    }
}
 */
 
@end
