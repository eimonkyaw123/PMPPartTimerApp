//
//  SignupJobDetailViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/22/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "SignupJobDetailViewController.h"
#import <EventKit/EventKit.h>

@interface SignupJobDetailViewController ()

   

// Event related stuff
@property (strong, nonatomic) NSDate *eventStartDate;
@property (strong, nonatomic, readonly) NSDate *eventEndDate;
@property (copy, nonatomic) NSString *eventTitle;

// UI stuff
@property (strong, nonatomic) UIAlertView *alertView;
@end

@implementation SignupJobDetailViewController
@synthesize detail_Date,detail_Image,detail_Location,detail_Price,detail_Time,detail_Title;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.btnApply.layer.cornerRadius = 18;
    self.btnApply.clipsToBounds = YES;
    [self setBorderView:self.t_view];
    [self setBorderView:self.requirement_view];
    [self setBorderView:self.r_view];
    
    //insert data
    self.jdDate.text = detail_Date;
    self.jdLocation.text = detail_Location;
    self.jdPrice.text = detail_Price;
    self.jdTime.text = detail_Time;
    self.jdTitle.text = detail_Title;
    self.jdImage.image  = detail_Image;
    NSLog(@"Price %@", detail_Price);

    self.btnFavourit.selected = false;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)AddEvent:(id)sender {
  
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning! " message:@"Please insert Profile Data" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
    if ([sender isSelected] == YES)
    {
        [sender setSelected:NO];
        if ([self.btnApply.titleLabel.text isEqualToString:@"Apply for Job"]) {
             [self.btnApply setBackgroundImage:[UIImage imageNamed:@"grey-btn.png"] forState:UIControlStateNormal];
                   }
        else if ([self.btnApply.titleLabel.text isEqualToString:@"Cancel"]){
           
            [self.btnApply setBackgroundImage:[UIImage imageNamed:@"04-appicon-bg.png"] forState:UIControlStateNormal];

        }
        
    }
    else
    {
        [sender setSelected:YES];
        if ([self.btnApply.titleLabel.text isEqualToString:@"Apply for Job"]) {
            [self.btnApply setBackgroundImage:[UIImage imageNamed:@"grey-btn.png"] forState:UIControlStateNormal];
        }
        else if ([self.btnApply.titleLabel.text isEqualToString:@"Cancel"]){
            
            [self.btnApply setBackgroundImage:[UIImage imageNamed:@"04-appicon-bg.png"] forState:UIControlStateNormal];
            
        }

    }
    
    
     if ([self.btnApply.titleLabel.text isEqualToString:@"Apply for Job"]) {
         
     self.eventTitle = @"Apply job event!";
     
     EKEventStore *eventStore = [[EKEventStore alloc] init];
     
     
     
     if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
     
     {
     
     [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
     
     // We need to run the main thread to issue alerts
     
     dispatch_async(dispatch_get_main_queue(), ^{
     
     if (error)
     
     {
     
     self.alertView.message = @"Could not access the calendar because an error ocurred.";
     
     [self.alertView show];
     
     }
     
     else if (!granted)
     
     {
     
     self.alertView.message = @"Could not access the calendar because permission was not granted.";
     
     [self.alertView show];
     
     }
     
     else
     
     {
     
     self.eventStartDate = [NSDate date];
     
     NSLog(@"%@",self.eventStartDate);
     
     
     
     EKEvent *event = [EKEvent eventWithEventStore:eventStore];
     
     event.title = self.eventTitle;
     
     event.startDate = self.eventStartDate;
     
     event.endDate = self.eventEndDate;
     
     
     
     NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:event.startDate endDate:event.endDate calendars:nil];
     
     NSArray *eventsOnDate = [eventStore eventsMatchingPredicate:predicate];
     
     
     
     NSUInteger eventIndex = [eventsOnDate indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
     
     EKEvent *eventToCheck = (EKEvent*)obj;
     
     return [self.eventTitle isEqualToString:eventToCheck.title];
     
     }];
     
     
     
     if(eventIndex != NSNotFound)
     
     {
     
     [event setCalendar:[eventStore defaultCalendarForNewEvents]];
     
     
     
     NSError *saveEventError;
     
     [eventStore saveEvent:event span:EKSpanThisEvent error: &saveEventError];
     
         EKAlarm *r =[EKAlarm alarmWithRelativeOffset:-2*60*60];
         [event addAlarm:r];
        
     if(saveEventError)
     
     {
     
     self.alertView.message = @"Could not add event to the calendar because an error ocurred.";
     
     [self.alertView show];
     
     }
     
     else
     
     {
     
     
     
     self.alertView.message = @"The event was added to the calendar.";
     
     [self.alertView show];
     
     }
     
     }
     
     else
     
     {
     
     self.alertView.message = @"Could not add event to the calendar because it already existed.";
     
     [self.alertView show];
         
         // when order is confirmed , set local Notification
         UILocalNotification *localNotification = [[UILocalNotification alloc] init];
         
         // Set the fire date/time
         [localNotification setFireDate:self.eventStartDate];
         [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
         
         localNotification.applicationIconBadgeNumber=1;
         
         // Setup alert notification
         [localNotification setAlertAction:@"Open App"];
         [localNotification setAlertBody:self.eventTitle];
         [localNotification setAlertBody:@"You had set a Local Notification on this time"];
         
         localNotification.soundName=UILocalNotificationDefaultSoundName;
         [localNotification setHasAction:YES];
         UIApplication *app=[UIApplication sharedApplication];
         [app scheduleLocalNotification:localNotification];
     
     }
     
     }
     
     });
     
     }];
     
     }
     
     else
     
     {
     
     self.alertView.message = @"Could not add event to the calendar because the feature is not supported.";
     
     [self.alertView show];
     
     }
     
     
     
     }
     
     else if ([self.btnApply.titleLabel.text isEqualToString:@"Cancel"])
     
     {
     
         self.eventTitle = @"Remove job event!";

     EKEventStore *eventStore = [[EKEventStore alloc] init];
     
     if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
     
     {
     
     [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
     
     dispatch_async(dispatch_get_main_queue(), ^{
     
     if (error)
     
     {
     
     self.alertView.message = @"Could not access the calendar because an error ocurred.";
     
     [self.alertView show];
     
     }
     
     else if (!granted)
     
     {
     
     self.alertView.message = @"Could not access the calendar because permission was not granted.";
     
     [self.alertView show];
     
     }
     
     else
     
     {
     
     NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:self.eventStartDate endDate:self.eventEndDate calendars:nil];
     
     NSArray *eventsOnDate = [eventStore eventsMatchingPredicate:predicate];
     
     
     
     NSUInteger eventIndex = [eventsOnDate indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
     
     EKEvent *eventToCheck = (EKEvent*)obj;
     
     return [self.eventTitle isEqualToString:eventToCheck.title];
     
     }];
     
     
     
     if(eventIndex != NSNotFound)
     
     {
     
     NSError *removeEventError;
     
     EKEvent *eventToRemove = eventsOnDate[eventIndex];
     
     [eventStore removeEvent:eventToRemove span:EKSpanFutureEvents error:&removeEventError];
     
     
     
     if(removeEventError)
     
     {
     
     self.alertView.message = @"Could not remove event from the calendar because an error ocurred.";
     
     [self.alertView show];
     
     }
     
     else
     
     {
     
     self.alertView.message = @"The event was removed from the calendar";
     
     [self.alertView show];
     
     }
     
     }
     
     else
     
     {
     
     self.alertView.message = @"Could not remove event from the calendar because it was not found.";
     
     [self.alertView show];
     
     }
     
     }
     
     });
     
     }];
     
     }
     
     else
     
     {
     
     self.alertView.message = @"Could not remove event from the calendar because the feature is not supported.";
     
     [self.alertView show];
     
     
     
     }
     
     
    
}
    


}



