//
//  VWWUserDefaults.h
//  KnockItOff
//
//  Created by Zakk Hoyt on 3/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VWWUserDefaults : NSObject
+(VWWUserDefaults*)sharedInstance;



-(NSDate*)startDate;
-(void)setStartDate:(NSDate*)date;


-(NSString*)startDateString;
-(UIImage*)imageForStartDate;
-(NSString*)imageStringForStartDate;
-(UIColor*)imageStringColorForStartDate;
-(NSString*)statusStringForStartDate;

-(NSURL*)backgroungImageURL;
-(void)setBackgroundImageURL:(NSURL*)backgroundImageURL;

@end
