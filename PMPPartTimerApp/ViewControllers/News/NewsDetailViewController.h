//
//  NewsDetailViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 6/3/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *nd_Date;
@property (strong, nonatomic) IBOutlet UITextView *nd_message;

@property(nonatomic,strong)NSString * ndDate;
@property(nonatomic,strong)NSString *ndMessage;

@end
