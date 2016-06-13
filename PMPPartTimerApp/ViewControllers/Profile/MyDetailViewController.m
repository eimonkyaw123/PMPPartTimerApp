//
//  MyDetailViewController.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 4/26/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "MyDetailViewController.h"
#import "TabViewController.h"
#import "JobListMainViewController.h"
#import <AFNetworking/AFURLSessionManager.h>
#import "SignInViewController.h"
#import "SuccessFailViewController.h"
#import "CommonMessage.h"
#import "LoadingImageViewController.h"
#define USE_CONTENT_MODE 0 // toggle using content mode scale fit. If you don't use this, the explicit height constraint of the image view will be set each time the image changes.
@interface MyDetailViewController ()<UITabBarDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popOver;
    NSInteger imagePick;
    TabViewController *t;
    BOOL isStudent;
    LoadingImageViewController *li;
    NSInteger userID ;
    NSString *sessionID;
}
@property (strong, nonatomic) IBOutlet UIView *bottom_view;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *FrontImageConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *BackImageConstraint;
@property (nonatomic, strong) PMCalendarController *pmCC;
- (IBAction)ExpiredDateTimeSchoolAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnExpired;
@property (strong, nonatomic) SuccessFailViewController *popViewController;

@end

@implementation MyDetailViewController
@synthesize txtDTFirstName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // scroll view
    //[self.mydetailScrollview layoutIfNeeded];
    //self.mydetailScrollview.contentSize = self.view.frame.size;
    
    // textview
    self.txtDTTitle.editable = false;
    
    //button cornor
    self.btnUpdate.layer.cornerRadius = 18;
    self.btnUpdate.clipsToBounds = YES;
    
    //imageview cornor
    self.frontImg.layer.cornerRadius = 5;
    self.frontImg.clipsToBounds  = YES;
    self.backImg.layer.cornerRadius = 5;
    self.backImg.clipsToBounds  = YES;
    
    //textfield delegate
    self.txtDTFirstName.delegate =self;
    self.txtDTLastName.delegate = self;
    self.txtDTEmail.delegate =self;
    self.txtDTNRIC.delegate = self;
    self.txtDTGender.delegate =self;
    self.txtDTDOB.delegate =self;
    self.txtDTMobile.delegate = self;
    self.txtSchoolName.delegate = self;
    self.txtExpiryOfStudentCard.delegate= self;

    self.txtDTEmail.keyboardType = UIKeyboardTypeEmailAddress;
    self.txtDTMobile.keyboardType = UIKeyboardTypePhonePad;
    
    // view hide
   
    self.txtSchoolName.hidden = true;
    self.txtExpiryOfStudentCard.hidden = true;
    self.lblExpiry.hidden = true;
    self.lblSchoolName.hidden = true;
    self.btnExpired.hidden = true;
    
    
    
    imagePick  = 0;
     //self.bottom_view.frame = CGRectMake(0, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
    t= [[TabViewController alloc]init];
    
    // service delegate
    s=[[Service alloc]init];
    s.serviceDelegate = self;
    isStudent = false;
    
    self.sendMessage = [[CommonMessage alloc]init];
      li = [[LoadingImageViewController alloc]init];
    userID = [[[NSUserDefaults standardUserDefaults] valueForKey:@"parttimerId"]integerValue];
    sessionID = [[NSUserDefaults standardUserDefaults] valueForKey:@"sessionId"];
    [self getProfileData];

       }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - add sub view
-(void)viewDidLayoutSubviews
{
    [self setTextFieldbottomColor:self.txtDTFirstName];
    [self setTextFieldbottomColor:self.txtDTLastName];
    [self setTextFieldbottomColor:self.txtDTEmail];
    [self setTextFieldbottomColor:self.txtDTNRIC];
    //[self setTextFieldbottomColor:self.txtDTGender];
    [self setTextFieldbottomColor:self.txtDTDOB];
    [self setTextFieldbottomColor:self.txtDTMobile];
    [self setTextFieldbottomColor:self.txtExpiryOfStudentCard];
    [self setTextFieldbottomColor:self.txtSchoolName];
    [self setLabelbottomColor:self.lblGender];
    [self setLabelbottomColor:self.lbluniformSize];
  //  [self setButtonBorder:self.btnGender];
     // self.btnUpdate.frame = CGRectMake(13, 533, self.btnUpdate.frame.size.width, self.btnUpdate.frame.size.height);
}

