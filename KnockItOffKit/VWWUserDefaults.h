//
//  VWWUserDefaults.h
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VWWUserDefaults : NSObject
+(VWWUserDefaults*)sharedInstance;
-(NSDate*)startDate;
-(void)setStartDate:(NSDate*)date;

@end
