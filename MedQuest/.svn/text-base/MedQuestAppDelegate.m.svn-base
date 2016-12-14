//
//  MedQuestAppDelegate.m
//  MedQuest
//
//  Created by Justin Grant on 10/27/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "MedQuestAppDelegate.h"
#import "CATQuestionnaire.h"
#import "mMRCQuestionnaire.h"
#import "SpiroResults.h"
#import "Exacerbations.h"
#import "Question.h"
@implementation MedQuestAppDelegate
@synthesize CATQuestionnaireInfo, mMRCQuestionnaireInfo, SpiroResultsInfo, ExacerbationsInfo;
@synthesize dbObj;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dbObj = [[MedQuestDBObject alloc] init];

    // Query the database for new, empty questionnaires
    NSMutableArray *questionnaires = [dbObj readEmptyQuestionnairesFromDatabase];
    
    // If there is nothing in the database, build questionnaires manually
    if ([questionnaires count] == 0)
    {
        CATQuestionnaireInfo = [CATQuestionnaire createQuestionnaire:@"CAT" withId:[[NSNumber alloc] initWithInt:0]];
        
        NSArray *detailArray = [[NSArray alloc]initWithObjects:@"I never cough",@"I cough all the time", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Cough" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:0]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"I have no phlegm (mucus) in my chest at all",@"My chest is completely full of phlegm (mucus)", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Phlegm" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:1]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"My chest does not feel tight at all",@"My chest feels very tight", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Tight chest" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:2]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"When I walk up a hill or one flight of stairs I am not breathless",@"When I walk up a hill or one flight to stairs I am very breathless", nil];    [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Breathless" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:3]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"I am not limited doing any activities at home",@"I am very limited doing activities at home", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Limited activities" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:4]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"I am confident leaving my home despite my lung condition",@"I am not at all confident leaving my home because of my lung condition", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Home bound" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:5]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"I sleep soundly",@"I don't sleep soundly because of my lung condition", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Sleep" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:6]]];
        
        detailArray = [[NSArray alloc]initWithObjects:@"I have lots of energy",@"I have no energy at all", nil];
        [CATQuestionnaireInfo addQuestion:[Question createQuestion:@"Energy" withDetails:detailArray withId:[[NSNumber alloc] initWithInt:7]]];
        
        detailArray = nil;
        
        // Populate mMRC Questionnaire manually until DB available
        
        mMRCQuestionnaireInfo = [mMRCQuestionnaire createQuestionnaire:@"mMRC" withId:[[NSNumber alloc] initWithInt:1]];
        
        [mMRCQuestionnaireInfo addQuestion:[Question createQuestion:@"I only get breathless with strenuous exercise" withDetails:nil withId:[[NSNumber alloc] initWithInt:0]]];
        [mMRCQuestionnaireInfo addQuestion:[Question createQuestion:@"I get short of breath when hurrying on level ground or walking up a slight hill" withDetails:nil withId:[[NSNumber alloc] initWithInt:1]]];
        [mMRCQuestionnaireInfo addQuestion:[Question createQuestion:@"On level ground, I walk slower than people of the same age because of breathlessness, or have to stop for breath when walking at my own pace" withDetails:nil withId:[[NSNumber alloc] initWithInt:2]]];
        [mMRCQuestionnaireInfo addQuestion:[Question createQuestion:@"I stop for breath after walking about 100 yards or after a few minutes on level ground" withDetails:nil withId:[[NSNumber alloc] initWithInt:3]]];
        [mMRCQuestionnaireInfo addQuestion:[Question createQuestion:@"I am too breathless to leave the house or I am breathless when dressing" withDetails:nil withId:[[NSNumber alloc] initWithInt:4]]];
        
        // Populate Spirometry Questionnaire manually until DB available
        
        SpiroResultsInfo = [SpiroResults createQuestionnaire:@"Spirometry" withId:[[NSNumber alloc] initWithInt:2]];
        
        [SpiroResultsInfo addQuestion:[Question createQuestion:@"FEV1/FVC" withDetails:nil withId:[[NSNumber alloc] initWithInt:0]]];
        [SpiroResultsInfo addQuestion:[Question createQuestion:@"FEV1 Predicted" withDetails:nil withId:[[NSNumber alloc] initWithInt:1]]];
        
        // Populate Exacerbations Questionnaire manually until DB available
        
        ExacerbationsInfo = [Exacerbations createQuestionnaire:@"Exacerbations" withId:[[NSNumber alloc] initWithInt:3]];
        
        [ExacerbationsInfo addQuestion:[Question createQuestion:@"In last 12 months" withDetails:nil withId:[[NSNumber alloc] initWithInt:0]]];
        
    }

    for (id<IQuestionnaire> q in questionnaires)
    {
        NSString *qName = [q getName];
        if ([qName isEqualToString:@"CAT"])
        {
            CATQuestionnaireInfo = q;
        }
        else if ([qName isEqualToString:@"mMRC"])
        {
            mMRCQuestionnaireInfo = q;
        }
        else if ([qName isEqualToString:@"Spirometry"])
        {
            SpiroResultsInfo = q;
        }
        else if ([qName isEqualToString:@"Exacerbations"])
        {
            ExacerbationsInfo = q;
        }
        else
        {
            NSLog(@"Unknown IQuestionnaire found: %@",[q getName]);
        }
    }
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
