//
//  ProfileMainViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "ProfileMainViewController.h"
#import "MyDetailViewController.h"
#import "BankAccountViewController.h"
#import "PasswordViewController.h"

@interface ProfileMainViewController ()<UITabBarControllerDelegate>
{
    
    UITabBarController *tabBarVC;
    MyDetailViewController  *myDetail;
    BankAccountViewController   *bankAccount;
    PasswordViewController  *passwordView;
}

@end

@implementation ProfileMainViewController
@synthesize tabBarVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // for navigation bar set up
    self.navigationController.navigationBarHidden = NO;
   // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];//04-appicon-bg.png
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
     [self setupViews];
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
   self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"pattern-scaled-bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    // self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"pattern-scaled-bg.png"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private functions.
- (void)resetButtons:(UIButton*)btn {
    self.btnBankAccount.selected = NO;
    self.btnPassword.selected = NO;
    self.btnProfileDetail.selected = NO;
    btn.selected = YES;
}


- (void)setupViews{
    
    myDetail = (MyDetailViewController*)[self getVC:@"MyDetailViewController" fromStoryboard:@"Main"];
    bankAccount = (BankAccountViewController*)[self getVC:@"BankAccountViewController" fromStoryboard:@"Main"];
    passwordView    = (PasswordViewController*)[self getVC:@"PasswordViewController" fromStoryboard:@"Main"];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:myDetail ];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:bankAccount];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:passwordView];
    nav1.navigationBar.tintColor = [UIColor whiteColor];
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden =YES;
    nav3.navigationBarHidden = YES;//YES
    
    tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.delegate = self;
    [tabBarVC.tabBar setHidden:YES];
    
    tabBarVC.view.frame = CGRectMake(0,0, self.DetailContainer.frame.size.width,self.DetailContainer.frame.size.height );//+ tabBarVC.tabBar.frame.size.height
    [self addChildViewController:tabBarVC];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects: nav1,nav2,nav3, nil ];
    
    [tabBarVC setViewControllers:viewControllers];
    [self.DetailContainer addSubview:tabBarVC.view];
    
    [self ViewMyDetailAction:self.btnProfileDetail];
}

- (UIViewController*)getVC:(NSString*)vcName fromStoryboard:(NSString*)storyboardName
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:vcName];
}


#pragma mark - Tabbar Delegate functions.

- (BOOL)tabBarController:(UITabBarController *)aTabBar
shouldSelectViewController:(UIViewController *)viewController
{
   // if(tabBarVC.selectedIndex==[[tabBarVC viewControllers] indexOfObject:viewController])
       
       if ( (viewController != [tabBarVC.viewControllers objectAtIndex:0]) )
    {
        // Disable all but the first tab.
        return NO;
    }
    /*
    if ([viewController isKindOfClass:[BankAccountViewController class]]) {
       BankAccountViewController *vc = [[BankAccountViewController alloc] init];
     //  vc.view.backgroundColor = [UIColor redColor];
        [self presentViewController:vc animated:true completion:^{[self.tabBarVC setSelectedIndex:1]; self.btnBankAccount.selected = true; self.btnPassword.selected= false; self.btnProfileDetail.selected = false;}];
        

        
        
        return NO  ;
    }
     */
       return YES;
     
   }


- (IBAction)BankAccountAction:(id)sender {
    [tabBarVC setSelectedIndex:1];
    [self resetButtons:self.btnBankAccount];
}

- (IBAction)ProfilePasswordAction:(id)sender {
    [tabBarVC setSelectedIndex:2];
    [self resetButtons:self.btnPassword];
}

- (IBAction)ViewMyDetailAction:(id)sender {
    [tabBarVC setSelectedIndex:0];
    [self resetButtons:self.btnProfileDetail];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   
    if (self.tabBarVC.selectedIndex == 0)
    {
        // First Tab is selected do something
        self.tabBarVC.selectedIndex = 1;
         [self resetButtons:self.btnPassword];
    }

}
@end
