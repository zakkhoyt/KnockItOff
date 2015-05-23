//
//  Summary.h
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/23/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Summary : NSObject

// Using this initializer, all i-vars will be populated
-(instancetype)initWithStartDate:(NSDate*)startDate;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSString *startDateString;
@property (nonatomic, strong) NSNumber *daysQuit;
@property (nonatomic, strong) NSString *daysQuitString;
@property (nonatomic, strong) NSString *timeQuitString;
@property (nonatomic, strong) UIImage *timeQuitImage;
@property (nonatomic, strong) UIColor *timeQuitStringColor;
@property (nonatomic, strong) NSNumber *beersSaved;
@property (nonatomic, strong) NSNumber *moneySaved;
@property (nonatomic, strong) NSNumber *caloriesSaved;

@end