- (IBAction)UpdateProfileAction:(id)sender {
    
    NSString *gender;
    NSString *flag = @"0";
    if ([self.lblGender.text isEqualToString:@"Male"]) {
        gender = @"M";
    }
    else if ([self.lblGender.text isEqualToString:@"Female"])
    {
        gender = @"F";
    }
    if (isStudent) {
        flag = @"1";
    }
    else
    {
        flag = @"0";
    }
    
   
 
// [self tabBarController:t didSelectViewController:self];
    
    NSError *error;
    
    NSData *imageData = UIImageJPEGRepresentation(self.frontImg.image, 1.0);
    NSData *imageData1 = UIImageJPEGRepresentation(self.backImg.image, 1.0);
    NSString *encodedString = [[self base64forData:imageData] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    _str = [self base64forData:imageData] ;
    NSString *encodedString1 = [[self base64forData:imageData1] stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    _str1 = [self base64forData:imageData1] ;
       NSURL *sendURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",API_DOMAIN_PATH,API_URL_PROFILE_INFO]];

    NSMutableDictionary *sendAsJSON = [[NSMutableDictionary alloc]
                                       init];
    
    /* Set a message as the object */
    [sendAsJSON setObject:[NSString stringWithFormat:@"%d",userID] forKey:@"id"];
     [sendAsJSON setObject:self.txtDTFirstName.text forKey:@"firstName"];
     [sendAsJSON setObject:self.txtDTLastName.text forKey:@"lastName"];
     [sendAsJSON setObject:self.txtDTEmail.text forKey:@"email"];
     [sendAsJSON setObject:self.txtDTNRIC.text forKey:@"nric"];
     [sendAsJSON setObject:gender forKey:@"gender"];
     [sendAsJSON setObject:self.txtDTDOB.text forKey:@"dob"];
     [sendAsJSON setObject:self.txtDTMobile.text forKey:@"phoneNo"];
      [sendAsJSON setObject:self.lbluniformSize forKey:@"uniformSize"];
    [sendAsJSON setObject:flag forKey:@"isStudent"];
    [sendAsJSON setObject:self.txtSchoolName.text forKey:@"schoolName"];
    [sendAsJSON setObject:self.txtExpiryOfStudentCard.text forKey:@"studentCardExpire"];
     [sendAsJSON setObject:sessionID forKey:@"sessionId"];
   
     [sendAsJSON setObject:encodedString forKey:@"imageFrontView"];
     [sendAsJSON setObject:encodedString1 forKey:@"imageBackView"];
    
    NSData *message = [NSJSONSerialization dataWithJSONObject: sendAsJSON
                                                      options:0
                                                        error:nil];
   
  // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:sendURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
 NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:sendURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
  
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPBody:message];
    
    // print json:
    NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:message
                                                     encoding:NSUTF8StringEncoding]);
    serverConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        dispatch_async(dispatch_get_main_queue(), ^{
            [li showLoading:self.view animated:YES];
        });
    });

    [serverConnection start];
   // [MBProgressHUD showHUDAddedTo:self.view animated:YES];

     NSURLResponse *response;
    NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error  ];
    if (urlData != nil) {
        NSHTTPURLResponse *res= response;
        NSLog(@"Response code :%d",res.statusCode);
         [li showLoading:self.view animated:NO];
    }

    }
- (NSString*)base64forData:(NSData*) theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

