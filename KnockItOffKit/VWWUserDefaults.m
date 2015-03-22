//
//  VWWUserDefaults.m
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "VWWUserDefaults.h"

@interface VWWUserDefaults()
@property (nonatomic, strong) NSUserDefaults *defaults;
@end

@implementation VWWUserDefaults

+(VWWUserDefaults*)sharedInstance{
    static VWWUserDefaults *instance;
    if(instance == nil){
        instance = [[VWWUserDefaults alloc]init];
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

static NSString *VWWStartDateKey = @"startDate";

-(NSDate*)startDate{
    NSDate *date = [self.defaults objectForKey:VWWStartDateKey];
    return date;
}

-(void)setStartDate:(NSDate*)startDate{
    [self.defaults setObject:startDate forKey:VWWStartDateKey];
    [self.defaults synchronize];
}


-(NSString*)startDateString{
    NSString *dateFormatString = @"MMMM dd, YYYY";
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:[self startDate]];
    if(dateString == nil) dateString = @"";
    return dateString;
}

-(UIImage*)imageForStartDate{
    // 1-6 day (1) "1 day" - yellow smiley face  with red border
    // 7-13 days (1) "7 days" - yellow circle with red border and red week number
    // 31-61 days (1) "31 days" - Yellow star with red border and green text
    // 365+ (1) "365 days" Yellow start with black smiley face and red border

    NSInteger days = [self daysSinceStartDate];
    if(days >= 0 && days <= 6){
        return [UIImage imageNamed:@"Circle"];
    } else if(days >= 7 && days <= 30){
        return [UIImage imageNamed:@"Circle"];
    } else if(days >= 31 && days <= 364){
        return [UIImage imageNamed:@"Star"];
    } else if(days >= 365 && days <= INT_MAX){
        return [UIImage imageNamed:@"Star"];
    }
    return nil;
}

-(NSString*)imageStringForStartDate{
    NSInteger days = [self daysSinceStartDate];
    if(days >= 0 && days <= 6){
        return [NSString stringWithFormat:@":)"];
    } else if(days >= 7 && days <= 30){
        return [NSString stringWithFormat:@"%ld", (long)days / 7];
    } else if(days >= 31 && days <= 364){
        return [NSString stringWithFormat:@"%ld", (long)days / 31];
    } else if(days >= 365 && days <= INT_MAX){
        return [NSString stringWithFormat:@":)"];
    }
    return nil;
}
-(UIColor*)imageStringColorForStartDate{
    // 1 green
    // 2 red
    // 3 blue
    // 4 purple
    
    NSInteger days = [self daysSinceStartDate];
    if(days >= 0 && days <= 6){
        return [UIColor blackColor];
    } else if(days >= 7 && days <= 30){
        return [self colorForNumber:(NSUInteger)(days / 7.0)];
    } else if(days >= 31 && days <= 364){
        return [self colorForNumber:(NSUInteger)(days / 31.0)];
    } else if(days >= 365 && days <= INT_MAX){
        return [UIColor blackColor];
    }
    return [UIColor blackColor];

}

-(NSString*)statusStringForStartDate{
    NSInteger days = [self daysSinceStartDate];
    return [NSString stringWithFormat:@"%ld days since your last drink", (long)days];
}

#pragma mark Private methods

-(UIColor*)colorForNumber:(NSUInteger)number{
    switch (number) {
        case 1:
            return [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:1.0];
            break;
        case 2:
            return [UIColor colorWithRed:0.7 green:0.0 blue:0.0 alpha:1.0];
            break;
        case 3:
            return [UIColor blueColor];
            break;
        case 4:
            return [UIColor purpleColor];
            break;
        default:
            break;
    }
    return [UIColor blackColor];
}

-(NSInteger)daysSinceStartDate{
    NSDate *startDate = [self.defaults objectForKey:VWWStartDateKey];
    if(startDate == nil){
        return -1;
    }
    
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:startDate];
    NSTimeInterval days = (NSInteger)(seconds / 60.0 / 60.0 / 24.0);
    return days;
}

@end
