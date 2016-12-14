//
//  Questionnaire.m
//  MedQuest
//
//  Created by Jis Ben on 11/4/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "Questionnaire.h"

@implementation Questionnaire
@synthesize MaxResponse, MinResponse;

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

-(NSString *) getName
{
    return self->name;
}

-(NSString *) getDateAnsweredAsString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormat stringFromDate:dateAnswered];
}

-(void) addQuestion:(NSString*) question
{
    if(question != nil)
    {
        [questions addObject:question];
    }
}

-(NSArray*) getQuestions
{
    return (NSArray*) questions; // convert to NSArray* so that it can't be modified
}

-(NSNumber*) getAnswer:(NSNumber*) questionId
{
    NSNumber* ret;
    
    for(id<IQuestion> question in questions)
    {
        if([question.getId isEqualToNumber:questionId]) // replace compare with isEqualToNumber. compare returns non-nil values when numbers are not equal!
        {
            ret = question.getAnswer;
            break;
        }
    }
    
    return ret;
}

// type of "answer" changed to NSNumber from NSInteger
-(BOOL) setAnswer:(NSNumber*) answer forQuestion:(NSNumber*) questionId
{
    BOOL questionFound = NO;
    
//    NSLog(@"%i",MaxResponse); // MinResponse and MaxResponse values are not initialized properly by children.
    
//    if([answer integerValue] >= MinResponse && [answer integerValue] <= MaxResponse)
    {
        for(id<IQuestion> question in questions)
        {
            if([[question getId] isEqualToNumber:questionId]) // replace compare with isEqualToNumber. compare returns non-nil values when numbers are not equal!
            {
                [question setAnswer:answer];

                questionFound = YES;
                break;
            }
        }
    }
    return questionFound;
}

-(void) clearAnswers
{
    for(id<IQuestion> question in questions)
    {
        [question setAnswer:nil];
    }

}

// Unfortunately we need to return something, nil it is since we should never actually be instantiating this base class.
-(NSNumber*) getScore
{
    return nil;
}

+(id<IQuestionnaire>) createQuestionnaire:(NSString*) summary withId:(NSNumber*) ident
{
    return [[Questionnaire alloc] initWithSummary:summary ident:ident];
}

@end