#pragma service delegate
-(void)ResponseProfileDetail:(NSDictionary *)DetailData
{
   // [MBProgressHUD hideHUDForView:self.view animated:YES];
 [li showLoading:self.view animated:NO];
    NSString *error_msg;
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    self.code = [DetailData[@"responseCode"]integerValue];
    
    NSLog(@"sign in response code %d",self.code);
    NSLog(@"sign in response message %@",DetailData[@"responseMessage"]);
    NSLog(@"sign in response data %@",DetailData[@"data"]);
    if (self.code == 1) {
        self.message = DetailData[@"responseMessage"];
         NSLog(@"sign in response message %@",DetailData[@"responseMessage"]);
        if ([DetailData[@"data"]count ]>0) {
            self.txtDTFirstName.text =DetailData[@"data"][@"firstName"];
            self.txtDTLastName.text = DetailData[@"data"][@"lastName"];
            self.txtDTEmail.text =  DetailData[@"data"][@"email"];
            
            self.txtDTNRIC.text = DetailData[@"data"][@"nric"];
            NSString *g = DetailData[@"data"][@"gender"];
            if ([g isEqualToString:@"F"]) {
                self.txtDTGender.text = @"Female";
            }
            else
            {
                self.txtDTGender.text = @"Male";
            }
            self.txtDTDOB.text = DetailData[@"data"][@"dob"];
            self.txtDTMobile.text= DetailData[@"data"][@"phoneNo"];
            self.txtSchoolName.text=DetailData[@"data"][@"schoolName"];
            self.btnExpired.titleLabel.text= DetailData[@"data"][@"studentCardExpire"];
            NSString *st= [NSString stringWithFormat:@"$ %@",DetailData[@"data"][@"isStudent"]];
            
             //self.lbluniformSize.text=DetailData[@"data"][@"uniformsize"];
            if ([st isEqualToString:@"1"]) {
                self.btnStudent.selected = true;
            }
            else
            {
                self.btnStudent.selected = false;
            }
            NSString *imageURL = DetailData[@"data"][@"imageFrontView"];
            if ([imageURL isEqualToString:@""]) {
                self.frontImg.image = [UIImage imageNamed:@"ic-signup-logo@2x.png"];;
            }
            else
            {
                NSData *urlData= [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                
                self.frontImg.image =[UIImage imageWithData:urlData];
            }
            
            
            NSString *imageURL1 = DetailData[@"data"][@"imageFrontView"];
            if ([imageURL isEqualToString:@""]) {
                self.backImg.image = [UIImage imageNamed:@"ic-signup-logo@2x.png"];;
            }
            else
            {
                NSData *urlData1= [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                self.backImg.image =[UIImage imageWithData:urlData1];

            }

                   }
        else
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            TabViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
            [self tabBarController:vc didSelectViewController:self];
            [self.navigationController presentModalViewController:vc animated:YES];
        }

    }
    else if (self.code == 1002)
    {
          self.message = DetailData[@"responseMessage"];
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
        // Add some custom content to the alert view
        [alertView setContainerView:alert];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        SignInViewController *signIn = [[SignInViewController alloc]init];
        [self.navigationController presentModalViewController:signIn animated:YES];
    }
    else if (self.code == 1000)
    {
        NSMutableArray *copyArr = [[NSMutableArray alloc]init];
            self.data =  DetailData[@"data"];
            NSLog(@"data %@",DetailData[@"data"]);
            for (int i =0; i<self.data.count; i++) {
                NSDictionary *jsonElement = self.data[i];
                
                // Add this question to the locations array
                [copyArr addObject:jsonElement];
                
            }
            
            
            NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
            NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
            
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:errorMessage];
        // Add some custom content to the alert view
        [alertView setContainerView:alert];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];


    }
}
- (void)tabBarController:(TabViewController *)tabBarController didSelectViewController:(UIViewController *)viewController {
   
        [tabBarController setSelectedIndex:0];
        
   
}

