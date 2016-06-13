//
//  ResposeCode.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/17/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseCode : NSObject
@property(nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
-(id)initWithDictionary:(NSDictionary*)dic;
@end
