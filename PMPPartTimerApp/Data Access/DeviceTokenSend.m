//
//  DeviceTokenSend.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "DeviceTokenSend.h"

@implementation DeviceTokenSend
+(void)sendUserToken
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"apnsTokenSentSuccessfully"]) {
        NSLog(@"apnsTokenSentSuccessfully already");
        return;
    }
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://myhost.com/filecreate.php?token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"apnsToken"]]]; //set here your URL
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error == nil) {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"apnsTokenSentSuccessfully"];
             NSLog(@"Token is being sent successfully");
             //you can check server response here if you need
         }
     }];
}
@end
