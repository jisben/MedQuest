//
//  CATDetailViewController.h
//  MedQuest
//
//  Created by Leo Chan on 11/2/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedQuestAppDelegate.h"

@interface CATDetailViewController : UIViewController
{
        __weak MedQuestAppDelegate* appDelegate;
}
@property ( weak, nonatomic)  NSNumber *Question;

@end