#pragma Image Encoding & Decoding
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [UIImage imageWithData:data];
}
                      
                      
#pragma textfield custom control
-(void)setTextFieldbottomColor:(UITextField*)textfield
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, textfield.frame.size.height - borderWidth, textfield.frame.size.width, textfield.frame.size.height);
    border.borderWidth = borderWidth;
    [textfield.layer addSublayer:border];
    textfield.layer.masksToBounds = YES;

}
-(void)setLabelbottomColor:(UILabel*)label
{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 1;
    border.borderColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    border.frame = CGRectMake(0, label.frame.size.height - borderWidth, label.frame.size.width, label.frame.size.height);
    border.borderWidth = borderWidth;
    [label.layer addSublayer:border];
    label.layer.masksToBounds = YES;
    
}
-(void)setButtonBorder:(UIButton*)b
{
    CALayer *border = [CALayer layer];
    border.backgroundColor =  [UIColor colorWithRed:0.827 green:0.827 blue:0.827 alpha:1].CGColor;
    
    border.frame = CGRectMake(0, b.frame.size.height , b.frame.size.width, 1);
    [b.layer addSublayer:border];
}

#pragma textfield Delegate function
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //if (textField == self.txtDTMobile) {
       // [textField setKeyboardType:UIKeyboardTypePhonePad];
       // return NO;
    //}
        [textField resignFirstResponder];
    
    return YES;
}
- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    // [txtView resignFirstResponder];
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma  textfield is set scrollview move up
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.txtDTEmail || textField == self.txtDTNRIC || textField == self.txtDTMobile || textField == self.txtSchoolName || textField == self.txtExpiryOfStudentCard ) {
        CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y +100);
        [self.mydetailScrollview setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.mydetailScrollview setContentOffset:CGPointZero animated:YES];
}


#pragma - image choose from gallery

- (IBAction)frontImageActioin:(id)sender {
   [self chooseImage:self.btnFront];

}
- (IBAction)backImageAction:(id)sender {
      [self chooseImage:self.btnBack];

}

-(void)chooseImage:(UIButton*)b
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    imagePick = b.tag;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popOver=[[UIPopoverController alloc]initWithContentViewController:ipc];
        
    }

}


