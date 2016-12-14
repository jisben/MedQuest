//
//  IQuestion.h
//  MedQuest
//
//  Created by Justin Grant on 11/21/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IQuestion <NSObject>

/*
    This is the factory method that will create the specific IQuestion object.  details is a list of NSArray*
    objects that are specific to the questionnaire type.  ident is a unique number that is enforced by the database.
 */
+(id<IQuestion>) createQuestion:(NSString*) title withDetails:(NSArray*) details withId:(NSNumber*) ident;

/* Getters & Setters */
-(void) setAnswer:(NSNumber*) answer;
-(NSNumber*) getAnswer;
-(NSNumber*) getId;
-(NSString*) getTitle;
-(NSArray*) getDetails;

@end
