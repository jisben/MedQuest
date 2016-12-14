//
//  Question.m
//  MedQuest
//
//  Created by Justin Grant on 11/21/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "Question.h"
#import "IQuestion.h"
@implementation Question 

-(id) initWithTitle:(NSString*) title withDetails:(NSArray*) details withId:(NSNumber*) ident
{
    self = [super init];
    if(self)
    {
        cTitle = title;
        cId = ident;
        cDetails = details;
    }
    return self;
}

+(id<IQuestion>) createQuestion:(NSString*) title withDetails:(NSArray*) details withId:(NSNumber*) ident
{
    return [[Question alloc] initWithTitle:title withDetails:details withId:ident];
}

-(void) setAnswer:(NSNumber*) answer
{
    cAnswer = answer;
}

-(NSNumber*) getAnswer
{
    return cAnswer;
}

-(NSNumber*) getId
{
    return cId;
}

-(NSString*) getTitle
{
    return cTitle;
}

-(NSArray*) getDetails
{
    return cDetails;
}
@end

