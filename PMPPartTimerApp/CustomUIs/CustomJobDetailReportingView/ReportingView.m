//
//  ReportingView.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/31/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "ReportingView.h"

@implementation ReportingView

- (id)initWithFrame:(CGRect)frame  Reporter:(NSString*)name PhNo:(NSString*)ph
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8, 18,18)];
        
        [imageView1 setImage:[UIImage imageNamed:@"ic-job-details-person.png"]];//
        [self addSubview:imageView1];
        
        
        UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(41, 6, 254,16)];
        label1.text = @"Reporting Person";
        label1.textColor = [UIColor blackColor];
        [self addSubview:label1];
        
        
        UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(41, 22, 182,16)];
        label2.text = name;
        label2.textColor = [UIColor blackColor];
        [self addSubview:label2];
        
        
        UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(209, 8, 18,18)];
        
        [imageView2 setImage:[UIImage imageNamed:@"ic-job-details-contact.png"]];//ic-job-details-contact.png
        [self addSubview:imageView2];
        
        
        UILabel * label3 = [[UILabel alloc] initWithFrame:CGRectMake(235, 6, 157,17)];
        label3.text = @"Contact";
        label3.textColor = [UIColor blackColor];
        [self addSubview:label3];
        
        
        UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(236, 22, 156,17)];
        label4.text = ph;
        label4.textColor = [UIColor blackColor];
        [self addSubview:label4];
    }
    return self;
}
@end
