//
//  Question.h
//  MedQuest
//
//  Created by Justin Grant on 11/21/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IQuestion.h"

@interface Question : NSObject <IQuestion>
{
    NSArray* cDetails;
    NSString* cTitle;
    NSNumber* cId;
    NSNumber* cAnswer;
}
@end
