//
//  DemoAlertView.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 6/3/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "DemoAlertView.h"

@implementation DemoAlertView

- (id)initWithFrame:(CGRect)frame image:(NSString *)img title:(NSString *)t message:(NSString*)m
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // initilize all your UIView components
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
        [imageView setImage:[UIImage imageNamed:img]];
        [self addSubview:imageView];
        
        UILabel *Title= [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 150, 70)];
        Title.text = t;
        [self addSubview:Title];
        
        UILabel *message = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 250, 150)];
        message.numberOfLines = 3;
        message.text =m;
        [self addSubview:message];

    }
    return self;
}
@end
