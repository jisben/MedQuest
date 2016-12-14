//
//  mMRCQuestionnaire.m
//  MedQuest
//
//  Created by Leo Chan on 11/3/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "mMRCQuestionnaire.h"
#import "IQuestion.h"

@implementation mMRCQuestionnaire
@synthesize MaxResponse, MinResponse;

-(NSNumber*) getScore
// There is one element that is non-zero as this is a single selection question (choose 1 of 5)
{
    NSNumber* score;
    
    for(id<IQuestion> question in questions)
    {
        score = [question getAnswer];
        if (score != nil)
        {
            break;
        }
    }
    
    return score;
}

-(id) initWithSummary:(NSString*) summary ident:(NSNumber*) ident
{
    self = [super init];
    if(self)
    {
        name = summary;
        questions = [[NSMutableArray alloc] init];
        MaxResponse = 7;
        MinResponse = 0;
        dateAnswered = [NSDate date];
    }
    return self;
}

+(id<IQuestionnaire>) createQuestionnaire:(NSString*) summary withId:(NSNumber*) ident
{
    return [[mMRCQuestionnaire alloc] initWithSummary:summary ident:ident];
}

@end
