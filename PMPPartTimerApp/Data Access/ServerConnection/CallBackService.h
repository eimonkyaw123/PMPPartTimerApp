//
//  CallBackService.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/17/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Service.h"
#import "ResponseCode.h"
#import "APIServiceDelegate.h"
@interface CallBackService : NSObject
@property (nonatomic, weak) NSString *callBackMethodName;
@property (nonatomic, weak) id<APIServiceDelegate> Callback_delegate;
-(void)processJobsResponse:(NSDictionary*)items;
@end
