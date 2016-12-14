//
//  IClassification.h
//  MedQuest
//
//  Created by Justin Grant on 11/22/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IClassification <NSObject>

/*
 This function will dynamically calculate the classification 
 from the score.
*/
-(NSString*)getClassification;
-(NSNumber*)getScore;

/*
 This is the factory method that will create the appropriate object.
 */
+(id<IClassification>) classificationWithScore:(NSNumber*) score;
@end
