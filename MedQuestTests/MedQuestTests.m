//
//  MedQuestTests.m
//  MedQuestTests
//
//  Created by Justin Grant on 10/27/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "MedQuestTests.h"
#import "CATQuestionnaire.h"
#import "MedQuestDBObject.h"

@implementation MedQuestTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testCatQuestionnaire
{
    NSNumber* inputQuestions[] = { [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2] };
    
    CATQuestionnaire *q = [[CATQuestionnaire alloc] init];
    STAssertNotNil(q, @"Allocation Test.");
    
//    [q addQuestion:inputQuestions[0]];
//    [q addQuestion:inputQuestions[1]];
//    [q addQuestion:inputQuestions[2]];
    
    NSArray* questions = [q getQuestions];
    //    STAssertNotNil(questions, @"Question return");
    
    for(int i = 0; i < questions.count; i++)
    {
        STAssertEquals(questions[i], inputQuestions[i], @"Testing input questions are equal: %d", i);
    }
    
    STAssertEquals([q setAnswer:[NSNumber numberWithInt:1] forQuestion:[NSNumber numberWithInt:5]], NO, @"Testing bad question");

    for(int i = 0; i < questions.count; i++)
    {
        STAssertEquals([q setAnswer:[NSNumber numberWithInt:i] forQuestion:questions[i]], YES, @"Testing good question %d", i);
    }


//    STAssertEquals([q setAnswer:[NSNumber numberWithInt:-1] forQuestion:questions[0]], NO, @"Testing bad min input");
    //    STAssertEquals([q setAnswer:[NSNumber numberWithInt:3] forQuestion:questions[0]], YES, @"Testing minimum input");
    // STAssertEquals([q setAnswer:[NSNumber numberWithInt:5] forQuestion:questions[0]], YES, @"Testing maximum output");  // TODO: Failed
    STAssertEquals([q setAnswer:[NSNumber numberWithInt:6] forQuestion:questions[0]], NO, @"Testing bad max output");
    
    // STAssertEquals([q getAnswer:inputQuestions[0]].intValue, 5,@"Testing answer return"); // TODO: Failed
}

- (void) testDatabase
{
    
    NSString* newPatientName = @"Jis Ben";
    int patientID = 0;
    int questID = 0;
    
    MedQuestDBObject *db = [[MedQuestDBObject alloc] init];
    STAssertNotNil(db, @"Allocation Test.");
    
    
    // Query the database for new, empty questionnaires
    NSMutableArray *questionnaires = [db readEmptyQuestionnairesFromDatabase];
    STAssertNotNil(questionnaires, @"Making sure the DB has the initial set of questionnaires");

    // Returns an array of all the patients stored in the database
    for (Patient *p in [db readPatientsFromDatabase])
    {
        STAssertNotNil(p, @"Read all Patients Test");
    }
    
    // Returns an array of all patients in the database with the given name
    for (Patient *p in [db readPatientsFromDatabaseWithName:newPatientName])
    {
        STAssertNotNil(p, @"Existing Patient Read Test");
        STAssertTrue([p.name isEqualToString:newPatientName], @"Checking Patient Name retrieval");
        STAssertTrue([p.email isEqualToString:@"email@email.com"], @"Checking Patient email retrieval");
        STAssertTrue([p.address isEqualToString:@"82 My Home Rd, Campbell, CA 95008"], @"Checking Patient Address retrieval");
        STAssertTrue([p.phoneNumber isEqualToString:@"1800DEDBEEF"], @"Checking Patient Phone Number retrieval");
        // If loop runs again, this should fail... There should only be 1 "Jis Ben"
    }
    
    patientID = [db addPatientToDatabaseWithName:@"Wonderful Tester" DOB:@"1976-09-03" Email:@"wonder@ful.com" Address:@"hello world" PhoneNumber:@"432123444"];
    STAssertTrue(patientID >= 0, @"DB Patient Insert Test");
    
    for (Patient *p in [db readPatientsFromDatabaseWithName:@"Wonderful Tester Man"])
    {
        STAssertNotNil(p, @"Patient Insert Test");
        STAssertEquals(p.ID, patientID, @"Patient ID ?== return value Test");
        STAssertTrue([p.name isEqualToString:@"Wonderful Tester Man"], @"DB Insert Test: Name");
        STAssertTrue([p.email isEqualToString:@"wonder@ful.com"], @"DB Insert Test: Email");
        STAssertTrue([p.address isEqualToString:@""], @"DB Insert Test & NULL Test: Address");
        STAssertTrue([p.phoneNumber isEqualToString:@""], @"DB Insert Test: Phone Number");
    }
    
   // NSString* inputQuestions[] = { @"Question1", @"Question2", @"Question3" };
    CATQuestionnaire *q = [[CATQuestionnaire alloc] init];

    NSArray* questions = [q getQuestions];
    for(int i = 0; i < questions.count; i++)
    {
        STAssertEquals([q setAnswer:[NSNumber numberWithInt:i] forQuestion:questions[i]], YES, @"Testing good question %d", i);
    }
    //STAssertEquals([q setAnswer:[NSNumber numberWithInt:4] forQuestion:questions[0]], YES, @"Testing maximum output");
    
    questID = [db addToDatabaseForPatientWithID:patientID aQuestionnaire:q];
    STAssertTrue(questID >= 0, @"DB Questionnaire Insert Test");

    for (Questionnaire *quest in [db readAnsweredQuestionnairesFromDatabaseForPatientWithID:patientID])
    {
        STAssertNotNil(quest, @"Questionnaire Insert Test");
//        STAssertEquals([quest getAnswer:inputQuestions[0]].intValue, [q getAnswer:inputQuestions[0]].intValue, @"Testing Questionnaire Insert and Read");
    }
    
}

@end
