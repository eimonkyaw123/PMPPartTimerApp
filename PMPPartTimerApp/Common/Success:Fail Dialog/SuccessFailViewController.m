//
//  SuccessFailViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/31/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SuccessFailViewController.h"

@interface SuccessFailViewController ()

@end

@implementation SuccessFailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.sf_view.layer.cornerRadius = 5;
    self.sf_view.layer.shadowOpacity = 0.8;
    self.sf_view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - show and remove function
- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (IBAction)CloseAction:(id)sender {
     [self removeAnimate];
}

#pragma mark - send data function
- (void)showInView:(UIView *)aView withTitle:(NSString*)title withImage:(UIImage *)image withMessage:(NSString *)message animated:(BOOL)animated
{
    [aView addSubview:self.view];
    self.sf_img.image = image;
    self.sf_Title.text = title;
    self.sf_message.text = message;
    if (animated) {
        [self showAnimate];
    }
}
@end
