//
//  mMRCTableViewController.h
//  MedQuest
//
//  Created by Leo Chan on 11/3/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mMRCQuestionnaire.h"
#import "MedQuestAppDelegate.h"

@interface mMRCTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    __weak MedQuestAppDelegate* appDelegate;
    
}

@end
