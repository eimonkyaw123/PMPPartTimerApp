//
//  CommonMessage.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/31/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SuccessFailViewController.h"
@interface CommonMessage : NSObject

// for success/failure popup
@property (strong, nonatomic) SuccessFailViewController *popViewController;

-(void)ShowMessage:(UIView*)v errorCode:(NSString*)code errorMessage:(NSString*)message title:(NSString*)title image:(UIImage*)img;
@end
