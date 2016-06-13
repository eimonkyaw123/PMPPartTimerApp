//
//  SuccessFailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/31/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessFailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *sf_view;
@property (strong, nonatomic) IBOutlet UIImageView *sf_img;
@property (strong, nonatomic) IBOutlet UILabel *sf_Title;
@property (strong, nonatomic) IBOutlet UITextView *sf_message;
- (IBAction)CloseAction:(id)sender;
- (void)showInView:(UIView *)aView withTitle:(NSString*)title withImage:(UIImage *)image withMessage:(NSString *)message animated:(BOOL)animated;
@end
