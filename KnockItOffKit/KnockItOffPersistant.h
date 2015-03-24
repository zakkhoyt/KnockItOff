//
//  KnockItOffPersistant.h
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summary.h"

@interface KnockItOffPersistant : NSObject
+(KnockItOffPersistant*)sharedInstance;

-(NSDate*)startDate;
-(void)setStartDate:(NSDate*)date;

-(BOOL)localNotifications;
-(void)setLocalNotifications:(BOOL)localNotifications;

-(NSDate*)alarmTime;
-(void)setAlarmTime:(NSDate*)alarmTime;

-(Summary*)summary;

-(NSURL*)backgroungImageURL;
-(void)setBackgroundImageURL:(NSURL*)backgroundImageURL;

@end
