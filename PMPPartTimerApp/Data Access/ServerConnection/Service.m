//
//  Service.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/16/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "Service.h"

@implementation Service
NSString* kSessionId = @"";
NSString* kToken = @"";
-(NSString*)getDeviceID
{
    UIDevice *device = [UIDevice currentDevice];
    
   return  [[device identifierForVendor]UUIDString];
}
-(void)sendDataToServer:(NSString*)method JsonData:(NSString*)j_Data sendURl:(NSString*)u body:(NSString*)b
{
    NSURL *url = nil;
    NSMutableURLRequest *request = nil;
    
    // Only Difference between POST and GET is only in the way they send parameters
    
    if([method isEqualToString:@"GET"]){
        
       // NSString *getURL = [NSString stringWithFormat:@"%@?username=%@&password=%@", URL, usrname, pass ];
     //   url = [NSURL URLWithString: getURL];
       // request = [NSMutableURLRequest requestWithURL:url];
       
        
    }else{  // POST
        
      
        NSData *parameterData = [b dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
      
        NSError *error;
        NSURLResponse *response;
        NSString *combine = [ NSString stringWithFormat:@"%@%@",u,j_Data];
        NSURL * url =[NSURL URLWithString:[combine stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       
       // NSMutableURLRequest   *request = [NSMutableURLRequest requestWithURL:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
      
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
          
             NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error  ];
        if (urlData != nil) {
            NSHTTPURLResponse *res= response;
            NSLog(@"Response code :%d",res.statusCode);
            if (res.statusCode >= 200 && res.statusCode <300) {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response => %@",responseData);
                NSError * error;
                
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
                if([self.serviceDelegate respondsToSelector:@selector(ResponseSignUpData:)])
                {
                    //send the delegate function with the amount entered by the user
                    [self.serviceDelegate ResponseSignUpData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseLogInData:)])
                {
                    [self.serviceDelegate ResponseLogInData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePreferenceData:)])
                {
                    [self.serviceDelegate ResponsePreferenceData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseProfileDetail:)])
                {
                    [self.serviceDelegate ResponseProfileDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePReferenceInfo:)])
                {
                    [self.serviceDelegate ResponsePReferenceInfo:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseBankAccount:)])
                {
                    [self.serviceDelegate ResponseBankAccount:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePassword:)])
                {
                    [self.serviceDelegate ResponsePassword:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseJobDetail:)])
                {
                    [self.serviceDelegate ResponseJobDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseAcceptJob:)])
                {
                    [self.serviceDelegate ResponseAcceptJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseCancelJob:)])
                {
                    [self.serviceDelegate ResponseCancelJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseBankList:)])
                {
                    [self.serviceDelegate ResponseBankList:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseChangePassword:)])
                {
                    [self.serviceDelegate ResponseChangePassword:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseNewJob:)])
                {
                    [self.serviceDelegate ResponseNewJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseFavourit:)])
                {
                    [self.serviceDelegate ResponseFavourit:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseFavouritDetail:)])
                {
                    [self.serviceDelegate ResponseFavouritDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseSettingInfo:)])
                {
                    [self.serviceDelegate ResponseSettingInfo:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseUpdateNews:)])
                {
                    [self.serviceDelegate ResponseUpdateNews:jsonData];
                }
                else if ( [self.serviceDelegate respondsToSelector:@selector(ResponseFlashScreen:)])
                {
                    [self.serviceDelegate ResponseFlashScreen:jsonData];
                }
            }
            else
            {
                
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response => %@",responseData);
                NSError * error;
                
                NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:urlData options:0 error:&error];
                if([self.serviceDelegate respondsToSelector:@selector(ResponseSignUpData:)])
                {
                    //send the delegate function with the amount entered by the user
                    [self.serviceDelegate ResponseSignUpData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseLogInData:)])
                {
                    [self.serviceDelegate ResponseLogInData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePreferenceData:)])
                {
                    [self.serviceDelegate ResponsePreferenceData:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseProfileDetail:)])
                {
                    [self.serviceDelegate ResponseProfileDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePReferenceInfo:)])
                {
                    [self.serviceDelegate ResponsePReferenceInfo:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseBankAccount:)])
                {
                    [self.serviceDelegate ResponseBankAccount:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePassword:)])
                {
                    [self.serviceDelegate ResponsePassword:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseJobDetail:)])
                {
                    [self.serviceDelegate ResponseJobDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseAcceptJob:)])
                {
                    [self.serviceDelegate ResponseAcceptJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseCancelJob:)])
                {
                    [self.serviceDelegate ResponseCancelJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseBankList:)])
                {
                    [self.serviceDelegate ResponseBankList:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseChangePassword:)])
                {
                    [self.serviceDelegate ResponseChangePassword:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseNewJob:)])
                {
                    [self.serviceDelegate ResponseNewJob:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseFavourit:)])
                {
                    [self.serviceDelegate ResponseFavourit:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseFavouritDetail:)])
                {
                    [self.serviceDelegate ResponseFavouritDetail:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseSettingInfo:)])
                {
                    [self.serviceDelegate ResponseSettingInfo:jsonData];
                }
                else if ([self.serviceDelegate respondsToSelector:@selector(ResponseUpdateNews:)])
                {
                    [self.serviceDelegate ResponseUpdateNews:jsonData];
                }
                else if ( [self.serviceDelegate respondsToSelector:@selector(ResponseFlashScreen:)])
                {
                    [self.serviceDelegate ResponseFlashScreen:jsonData];
                }
            }
        }
        
        else {
           /*
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            
            DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:error.localizedDescription];
            
            // Add some custom content to the alert view
            
            [alertView setContainerView:alert];
            
            
            
            // Modify the parameters
            
            [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Retry", nil]];
            
            [alertView setDelegate:self];
            
            
            
            // You may use a Block, rather than a delegate.
            
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                
                [alertView close];
                
            }];
            
            
            
            [alertView setUseMotionEffects:true];
            
            
            
            // And launch the dialog
            
            [alertView show];
            */
        }

        
        
    }
    
    
}

