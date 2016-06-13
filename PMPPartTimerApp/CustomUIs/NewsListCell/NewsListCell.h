//
//  NewsListCell.h
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/27/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResponsiveLabel.h"
@protocol NewsListCellDelegate;
@interface NewsListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *newsDate;
@property (strong, nonatomic) IBOutlet ResponsiveLabel *newsMessage;
@property (nonatomic, weak) id<NewsListCellDelegate>delegate;

- (void)configureText:(NSString*)str forExpandedState:(BOOL)isExpanded ;
@end

@protocol NewsListCellDelegate<NSObject>

@optional
- (void)didTapOnMoreButton:(NewsListCell *)cell;
- (void)customTableViewCell:(NewsListCell *)cell didTapOnHashTag:(NSString *)hashTag;
- (void)customTableViewCell:(NewsListCell *)cell didTapOnUserHandle:(NSString *)userHandle;
- (void)customTableViewCell:(NewsListCell *)cell didTapOnURL:(NSString *)urlString;

@end