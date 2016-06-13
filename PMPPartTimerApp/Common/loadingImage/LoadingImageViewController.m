//
//  LoadingImageViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 6/2/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "LoadingImageViewController.h"

@interface LoadingImageViewController ()

@end

@implementation LoadingImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    // Do any additional setup after loading the view from its nib.
    NSArray *imageNames = @[@"1.png", @"2.png", @"3.png", @"4.png",
                            @"5.png", @"6.png", @"7.png", @"8.png",
                            @"9.png", @"10.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    
    // Normal Animation
   
    self.ani_img.animationImages = images;
    self.ani_img.animationDuration = 1.5;
    
    [self.view addSubview:self.ani_img];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoading:(UIView *)aView animated:(BOOL)animated
{
    [aView addSubview:self.view];
   
    if (animated) {
        [self.ani_img startAnimating];
    }
    else
    {
         [self.ani_img stopAnimating];
          [self.view removeFromSuperview];
    }
}

@end
