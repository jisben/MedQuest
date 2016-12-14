//
//  Question.m
//  MedQuest
//
//  Created by Justin Grant on 10/27/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "CATQuestionnaire.h"

@implementation CATQuestionnaire

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
        MaxResponse = 4;
        MinResponse = 0;
        dateAnswered = nil;
    }
    return self;
}

+(id<IQuestionnaire>) createQuestionnaire:(NSString*) summary withId:(NSNumber*) ident
{
    return [[CATQuestionnaire alloc] initWithSummary:summary ident:ident];
}

@end
