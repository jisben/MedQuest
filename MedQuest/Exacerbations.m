//
//  Exacerbations.m
//  MedQuest
//
//  Created by Leo Chan on 11/23/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "Exacerbations.h"

@implementation Exacerbations
@synthesize MaxResponse, MinResponse;

-(NSNumber*) getScore
{
    NSInteger score = 0;
    
    for(id<IQuestion> question in questions)
    {
        NSNumber* ans = [question getAnswer];
        if(ans == nil)
        {
            return nil;
        }
        else
            
        {
            score += ans.intValue;
        }
    }
    
    return [[NSNumber alloc] initWithInt:score];
    
}

-(id) initWithSummary:(NSString*) summary ident:(NSNumber*) ident
{
    self = [super init];
    if(self)
    {
        name = summary;
        questions = [[NSMutableArray alloc] init];
        MaxResponse = 100;
        MinResponse = 0;
        dateAnswered = [NSDate date];
    }
    return self;
}

+(id<IQuestionnaire>) createQuestionnaire:(NSString*) summary withId:(NSNumber*) ident
{
    return [[Exacerbations alloc] initWithSummary:summary ident:ident];
}


@end
