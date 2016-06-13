//
//  AppDelegate.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/18/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "AppDelegate.h"
#import "DeviceTokenSend.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "TabViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        NSLog(@"iOS 8 Requesting permission for push notifications..."); // iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeAlert | UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound categories:nil];
        [UIApplication.sharedApplication registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    } else {
        NSLog(@"iOS 7 Registering device for push notifications..."); // iOS 7 and earlier
        [UIApplication.sharedApplication registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound];
    }

    
     // for facebook launch
  //  [[FBSDKApplicationDelegate sharedInstance] application:application
                            // didFinishLaunchingWithOptions:launchOptions];
    [FBLoginView class];
    [FBProfilePictureView class];
    [Fabric with:@[[Crashlytics class]]];

    // navigation bar
  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"pattern-scaled-bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];
     //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"04-appicon-bg.png"] forBarMetrics:UIBarMetricsDefault];
        
      return YES;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    /**
     * for facebook app event
     **/
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma  facebook source app
/*
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
 */

#pragma  remote notification

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    UIApplicationState state = [application applicationState];
    
    
    if (state == UIApplicationStateActive)
    {
        
        NSLog(@"received a notification while active...");
        for (id key in userInfo) {
            NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
        }
        //  NSDictionary * d = [[NSDictionary alloc]initWithObjects:[userInfo objectForKey:@"aps"] forKeys:@"alert"];
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertTitle = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"title"];
        notification.alertBody = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"body"];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        /*
         NSDictionary *apsPayload = userInfo[@"alert"];
         NSString *alertTitleString = apsPayload[@"title"];
         NSString *alertbodyString = apsPayload[@"body"];
         UIAlertView *alert = [[UIAlertView alloc]
         initWithTitle:alertTitleString
         message:alertbodyString
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];
         */
        
    }
    else if ( application.applicationState == UIApplicationStateInactive || application.applicationState == UIApplicationStateBackground  )
    {
        //opened from a push notification when the app was on background
        NSLog(@"i received a notification...");
        NSLog(@"Message: %@",[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"body"]);
        NSLog(@"whole data: %@",userInfo);
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertTitle = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"title"];
        notification.alertBody = [[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]objectForKey:@"body"];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Remote Notification userInfo is %@",userInfo);
    NSNumber *contentID = userInfo[@"content-id"];
       UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TabViewController *tb = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
  
    [tb setSelectedIndex:1];
    [self.window.rootViewController     presentModalViewController:tb animated:YES];

    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"apnsTokenSentSuccessfully"]; // set flag for request status
  // [DeviceTokenSend sendUserToken];
    
    NSLog(@"-->> TOKEN:%@",token);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    NSLog(@"Registering device for push notifications..."); // iOS 8
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)notification completionHandler:(void(^)())completionHandler
{
    NSLog(@"Received push notification: %@, identifier: %@", notification, identifier); // iOS 8 s
    completionHandler();
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // Respond to any push notification registration errors here.
    NSLog(@"Failed to get token, error: %@", error);
}

// loading indicator
-(void)showIndicator:(NSString *)withTitleString view1:(UIView *)currentView
{
    // The hud will dispable all input on the view
    actIndicator = [[MBProgressHUD alloc] initWithView:currentView];
    // Add HUD to screen
    [currentView addSubview:actIndicator];
    actIndicator.labelText = withTitleString;
    [actIndicator show:YES];
}

-(void)hideIndicator
{
    [actIndicator show:NO];
    [actIndicator removeFromSuperview];
    actIndicator = nil;
}

@end
