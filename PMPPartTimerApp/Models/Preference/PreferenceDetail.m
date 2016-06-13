//
//  PreferenceDetail.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/29/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "PreferenceDetail.h"

@implementation PreferenceDetail

@synthesize jobTypeId,jobTypeName,description,imagePath,isPreference;
-(id)initWithJobTypeID:(NSInteger )code jobTypeName:(NSString *)name description:(NSString *)continent imagePath:(NSString *)img ispreference:(NSInteger   )p
{
    self = [super init];
    if (self) {
        self.jobTypeId = code;
        self.jobTypeName = name;
        self.description = continent;
        self.imagePath = img;
        self.isPreference = p;
    }
    return self;
}
- (NSMutableDictionary *)toNSDictionary
{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:[NSString stringWithFormat:@"%d",jobTypeId] forKey:@"jobTypeId"];
    [dictionary setValue:jobTypeName forKey:@"jobTypeName"];
    [dictionary setValue:description forKey:@"description"];
    [dictionary setValue:imagePath forKey:@"imagePath"];
     [dictionary setValue:[NSString stringWithFormat:@"%d",isPreference] forKey:@"isPreference"];
    
    return dictionary;
}
@end
