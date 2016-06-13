//
//  JobDetail.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface JobDetail : NSObject
@property (nonatomic, strong) NSString *jobtitle;
@property (nonatomic, strong) NSString *lcoation;
@property (nonatomic, strong) NSString *jobdate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *hour;
@property (nonatomic, strong) NSString *jobimage;
@property(nonatomic)UIColor *jobColor;
@end