#pragma mark - ImagePickerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    CGFloat multiplier;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popOver dismissPopoverAnimated:YES];
    }
    if (imagePick == 1) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        self.frontImg.image = image;
        
        if(USE_CONTENT_MODE){
            self.frontImg.contentMode = UIViewContentModeScaleAspectFit;
            
        }else{
            // calculate the correct height of the image given the current width of the image view.
             multiplier = (CGRectGetWidth(self.frontImg.bounds) / image.size.width);
            
            //CGFloat g =multiplier * image.size.height;
            
             [self.FrontImageConstraint setConstant:multiplier * image.size.height];
            if (multiplier > 0.1) {
                self.bottom_view.frame = CGRectMake(3, 285, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
            }
            else
            {
                self.bottom_view.frame = CGRectMake(3, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
            }

                       /*
            if (self.FrontImageConstraint > 0) {
                  self.bottom_view.frame = CGRectMake(0, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
                // self.bottom_view.frame = CGRectMake(0, 285, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
            }
            else if (self.FrontImageConstraint < 0)
            {
               
            }
             */
           
        }

    }
    else if (imagePick == 2)
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        self.backImg.image = image;
        
        if(USE_CONTENT_MODE){
            self.backImg.contentMode = UIViewContentModeScaleAspectFit;
             self.bottom_view.frame = CGRectMake(3, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
        }else{
            // calculate the correct height of the image given the current width of the image view.
             multiplier = (CGRectGetWidth(self.backImg.bounds) / image.size.width);
            
            // update the height constraint with the new known constant (height)
            [self.BackImageConstraint setConstant:multiplier * image.size.height];
            if (multiplier > 0.1) {
                self.bottom_view.frame = CGRectMake(3, 285, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
            }
            else
            {
                self.bottom_view.frame = CGRectMake(3, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
            }

        }
    }
    
    if (multiplier > 0.1) {
        self.bottom_view.frame = CGRectMake(3, 285, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
    }
    else
    {
        self.bottom_view.frame = CGRectMake(3, 231, self.bottom_view.frame.size.width, self.bottom_view.frame.size.height);
    }

    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
  
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
  
}

- (IBAction)isStudentAction:(id)sender {
    if (self.btnStudent.selected) {
        self.btnStudent.selected = false;
        [self.btnStudent setBackgroundImage:[UIImage imageNamed:@"ic-common-checked.png"] forState:UIControlStateSelected];
        
        self.txtSchoolName.hidden = true;
        self.txtExpiryOfStudentCard.hidden = true;
        self.lblExpiry.hidden = true;
        self.lblSchoolName.hidden = true;
        self.btnExpired.hidden = true;
        isStudent = true;
       
        self.btnUpdate.frame = CGRectMake(5, 368, self.btnUpdate.frame.size.width, self.btnUpdate.frame.size.height);
    }
    else
    {
        self.btnStudent.selected = true;
        
        self.txtSchoolName.hidden = false;
        self.txtExpiryOfStudentCard.hidden = false;
        self.lblExpiry.hidden = false;
        self.lblSchoolName.hidden = false;
        self.btnExpired.hidden = false;
        isStudent = false;
        
        self.btnUpdate.frame = CGRectMake(5, 449, self.btnUpdate.frame.size.width, self.btnUpdate.frame.size.height);
    }
    
}

- (IBAction)ShowCalendar:(id)sender {
    /*
    if ([self.pmCC isCalendarVisible])
    {
        [self.pmCC dismissCalendarAnimated:NO];
    }
    
    BOOL isPopover = YES;
    
    // limit apple calendar to 2 months before and 2 months after current date
    PMPeriod *allowed = [PMPeriod periodWithStartDate:[[NSDate date] dateByAddingMonths:-2]
                                              endDate:[[NSDate date] dateByAddingMonths:2]];
    
    
    self.pmCC = [[PMCalendarController alloc] initWithThemeName:@"default"];
    
    self.pmCC.delegate = self;
    self.pmCC.mondayFirstDayOfWeek = NO;
    
    
    [self.pmCC presentCalendarFromView:sender
              permittedArrowDirections:PMCalendarArrowDirectionAny
                             isPopover:isPopover
                              animated:YES];
     */
   
    UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [viewDatePicker setBackgroundColor:[UIColor clearColor]];
    
    //Make a frame for the picker & then create the picker
    CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    [viewDatePicker addSubview:datePicker];
    if (![self.txtDTDOB.text isEqualToString:@""]) {
        NSString *dateString = self.txtDTDOB.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];//dd-MM-yyyy
        NSDate *dateFromString = [[NSDate alloc] init];
        // voila!
        dateFromString = [dateFormatter dateFromString:dateString];
        [datePicker setDate:dateFromString];
    }
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"\n\n\n\n\n\n\n\n\n\n"
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController.view addSubview:viewDatePicker];
        
        
        
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         //Detect particular click by tag and do some thing here
                                         
                                            [self setSelectedDateInField];
                                       
                                         NSLog(@"OK action");
                                         
                                     }];
        [alertController addAction:doneAction];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        
        
        [alertController addAction:cancelAction];
        
    [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [actionSheet addSubview:viewDatePicker];
        [actionSheet showInView:self.view];
        
    }
   
}

- (IBAction)ChooseGenderAction:(id)sender {
    UIButton *showBtn = sender;
    
    PopoverView *popoverView = [PopoverView new];
    
    popoverView.menuTitles   = @[@"Male", @"Female"];
    __weak __typeof(&*self)weakSelf = self;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        
        weakSelf.lblGender.text = popoverView.menuTitles[index];
        
    }];

}

// Methods to set selected date and time in related field

-(void)setSelectedDateInField
{
    NSLog(@"date :: %@",datePicker.date.description);
    
    
    //set Date formatter
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
            [self.txtDTDOB setText:[formatter1 stringFromDate:datePicker.date]];
    
}



