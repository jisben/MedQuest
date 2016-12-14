//
//  SpiroResults.m
//  MedQuest
//
//  Created by Leo Chan on 11/4/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "SpiroResults.h"

@implementation SpiroResults
@synthesize MaxResponse,MinResponse;

-(NSNumber*) getScore
// Calculates the GOLD Spirometry assessment of 1,2,3 or 4
{
    NSInteger score = 0;
    int FEV1FVC, FEV1Pred;
    NSNumber *tempNum0, *tempNum1;
    BOOL AnswerFound = NO;
    
    tempNum0 = [ self getAnswer:[[NSNumber alloc] initWithInt:0]];
    FEV1FVC = [tempNum0 intValue];
    
    tempNum1 = [ self getAnswer:[[NSNumber alloc] initWithInt:1]];
    FEV1Pred = [tempNum1 intValue];
    
    if (tempNum0!=nil & tempNum1!=nil) {

        AnswerFound = YES;
        
        // GOLD 1 - Mild: FEV1/FVC < 0.70, FEV1 >= 80% predicted
        if (FEV1FVC<70 & FEV1Pred>=80) score = 1;
        // GOLD 2 - Moderate: FEV1/FVC < 0.70, 50% <= FEV1 <80% predicted
        if (FEV1FVC<70 & FEV1Pred>=50 & FEV1Pred<80) score = 2;
        // GOLD 3 - Severe: FEV1/FVC < 0.70, 30% <= FEV1 < 50% predicted
        if (FEV1FVC<70 & FEV1Pred>=30 & FEV1Pred<50) score = 3;
        // GOLD 4 - Very Severe: FEV1/FVC < 0.70, FEV1 <30% predicted
        if (FEV1FVC<70 & FEV1Pred<30) score = 4;
        }

    
    if (AnswerFound)
        return [[NSNumber alloc] initWithInt:score];
    else
        return nil;
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
    return [[SpiroResults alloc] initWithSummary:summary ident:ident];
}
@end
