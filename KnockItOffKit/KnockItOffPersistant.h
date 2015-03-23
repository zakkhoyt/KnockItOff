//
//  KnockItOffPersistant.h
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Summary.h"

static NSString *KnockItOffPersistantStartDateKey = @"startDate";
static NSString *KnockItOffPersistantDaysQuitKey = @"daysQuit";
static NSString *KnockItOffPersistantTimeQuitKey = @"timeQuit";
static NSString *KnockItOffPersistantBeersSavedKey = @"beersSaved";
static NSString *KnockItOffPersistantMoneySavedKey = @"moneySaved";
static NSString *KnockItOffPersistantCaloriesSavedKey = @"caloriesSaved";



@interface KnockItOffPersistant : NSObject
+(KnockItOffPersistant*)sharedInstance;



-(NSDate*)startDate;
-(void)setStartDate:(NSDate*)date;

//-(float)costPerDrink;
//-(void)setCostPerDrink:(float)costPerDrink;

-(Summary*)summary;


-(NSString*)startDateString;
-(UIImage*)imageForStartDate;
-(NSString*)imageStringForStartDate;
-(UIColor*)imageStringColorForStartDate;
-(NSString*)statusStringForStartDate;

-(NSURL*)backgroungImageURL;
-(void)setBackgroundImageURL:(NSURL*)backgroundImageURL;





@end
