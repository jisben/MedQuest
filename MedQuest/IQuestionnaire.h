//
//  IQuestionnaire.h
//  MedQuest
//
//  Created by Justin Grant on 11/18/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IQuestion.h"

@protocol IQuestionnaire <NSObject>
/*
 This function is the factory method that will create all of the IQuestinnaire objects,
 The "summary" field should be a 1-2 word name of the questionnaire, ident should be a unique 
 counter enforced by the database.
 */
+(id<IQuestionnaire>) createQuestionnaire:(NSString*) name withId:(NSNumber*) ident;

-(NSString *) getName;

-(NSString *) getDateAnsweredAsString;

-(void) addQuestion:(id<IQuestion>) question;

-(NSArray*) getQuestions;

-(void) clearAnswers;

/*
 This function expects the question variable to be a pointer match to one of the NSString objects inserted
 with the addQuestion function.
 Returns YES if the answer was inserted, NO otherwise.
 */
-(BOOL) setAnswer:(NSNumber*) answer forQuestion:(NSNumber*) questionId;
/*
 This function expects the question variable to be a pointer match to one of the NSString objects inserted
 with the addQuestion function.
 Returns the answer that was inserted, nil if no answer has been provided
 */
-(NSNumber*) getAnswer:(NSNumber*) ident;

/*
 This function will return the questionnaires total score, or nil if not enough information is present
 */
-(NSNumber*) getScore;
@end
