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




@end
