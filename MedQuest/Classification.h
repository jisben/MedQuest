//
//  Classification.h
//  MedQuest
//
//  Created by Justin Grant on 11/22/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IClassification.h"
#import "MedQuestAppDelegate.h"

@interface Classification : NSObject <IClassification>
{
    NSNumber* cScore;

}

-(id) initWithScore:(NSNumber*) score;

@end
