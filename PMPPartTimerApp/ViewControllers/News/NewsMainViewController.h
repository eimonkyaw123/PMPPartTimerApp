//
//  NewsMainViewController.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/27/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "NewsListCell.h"
#import "ResponsiveLabel.h"
#import "Constant.h"
@interface NewsMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceDelegate,NewsListCellDelegate>
{
    AppDelegate *appDelegate;
}
@property (strong, nonatomic) IBOutlet UIView *v_noList;
@property (strong, nonatomic) IBOutlet UITableView *newsList_tableview;

#pragma -  service delegate
-(void)ResponseUpdateNews:(NSDictionary *)NJ;
@property(nonatomic) NSInteger  code;
@property (nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSArray * data;
@property (strong, nonatomic) IBOutlet UIView *noNewsUpadte;


@end
