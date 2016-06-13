//
//  APIServiceDelegate.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/17/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIServiceDelegate <NSObject>
-(void)processJobsResponse:(NSDictionary*)items;
@end