#pragma mark PMCalendarControllerDelegate methods
/*
- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
{
    self.txtDTDOB.text = [NSString stringWithFormat:@"%@ "
                          , [newPeriod.startDate dateStringWithFormat:@"dd/MM/yyyy"]];
    if ([self.pmCC isCalendarVisible])
    {
        [self.pmCC dismissCalendarAnimated:NO];
    }
    else
    {
        // [self.pmCC dismissCalendarAnimated:YES];
    }
    
}
 */

- (IBAction)ExpiredDateTimeSchoolAction:(id)sender {
    UIView *viewDatePicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [viewDatePicker setBackgroundColor:[UIColor clearColor]];
    
    //Make a frame for the picker & then create the picker
    CGRect pickerFrame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    [viewDatePicker addSubview:datePicker];
    
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                 message:@"\n\n\n\n\n\n\n\n\n\n"
                                                                          preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController.view addSubview:viewDatePicker];
        
        
        
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         //Detect particular click by tag and do some thing here
                                         
                                         [self setSelectedDateInExpiredField];
                                         
                                         NSLog(@"OK action");
                                         
                                     }];
        [alertController addAction:doneAction];
        
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                       }];
        
        
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Done" otherButtonTitles:nil, nil];
        [actionSheet addSubview:viewDatePicker];
        [actionSheet showInView:self.view];
        
    }
}
-(void)setSelectedDateInExpiredField
{
    NSLog(@"date :: %@",datePicker.date.description);
    
    
    //set Date formatter
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd"];
    
    [self.txtExpiryOfStudentCard setText:[formatter1 stringFromDate:datePicker.date]];
    
}