#pragma mark NSURLConnection delegates

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response
{
    [mutableData setLength:0];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"receiving session id and token data");
    _sessiondIDandTokenResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"session id and token are %@", _sessiondIDandTokenResponse);
    
    NSLog(@"parsing session id and token");
    
    NSArray *components = [_sessiondIDandTokenResponse componentsSeparatedByString:@":"];
    kSessionId = [components objectAtIndex:0];
    kToken = [components objectAtIndex:1];
    
    NSLog(@"SessionID: %@", kSessionId);
    NSLog(@"Token: %@", kToken);
    
    //NSLog(@"token is %@", kToken);
    [mutableData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  //  serverResponse.text = NO_CONNECTION;
    if (error.code == NSURLErrorTimedOut)
        // handle error as you want
       
    {
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:@"Connection Time Out"];
        
        // Add some custom content to the alert view
        
        [alertView setContainerView:alert];
        
        
        
        // Modify the parameters
        
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Retry", nil]];
        
        [alertView setDelegate:self];
        
        
        
        // You may use a Block, rather than a delegate.
        
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            
            [alertView close];
            
        }];
        
        
        
        [alertView setUseMotionEffects:true];
        
        
        
        // And launch the dialog
        
        [alertView show];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
   // NSString *responseStringWithEncoded = [[NSString alloc] initWithData: mutableData encoding:NSUTF8StringEncoding];
   // NSLog(@"Response from Server : %@", responseStringWithEncoded);
    NSError *error;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingAllowFragments error:&error];
    if([self.serviceDelegate respondsToSelector:@selector(ResponseSignUpData:)])
    {
        //send the delegate function with the amount entered by the user
        [self.serviceDelegate ResponseSignUpData:jsonArray];
    }
    else if ([self.serviceDelegate respondsToSelector:@selector(ResponseLogInData:)])
    {
        [self.serviceDelegate ResponseLogInData:jsonArray];
    }
    else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePreferenceData:)])
    {
        [self.serviceDelegate ResponsePreferenceData:jsonArray];
    }
    else if ([self.serviceDelegate respondsToSelector:@selector(ResponseProfileDetail:)])
    {
        [self.serviceDelegate ResponseProfileDetail:jsonArray];
    }
    else if ([self.serverConnection respondsToSelector:@selector(ResponseBankAccount:)])
    {
        [self.serviceDelegate ResponseBankAccount:jsonArray];
    }
    else if ([self.serviceDelegate respondsToSelector:@selector(ResponsePassword:)])
    {
        [self.serviceDelegate ResponsePassword:jsonArray];
    }
    ///// for session id
    NSLog( @"Succeeded! Received %d bytes of data", [mutableData length] );
    
    // Convert received data into string.
   NSString* receivedString = [[NSString alloc] initWithData:mutableData
                                           encoding:NSASCIIStringEncoding];
    //receivedString will have session id if request is appropriate
    NSLog( @"From connectionDidFinishLoading: %@", receivedString );
    
    /////
    if (connection == serverConnection) {
        NSString *responseString = [[NSString alloc] initWithData:mutableData encoding:NSUTF8StringEncoding];
        
        NSLog(@"Response: %@", responseString);
       
        NSString    *prod =[jsonArray objectForKey:@"responseMessage"];
        
       
}
}
-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        if ([challenge.protectionSpace.host isEqualToString:@""])
        {
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }
        
        [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    }
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
    {
        if ([challenge previousFailureCount] == 0)
        {
            NSURLCredential *newCredential;
            
            newCredential = [NSURLCredential credentialWithUser:@""
                                                       password:@""
                                                    persistence:NSURLCredentialPersistenceForSession];
            
            [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
        }
        else
        {
            [[challenge sender] cancelAuthenticationChallenge:challenge];
            
            // inform the user that the user name and password
            // in the preferences are incorrect
            
            NSLog (@"failed authentication");
            
            // ...error will be handled by connection didFailWithError
        }
    }
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if ((int)[alertView tag] == 0) {
        [self.serverConnection start];
    }
    [alertView close];
}

@end
