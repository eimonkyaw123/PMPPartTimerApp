//
//  JobListMainViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/20/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "JobListMainViewController.h"
#import "JobListViewController.h"
#import "JobSignUpViewController.h"
#import "PassJobViewController.h"
#import "SignupJobListViewController.h"
@interface JobListMainViewController ()<UITabBarControllerDelegate>
{
   
    UITabBarController *tabBarVC;
    JobListViewController *joblist;
      JobListViewController *joblist1;
      JobListViewController *joblist2;
    JobSignUpViewController *jobSignUp;
    PassJobViewController   *passJob;
    SignupJobListViewController  *signupjob;
    NSString *sortName;
}
@property (strong, nonatomic) IBOutlet UIView *v_sort;
@property (weak, nonatomic) IBOutlet UILabel *lblSorted;

@end

@implementation JobListMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
  
     [self setupViews];
    [self setBorderView:self.v_sort];
    self.btnSortBy.userInteractionEnabled = true;
     self.v_sort.hidden = false;
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private functions.
- (void)resetButtons:(UIButton*)btn {
    self.btnNewJob.selected = NO;
    self.btnPassJob.selected = NO;
    self.btnSignUp.selected = NO;
    btn.selected = YES;
}


- (void)setupViews{
    joblist = (JobListViewController*)[self getVC:@"JobListViewController" fromStoryboard:@"Main"];
    joblist1 = (JobListViewController*)[self getVC:@"JobListViewController" fromStoryboard:@"Main"];
    joblist2 = (JobListViewController*)[self getVC:@"JobListViewController" fromStoryboard:@"Main"];
   
    signupjob = (SignupJobListViewController*)[self getVC:@"SignupJobListViewController" fromStoryboard:@"Main"];
     passJob = (PassJobViewController*)[self getVC:@"PassJobViewController" fromStoryboard:@"Main"];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:joblist];
   UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:joblist1];
     UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:joblist2];
    // UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:signupjob];
  //  UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:passJob];
    
    nav1.navigationBarHidden = YES;
    nav2.navigationBarHidden =YES;
    nav3.navigationBarHidden = YES;//YES
    
    tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.delegate = self;
    [tabBarVC.tabBar setHidden:YES];
    
    tabBarVC.view.frame = CGRectMake(0,0, self.containerView.frame.size.width,self.containerView.frame.size.height + tabBarVC.tabBar.frame.size.height);
    [self addChildViewController:tabBarVC];
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithObjects: nav1,nav2,nav3, nil ];
    
    [tabBarVC setViewControllers:viewControllers];
    [self.containerView addSubview:tabBarVC.view];
    
    [self GotoNewJob:self.btnNewJob];
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
    if ( (viewController != [tabBarVC.viewControllers objectAtIndex:0]) )
    {
        // Disable all but the first tab.
        return NO;
    }
   
    
    return YES;
}


- (IBAction)GotoNewJob:(id)sender {
     self.v_sort.hidden = false;
  //  tabBarVC.view.frame = CGRectMake(0,0, self.containerView.frame.size.width,self.containerView.frame.size.height + tabBarVC.tabBar.frame.size.height);
    [tabBarVC setSelectedIndex:0];
    joblist.filter = @"new";
    [self resetButtons:self.btnNewJob];
   // [self performSegueWithIdentifier:@"jobList" sender:self];
}

- (IBAction)GotoSignUp:(id)sender {
     self.v_sort.hidden = false;
   //  tabBarVC.view.frame = CGRectMake(0,0, self.containerView.frame.size.width,self.containerView.frame.size.height + tabBarVC.tabBar.frame.size.height);
    [tabBarVC setSelectedIndex:1];
    joblist1.filter = @"sign_up";
    [self resetButtons:self.btnSignUp];
}

- (IBAction)GotoPassJob:(id)sender {
    [tabBarVC setSelectedIndex:2];
    self.v_sort.hidden = true;
 //  tabBarVC.view.frame = CGRectMake(0,-30, self.containerView.frame.size.width,self.containerView.frame.size.height + tabBarVC.tabBar.frame.size.height);
    joblist2.filter = @"past";
    [self resetButtons:self.btnPassJob];
}

#pragma Sort by Type function
- (IBAction)SortbyAction:(id)sender {
      UIButton *showBtn = sender;
 
    PopoverView *popoverView = [PopoverView new];
  
    popoverView.menuTitles   = @[@"Highest pay", @"Job Type", @"Favorites", @"Earliest date", @"Latest date"];
    __weak __typeof(&*self)weakSelf = self;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
    
        weakSelf.lblSorted.text = popoverView.menuTitles[index];
        
    }];
    
}
#pragma marks- border color

-(void)setBorderView:(UIView*)v
{
    //bottom border
    UIView *bottomBorder = [UIView new];
     NSInteger borderThickness = 1;
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, 30 - borderThickness, 400, borderThickness);
    [v addSubview:bottomBorder];
}
#pragma prepareforsegue function
- (IBAction)GotToPrefernce:(id)sender {
    //[self prepareForSegue:@"GoToPreference" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoToPreference"]) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PreferenceVC *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PreferenceVC"];
        vc= [segue destinationViewController];

        NSLog(@"%@",vc.btnNext.titleLabel.text);
       // if ([vc.btnNext.titleLabel.text isEqualToString:@""]) {
            vc.btn_Title = @"Done";

       // }
              // [self presentModalViewController:vc animated:YES];
    }
}



@end
