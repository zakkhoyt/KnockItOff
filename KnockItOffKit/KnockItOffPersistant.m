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