#pragma mark - Properties

- (NSDate*)eventEndDate
{
    return [NSDate dateWithTimeInterval:60*60 sinceDate:self.eventStartDate]; // ends in one hour
}

#pragma border function
-(void)setBorderView:(UIView*)v
{
    //top border
    UIView *topBorder = [UIView new];     topBorder.backgroundColor = [UIColor lightGrayColor];
    NSInteger borderThickness = 1;
    topBorder.frame = CGRectMake(0, 0, 400, borderThickness);
    [v addSubview:topBorder];
    
    //bottom border
    UIView *bottomBorder = [UIView new];
    bottomBorder.backgroundColor = [UIColor lightGrayColor];
    bottomBorder.frame = CGRectMake(0, 24 - borderThickness, 400, borderThickness);
    [v addSubview:bottomBorder];
}

-(IBAction)buttonClick:(UIBarButtonItem *)sender {
    
    if ([sender.image isEqual:[UIImage imageNamed:@"ic-common-fav.png"]]) {
        sender.image =[UIImage imageNamed:@"ic-common-fav-active@2x.png"];
    }
    else
    {
        sender.image =[UIImage imageNamed:@"ic-common-fav.png"];
    }
}
- (IBAction)FavouritAction:(id)sender {
    
    if (self.btnFavourit.selected) {
        self.btnFavourit.selected = false;
    }
    else
    {
         self.btnFavourit.selected = true;
    }
}
@end
