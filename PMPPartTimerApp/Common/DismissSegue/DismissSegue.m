//
//  DismissSegue.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "DismissSegue.h"

@implementation DismissSegue
- (void)perform {
    UIViewController *sourceViewController = self.sourceViewController;
    [sourceViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
