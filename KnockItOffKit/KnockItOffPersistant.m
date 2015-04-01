//
//  KnockItOffPersistant.m
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "KnockItOffPersistant.h"

@interface KnockItOffPersistant()
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation KnockItOffPersistant

+(KnockItOffPersistant*)sharedInstance{
    static KnockItOffPersistant *instance;
    if(instance == nil){
        instance = [[KnockItOffPersistant alloc]init];
    }
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.defaults = [[NSUserDefaults alloc]initWithSuiteName:@"group.com.vaporwarewolf.KnockItOff"];
    }
    return self;
}

#pragma mark StartDate
static NSString *VWWStartDateKey = @"startDate";

-(NSDate*)startDate{
    NSDate *date = [self.defaults objectForKey:VWWStartDateKey];
    return date;
}

-(void)setStartDate:(NSDate*)startDate{
    [self.defaults setObject:startDate forKey:VWWStartDateKey];
    [self.defaults synchronize];
}

static NSString *VWWPricePerDayDateKey = @"pricePerDay";
-(NSUInteger)pricePerDay{
    NSNumber *number = [self.defaults objectForKey:VWWPricePerDayDateKey];
    if(number) {
        NSLog(@"pricePerDay: %lu", (unsigned long)number.unsignedIntegerValue);
        return number.unsignedIntegerValue;
    } else {
        NSLog(@"pricePerDay: 999 (default)");
        return 1000; // $10.00
    }
}
-(void)setPricePerDay:(NSUInteger)pricePerDay{
    [self.defaults setObject:@(pricePerDay) forKey:VWWPricePerDayDateKey];
    [self.defaults synchronize];
    NSLog(@"setPricePerDay: %lu", (unsigned long)pricePerDay);
}

static NSString *VWWBeveragesPerDayDateKey = @"beveragesPerDay";
-(NSUInteger)beveragesPerDay {
    NSNumber *number = [self.defaults objectForKey:VWWBeveragesPerDayDateKey];
    if(number) {
        return number.floatValue;
    } else {
        return 6;
    }
}

-(void)setBeveragesPerDay:(NSUInteger)beveragesPerDay{
    [self.defaults setObject:@(beveragesPerDay) forKey:VWWBeveragesPerDayDateKey];
    [self.defaults synchronize];
}






#pragma mark AlarmTime
static NSString *VWWLocalNotificationsKey = @"localNotifications";
-(BOOL)localNotifications{
    return [self.defaults boolForKey:VWWLocalNotificationsKey];
}
-(void)setLocalNotifications:(BOOL)localNotifications{
    [self.defaults setBool:localNotifications forKey:VWWLocalNotificationsKey];
    [self.defaults synchronize];
}



static NSString *VWWAlarmTimeKey = @"alarmTime";
-(NSDate*)alarmTime{
    NSDate *date = [self.defaults objectForKey:VWWAlarmTimeKey];
    return date;
}
-(void)setAlarmTime:(NSDate*)alarmTime{
    [self.defaults setObject:alarmTime forKey:VWWAlarmTimeKey];
    [self.defaults synchronize];
}



#pragma mark Summary
-(Summary*)summary{
    Summary *summary = [[Summary alloc]initWithStartDate:self.startDate];
    return summary;
}

#pragma mark BackgroundImage
static NSString *VWWBackgroundImagePathKey = @"backgroundImagePath";

-(NSURL*)backgroungImageURL{
    NSString *path = [self.defaults objectForKey:VWWBackgroundImagePathKey];
    NSURL *url = [NSURL URLWithString:path];
    return url;
}
-(void)setBackgroundImageURL:(NSURL*)backgroundImageURL{
    [self.defaults setObject:backgroundImageURL.absoluteString forKey:VWWBackgroundImagePathKey];
    [self.defaults synchronize];
    
}

@end
