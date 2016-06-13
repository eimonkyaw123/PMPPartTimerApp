//
//  NewsListCell.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/27/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "NewsListCell.h"

@implementation NewsListCell
static NSString *kExpansionToken = @"...Read More";
static NSString *kCollapseToken = @"Read Less";

- (void)awakeFromNib {
    // Initialization code
    self.newsMessage.numberOfLines = 3;
    self.newsMessage.userInteractionEnabled = YES;
    
    PatternTapResponder hashTagTapAction = ^(NSString *tappedString){
        if ([self.delegate respondsToSelector:@selector(customTableViewCell:didTapOnHashTag:)]) {
            [self.delegate customTableViewCell:self didTapOnHashTag:tappedString];
        }
    };
    PatternTapResponder action = ^(NSString *tappedString){
        //Action to be performed
    };
    [self.newsMessage enableStringDetection:@"Tap Here" withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],
                                                                         RLTapResponderAttributeName:action}];
    [self.newsMessage enableHashTagDetectionWithAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],RLHighlightedBackgroundColorAttributeName:[UIColor orangeColor],
                                                             RLTapResponderAttributeName:hashTagTapAction}];
    
    PatternTapResponder urlTapAction = ^(NSString *tappedString) {
        if ([self.delegate respondsToSelector:@selector(customTableViewCell:didTapOnURL:)]) {
            [self.delegate customTableViewCell:self didTapOnURL:tappedString];
        }
    };
    [self.newsMessage enableURLDetectionWithAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor],
                                                         NSUnderlineStyleAttributeName:[NSNumber numberWithInt:1],
                                                         RLTapResponderAttributeName:urlTapAction}];
    
    PatternTapResponder userHandleTapAction = ^(NSString *tappedString){
        if ([self.delegate respondsToSelector:@selector(customTableViewCell:didTapOnUserHandle:)]) {
            [self.delegate customTableViewCell:self didTapOnUserHandle:tappedString];
        }};
    
    [self.newsMessage enableUserHandleDetectionWithAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],
                                                                RLHighlightedForegroundColorAttributeName:[UIColor greenColor],RLHighlightedBackgroundColorAttributeName:[UIColor blackColor],
                                                                RLTapResponderAttributeName:userHandleTapAction}];
    
    NSMutableAttributedString *attribString = [[NSMutableAttributedString alloc]initWithString:kExpansionToken];
    
    PatternTapResponder tapAction = ^(NSString *tappedString) {
        if ([self.delegate respondsToSelector:@selector(didTapOnMoreButton:)]) {
            [self.delegate didTapOnMoreButton:self];
        }
    };
    
    [attribString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],
                                  NSFontAttributeName:self.newsMessage.font,
                                  RLTapResponderAttributeName:tapAction}
                          range:NSMakeRange(3, kExpansionToken.length - 3)];
    [self.newsMessage setAttributedTruncationToken:attribString];
    
    PatternTapResponder stringTapAction = ^(NSString *tappedString) {
        NSLog(@"tapped string = %@",tappedString);
    };
    [self.newsMessage enableDetectionForStrings:@[@"text",@"long"] withAttributes:@{NSForegroundColorAttributeName:[UIColor brownColor],
                                                                                    RLTapResponderAttributeName:stringTapAction}];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configureText:(NSString*)str forExpandedState:(BOOL)isExpanded {
    NSMutableAttributedString *finalString;
    if (isExpanded) {
        NSString *expandedString = [NSString stringWithFormat:@"%@%@",str,kCollapseToken];
        finalString = [[NSMutableAttributedString alloc]initWithString:expandedString attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        PatternTapResponder tap = ^(NSString *string) {
            if ([self.delegate respondsToSelector:@selector(didTapOnMoreButton:)]) {
                [self.delegate didTapOnMoreButton:self];
            }
        };
        [finalString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],RLTapResponderAttributeName:tap}
                             range:[expandedString rangeOfString:kCollapseToken]];
        [finalString addAttributes:@{NSFontAttributeName:self.newsMessage.font} range:NSMakeRange(0, finalString.length)];
        self.newsMessage.numberOfLines = 0;
        [self.newsMessage setAttributedText:finalString withTruncation:NO];
        
    }else {
        self.newsMessage.numberOfLines = 3;
        [self.newsMessage setText:str withTruncation:YES];
    }
}

/*
- (id)debugQuickLookObject
{
    // NSString *result = [NSString stringWithFormat:@"%@: %@",self.numberLabel.text,self.lineLabel.text];
    
    NSAttributedString *cr = [[NSAttributedString alloc] initWithString:@"\n"];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithAttributedString:self.newsListDateTime.attributedText];
    [result appendAttributedString:cr];
    [result appendAttributedString:self.newsDetail.attributedText];
    return result;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView layoutIfNeeded];
    self.newsDetail.preferredMaxLayoutWidth = CGRectGetWidth(self.newsDetail.frame);
}
 */

@end
