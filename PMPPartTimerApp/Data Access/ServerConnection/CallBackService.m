//
//  CallBackService.m
//  PMPPartTimerApp
//
//  Created by AmtasMac1 on 5/17/16.
//  Copyright (c) 2016 AmtasMac1. All rights reserved.
//

#import "CallBackService.h"

@implementation CallBackService
-(void)processJobsResponse:(NSDictionary*)items;
{
    NSMutableArray *copyArr = [[NSMutableArray alloc]init];
    NSLog(@"%@",items );
    // Loop through Json objects, create question objects and add them to our questions array
    ResponseCode *code = [[ResponseCode alloc]initWithDictionary:items];
    for (int i =0; i<code.data.count; i++) {
        NSDictionary *jsonElement = code.data[i];
     
        // Add this question to the locations array
       [copyArr addObject:jsonElement];
        
    }
    
   
    // if (self.Callback_delegate) {
   //  [self.Callback_delegate sendData:copyArr code:code.code msg:code.message];
    // }
     
     
}
@end