- (void) parseResponse:(NSData *) data {
    
    NSString *myData = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    NSLog(@"JSON data = %@", myData);
    NSError *error = nil;
    
    //parsing the JSON response
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:NSJSONReadingAllowFragments
                     error:&error];
    if (jsonObject != nil && error == nil){
        NSLog(@"Successfully deserialized...");
        
        //check if the country code was valid
        NSNumber *success = [jsonObject objectForKey:@"success"];
        if([success boolValue] == YES){
            
                   }
        else {
           // self.myLabel.text = @"Country Code is Invalid...";
        }
        
    }
    
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    returnData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [returnData appendData:data];
}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //  serverResponse.text = NO_CONNECTION;
    if (error.code == NSURLErrorTimedOut)
        // handle error as you want
        
    {
        CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
        
        DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:@"Connection Time Out"];
        
        // Add some custom content to the alert view
        
        [alertView setContainerView:alert];
        
        
        
        // Modify the parameters
        
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", @"Retry", nil]];
        
        [alertView setDelegate:self];
        
        
        
        // You may use a Block, rather than a delegate.
        
        [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
            
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            
            [alertView close];
            
        }];
        
        
        
        [alertView setUseMotionEffects:true];
        
        
        
        // And launch the dialog
        
        [alertView show];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
     [li showLoading:self.view animated:NO];
    NSError *error;
    if (connection == serverConnection) {
       // [MBProgressHUD hideHUDForView:self.view animated:YES];

        NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:returnData options:0 error:&error];
        
        NSLog(@"Response: %@", responseString);
         NSLog(@"Response: %@", jsonData);
        NSMutableArray *copyArr = [[NSMutableArray alloc]init];
        self.code = [jsonData[@"responseCode"]integerValue];
        self.message = jsonData [@"responseMessage"];
        self.data =  jsonData[@"data"];
        if (self.code == 1  ) {
            self.message = [jsonData objectForKey:@"responseMessage"];
            
            if ([jsonData[@"data"]count ]>0) {
                self.txtDTFirstName.text =jsonData[@"data"][@"firstName"];
                self.txtDTLastName.text = jsonData[@"data"][@"lastName"];
                self.txtDTEmail.text =  jsonData[@"data"][@"email"];
               
                self.txtDTNRIC.text = jsonData[@"data"][@"nric"];
                NSString *g = jsonData[@"data"][@"gender"];
                if ([g isEqualToString:@"F"]) {
                    self.txtDTGender.text = @"Female";
                }
                else
                {
                    self.txtDTGender.text = @"Male";
                }
                self.txtDTDOB.text = jsonData[@"data"][@"dob"];
                self.txtDTMobile.text= jsonData[@"data"][@"phoneNo"];
                 self.txtSchoolName.text=jsonData[@"data"][@"schoolName"];
                self.btnExpired.titleLabel.text= jsonData[@"data"][@"studentCardExpire"];
                NSString *st= [NSString stringWithFormat:@"$ %@",jsonData[@"data"][@"isStudent"]];
                if ([st isEqualToString:@"1"]) {
                    self.btnStudent.selected = true;
                }
                else
                {
                    self.btnStudent.selected = false;
                }
            }
            else
            {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TabViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"TabViewController"];
                [self tabBarController:vc didSelectViewController:self];
                [self.navigationController presentModalViewController:vc animated:YES];
            }
                
            
        }
        else if (self.code == 1002)
        {
            self.message = [jsonData objectForKey:@"responseMessage"];
           
            
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
            // Add some custom content to the alert view
            [alertView setContainerView:alert];
            
            // Modify the parameters
            [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
            [alertView setDelegate:self];
            
            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];


            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SignInViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
           
            [self.navigationController presentViewController:vc animated:true completion:nil];
        }
        else if (self.code == 1000)
        {
          
                
                NSMutableArray *copyArr = [[NSMutableArray alloc]init];
                self.data =  jsonData[@"data"];
                NSLog(@"data %@",jsonData[@"data"]);
                for (int i =0; i<self.data.count; i++) {
                    NSDictionary *jsonElement = self.data[i];
                    
                    // Add this question to the locations array
                    [copyArr addObject:jsonElement];
                    
                }
                
                
                NSString *fieldCode = [[copyArr objectAtIndex:0]objectForKey:@"fieldCode"];
                NSString *errorMessage= [[copyArr objectAtIndex:0]objectForKey:@"errorMessage"];
                
            
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
            // Add some custom content to the alert view
            [alertView setContainerView:alert];
            
            // Modify the parameters
            [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
            [alertView setDelegate:self];
            
            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];

            

        }
        else
        {
            
            CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
            DemoAlertView *alert = [[DemoAlertView alloc]initWithFrame:CGRectMake(0, 0, 290, 200) image:@"ic-common-error@2x.png" title:@"Failure" message:self.message];
            // Add some custom content to the alert view
            [alertView setContainerView:alert];
            
            // Modify the parameters
            [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"OK", nil]];
            [alertView setDelegate:self];
            
            // You may use a Block, rather than a delegate.
            [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
                NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                [alertView close];
            }];
            
            [alertView setUseMotionEffects:true];
            
            // And launch the dialog
            [alertView show];

        }
    }
    

}
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    [li showLoading:self.view animated:NO];
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    if ((int)[alertView tag]==0) {
        [serverConnection start];
    }
    [alertView close];
}

-(void)getProfileData
{
   // NSString *bankURL = @"http://192.168.1.47:8080/api/parttimer/getPartTimerInfo.htm?json=";
    NSString *bankURL = @"http://ihughos.com/api/parttimer/getPartTimerInfo.htm?json=";
   NSString *data = [NSString stringWithFormat:@"{\"partTimerId\":\"%d\",\"sessionId\":\"%@\"}",userID,sessionID];
    // NSString *data = [NSString stringWithFormat:MyDetailJSON,userID,sessionID];
       [s sendDataToServer:POST_METHOD JsonData:data sendURl:GetMyDetailURL body:nil];
}

- (IBAction)ChooseUniformAction:(id)sender {
    UIButton *showBtn = sender;
    
    PopoverView *popoverView = [PopoverView new];
    
    popoverView.menuTitles   = @[@"S", @"M", @"L", @"XL"];
    __weak __typeof(&*self)weakSelf = self;
    [popoverView showFromView:showBtn selected:^(NSInteger index) {
        
        weakSelf.lbluniformSize.text = popoverView.menuTitles[index];
        
    }];

}
- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}


@end
