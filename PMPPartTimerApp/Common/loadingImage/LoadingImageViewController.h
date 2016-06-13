//
//  LoadingImageViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 6/2/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *ani_img;

-(void)startAnimation;
-(void)stopAnimation;
- (void)showLoading:(UIView *)aView animated:(BOOL)animated;
@end
