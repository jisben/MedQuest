//
//  Classification.m
//  MedQuest
//
//  Created by Justin Grant on 11/22/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "Classification.h"

@implementation Classification

-(id) initWithScore:(NSNumber*)score 
{
    self = [super init];
    if(self)
    {
        cScore = score;
    }
    return self;
}

-(NSString*)getClassification
{
    BOOL severeSymptoms, highRisk;
    NSString* classification =@"NA"; 
    
    MedQuestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSNumber* CATscore = [appDelegate.CATQuestionnaireInfo getScore];
    NSNumber* mMRCscore = [appDelegate.mMRCQuestionnaireInfo getScore];
    NSNumber* SpiroScore = [appDelegate.SpiroResultsInfo getScore];
    NSNumber *numExac = [appDelegate.ExacerbationsInfo getScore];
    
    
    severeSymptoms = [SpiroScore intValue]>=3 || ([numExac intValue]>=2);
    highRisk = [CATscore intValue]>=10||[mMRCscore intValue]>=2;
    
    if (!highRisk & !severeSymptoms)
    {
        classification =@"A";
    }
    if (!highRisk & severeSymptoms)
    {
        classification =@"B";
    }
    if (highRisk & !severeSymptoms)
    {
        classification =@"C";
    }
    if (highRisk & severeSymptoms)
    {
        classification =@"D";
    }
    
    return classification;
}

-(NSNumber*) getScore
{
    return cScore;
}

+(id<IClassification>) classificationWithScore:(NSNumber*) score
{
    return [[Classification alloc] initWithScore:score];
}

@end
