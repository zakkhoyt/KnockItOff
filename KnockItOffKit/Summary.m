//
//  Summary.m
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "Summary.h"
#import <UIKit/UIKit.h>

@interface Summary ()

@end
@implementation Summary

-(instancetype)init{
    NSAssert(NO, @"Must use initWithStartDate intializer");
    return nil;
}

-(instancetype)initWithStartDate:(NSDate*)startDate{
    self = [super init];
    if(self){
        _startDate = startDate;
        _currentDate = [NSDate date];
        [self setupStartDateString];
        [self setupDaysQuit];
        [self setupDaysQuitString];
        [self setupTimeQuitString];
        [self setupTimeQuitStringColor];
        [self setupTimeQuitImage];
        [self setupBeersSaved];
        [self setupMoneySaved];
        [self setupCaloriesSaved];
        NSLog(@"");
    }
    return self;
}
-(void)setCurrentDate:(NSDate *)currentDate{
    _currentDate = currentDate;
    [self setupStartDateString];
    [self setupDaysQuit];
    [self setupDaysQuitString];
    [self setupTimeQuitString];
    [self setupTimeQuitStringColor];
    [self setupTimeQuitImage];
    [self setupBeersSaved];
    [self setupMoneySaved];
    [self setupCaloriesSaved];
}

#pragma mark Private

-(void)setupStartDateString{
    NSString *dateFormatString = @"MMMM dd, YYYY";
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    _startDateString = [dateLocal stringFromDate:[self startDate]];
}
-(void)setupDaysQuit{
    _daysQuit = [self daysSinceStartDate];
}
-(void)setupDaysQuitString{
    NSInteger daysQuit = [self daysSinceStartDate].integerValue;
    _daysQuitString = [NSString stringWithFormat:@"%lu days since your last drink.", (unsigned long)daysQuit];
}
-(void)setupTimeQuitString{
    _timeQuitString = [self timeSinceStartDate];
}
-(void)setupTimeQuitStringColor{
    _timeQuitStringColor = [self colorForTimeQuitString];
}
-(void)setupTimeQuitImage{
    _timeQuitImage = [self imageForStartDate];
}
-(void)setupBeersSaved{
    NSInteger beersSaved = ((NSNumber*)[self daysSinceStartDate]).integerValue * 6;
    _beersSaved = @(beersSaved);
}
-(void)setupMoneySaved{
    _moneySaved = @(_beersSaved.integerValue * 9.99 / 6.0);
}
-(void)setupCaloriesSaved{
    _caloriesSaved = @(_beersSaved.integerValue * 150);
}



-(NSNumber*)daysSinceStartDate{
    if(_startDate == nil){
        return @(-1);
    }    _moneySaved = @(_beersSaved.integerValue * 9.99);
    
//    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:_startDate];
    NSTimeInterval seconds = [self.currentDate timeIntervalSinceDate:_startDate];
    NSTimeInterval days = (NSInteger)(seconds / 60.0 / 60.0 / 24.0);
    return @(days);
}

-(NSString*)timeSinceStartDate{
    NSInteger days = ((NSNumber*)[self daysSinceStartDate]).integerValue;
    if(days >= 0 && days <= 6){
        return [NSString stringWithFormat:@"%ld", (long)days];
    } else if(days >= 7 && days <= 30){
        return [NSString stringWithFormat:@"%ld", (long)days / 7];
    } else if(days >= 31 && days <= 364){
        return [NSString stringWithFormat:@"%ld", (long)days / 31];
    } else if(days >= 365 && days <= INT_MAX){
        return [NSString stringWithFormat:@"%ld", (long)days / 364];
    }
    return nil;
}

-(UIImage*)imageForStartDate{
    // 1-6 day (1) "1 day" - yellow smiley face  with red border
    // 7-13 days (1) "7 days" - yellow circle with red border and red week number
    // 31-61 days (1) "31 days" - Yellow star with red border and green text
    // 365+ (1) "365 days" Yellow start with black smiley face and red border
    
    NSInteger days = ((NSNumber*)[self daysSinceStartDate]).integerValue;
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


-(UIColor*)colorForTimeQuitString{
    NSInteger days = ((NSNumber*)[self daysSinceStartDate]).integerValue;
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
-(UIColor*)colorForNumber:(NSUInteger)number{
    // 1 green
    // 2 red
    // 3 blue
    // 4 purple

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


@end
