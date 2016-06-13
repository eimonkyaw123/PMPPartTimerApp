//
//  ResposeCode.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/17/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "ResponseCode.h"

@implementation ResponseCode
@synthesize code,message,data;
-(id)initWithDictionary:(NSDictionary*)dic
{
    if (self = [super init])
    {
        self.code = dic[@"responseCode"];
        self.message = dic[@"responseMessage"];
        self.data = dic[@"data"];
    }
    return self;
}

@end
