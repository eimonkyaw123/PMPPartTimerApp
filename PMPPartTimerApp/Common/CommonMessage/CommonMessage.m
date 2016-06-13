//
//  CommonMessage.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/31/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "CommonMessage.h"
#import "SignInViewController.h"
@implementation CommonMessage
-(void)ShowMessage:(UIView*)v errorCode:(NSString*)code errorMessage:(NSString*)message title:(NSString*)title image:(UIImage*)img
{
    if ([code isEqualToString:@"1"]) {
        
        self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
        [self.popViewController showInView:v withTitle:title withImage:img withMessage:message animated:YES];
        
        // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        // [alert show];
    }
    else if([code isEqualToString:@"1002"] )
    {
        self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
         [self.popViewController showInView:v withTitle:title withImage:img withMessage:message animated:YES];
     
        // UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        // [alert show];
    }
    else  {
        self.popViewController = [[SuccessFailViewController alloc] initWithNibName:@"SuccessFailViewController" bundle:nil];
         [self.popViewController showInView:v withTitle:title withImage:img withMessage:message animated:YES];
        //  UIAlertView *alert = [[UIAlertView alloc]initWithTitle:errorMessage message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert show];
    }
       
}
@end
