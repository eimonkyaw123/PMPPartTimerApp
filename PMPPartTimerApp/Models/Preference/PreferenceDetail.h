//
//  PreferenceDetail.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/29/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PreferenceDetail : NSObject

@property(nonatomic) NSInteger jobTypeId;
@property(nonatomic,strong) NSString *jobTypeName;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSString *imagePath;
@property(nonatomic,assign) BOOL    isPreference;
-(id)initWithJobTypeID:(NSInteger )code jobTypeName:(NSString *)name description:(NSString *)continent imagePath:(NSString *)img ispreference:(NSInteger   )p;
- (NSMutableDictionary *)toNSDictionary;
@end
