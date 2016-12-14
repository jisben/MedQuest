//
//  MedQuestDBObject.m
//  MedQuest
//
//  Created by Jis Ben on 11/1/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "MedQuestDBObject.h"
#import "Questionnaire.h"
#import "CATQuestionnaire.h"
#import "mMRCQuestionnaire.h"
#import "SpiroResults.h"
#import "Exacerbations.h"
#import "Question.h"

@implementation MedQuestDBObject

@synthesize databaseName, databasePath;

-(id) init
{
    self = [super init];
    if(self)
    {
        /*
         databaseName = @"MedQuestDB.sqlite";
         // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths =
            NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
         */
        databasePath = [[NSBundle mainBundle]pathForResource:@"MedQuestDB" ofType:@"sqlite"];
    }
    return self;
}

- (void) checkAndCreateDatabase
{
    
    // Use this FileManager object to move the database to the writable part
    // of the user's phone
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the SQL database has already been saved to the user's phone
    // if not, then copy it over
    if ([fileManager fileExistsAtPath:databasePath])
        return;
    
    // Get the path to the database that was bundled with this app
    NSString *databasePathFromApp =
        [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];

}

-(NSMutableArray *) readEmptyQuestionnairesFromDatabase
{
    // Setup the database object
    sqlite3 *database;
    NSMutableArray *questionnaires = [[NSMutableArray alloc] init];
    NSString *qName;
    id<IQuestionnaire> q;
    int qID;
    
    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL statement
        NSString *querySQL1 = [NSString stringWithFormat:@"SELECT * FROM Questionnaires"];
        const char *sqlStatement1 = [querySQL1 UTF8String];
        sqlite3_stmt *compiledStatement1;
        if (sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
        {
            // Loop through each row in the table of questionnaires
            while (sqlite3_step(compiledStatement1) == SQLITE_ROW)
            {
                qID = sqlite3_column_int(compiledStatement1, 0);
                qName = GET_STRING_OBJ_FROM_COLUMN(1, compiledStatement1);

                if ([qName isEqualToString:@"CAT"])
                {
                    q = [CATQuestionnaire createQuestionnaire:qName withId:[[NSNumber alloc] initWithInt:qID]];
                }
                else if ([qName isEqualToString:@"mMRC"])
                {
                    q = [mMRCQuestionnaire createQuestionnaire:qName withId:[[NSNumber alloc] initWithInt:qID]];
                }
                else if ([qName isEqualToString:@"Spirometry"])
                {
                    q = [SpiroResults createQuestionnaire:qName withId:[[NSNumber alloc] initWithInt:qID]];
                }
                else if ([qName isEqualToString:@"Exacerbations"])
                {
                    q = [Exacerbations createQuestionnaire:qName withId:[[NSNumber alloc] initWithInt:qID]];
                }
                else
                {
                    break;
                }
                
                NSString *querySQL2 = [NSString stringWithFormat:
                                       @"SELECT * FROM Questions WHERE QuestionnaireID=\"%d\" ORDER BY QuestionNumber ASC", qID];
                const char *sqlStatement2 = [querySQL2 UTF8String];
                sqlite3_stmt *compiledStatement2;
                
                // Get all questions that correspond to this questionnaire
                if (sqlite3_prepare_v2(database, sqlStatement2, -1, &compiledStatement2, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(compiledStatement2) == SQLITE_ROW)
                    {
                        NSInteger questionID = sqlite3_column_int(compiledStatement2, 0);
                        NSString *question = GET_STRING_OBJ_FROM_COLUMN(3, compiledStatement2);
                        NSString *detailString = GET_STRING_OBJ_FROM_COLUMN(4, compiledStatement2);
                        NSArray *detailArray = detailString? [detailString componentsSeparatedByString: @"|"] : nil;
                        [q addQuestion:[Question createQuestion:question withDetails:detailArray withId:[[NSNumber alloc] initWithInt:questionID]]];
                    }
                }

                // Add this questionnaire to the array
                [questionnaires addObject:q];
                // Release the compiled statement from memory
                sqlite3_finalize(compiledStatement2);
            }
        }
        // Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);
    }
    // Close the database connection
    sqlite3_close(database);
    // Return the array of patients
    return questionnaires;

}

-(NSMutableArray*) readPatientsFromDatabase
{
    // Setup the database object
    sqlite3 *database;
    NSMutableArray *patients = [[NSMutableArray alloc] init];
    
    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        //Setup the SQL statement and compile it for faster access
        const char *sqlStatement = "SELECT * FROM Patients";
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through rows in the table
            while (sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                // Retrieve individual columns from the database row
                int patientID = sqlite3_column_int(compiledStatement, 0);
                NSString *aName = GET_STRING_OBJ_FROM_COLUMN(1, compiledStatement);
                NSString *aDOB = GET_STRING_OBJ_FROM_COLUMN(2, compiledStatement);
				NSString *aEmail = GET_STRING_OBJ_FROM_COLUMN(3, compiledStatement);
				NSString *aAddress = GET_STRING_OBJ_FROM_COLUMN(4, compiledStatement);
                NSString *aPhoneNumber = GET_STRING_OBJ_FROM_COLUMN(5, compiledStatement);
                // Create a new patient object to hold the data
                Patient *patient = [[Patient alloc] initWithName:aName PatientID:patientID
                                                     DateOfBirth:aDOB Email:aEmail Address:aAddress
                                                     PhoneNumber:aPhoneNumber];
                // Add the new patient to the array
                [patients addObject:patient];
            }
        }
        // Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
    }
    // Close the database connection
    sqlite3_close(database);
    // Return the array of patients
    return patients;
}

-(NSMutableArray *) readPatientsFromDatabaseWithName:(NSString *)name
{
    // Setup the database object
    sqlite3 *database;
    NSMutableArray *patients = [[NSMutableArray alloc] init];

    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL statement
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT * FROM Patients WHERE PatientName=\"%@\"",
                              name];
        const char *sqlStatement = [querySQL UTF8String];
        sqlite3_stmt *compiledStatement;
        if (sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            // Loop through rows in the table
            while (sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                // Retrieve individual columns from the database row
                int patientID = sqlite3_column_int(compiledStatement, 0);
                NSString *aName = GET_STRING_OBJ_FROM_COLUMN(1, compiledStatement);
                NSString *aDOB = GET_STRING_OBJ_FROM_COLUMN(2, compiledStatement);
				NSString *aEmail = GET_STRING_OBJ_FROM_COLUMN(3, compiledStatement);
				NSString *aAddress = GET_STRING_OBJ_FROM_COLUMN(4, compiledStatement);
                NSString *aPhoneNumber = GET_STRING_OBJ_FROM_COLUMN(5, compiledStatement);
                // Create a new patient object to hold the data
                Patient *patient = [[Patient alloc] initWithName:aName PatientID:patientID
                                                     DateOfBirth:aDOB Email:aEmail Address:aAddress
                                                     PhoneNumber:aPhoneNumber];
                // Add the new patient to the array
                [patients addObject:patient];
            }
        }
        // Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
    }
    // Close the database connection
    sqlite3_close(database);
    // Return the array of patients
    return patients;
}

-(NSMutableArray *) readAnsweredQuestionnairesFromDatabaseForPatientWithID:(int)pID
{
    // Setup the database object
    sqlite3 *database;
    NSMutableArray *questionnaires = [[NSMutableArray alloc] init];
    
    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL statement
        NSString *querySQL1 = [NSString stringWithFormat:
                               @"SELECT * FROM AnsweredQuestionnaires WHERE PatientID=\"%d\"", pID];
        const char *sqlStatement1 = [querySQL1 UTF8String];
        sqlite3_stmt *compiledStatement1;
        if (sqlite3_prepare_v2(database, sqlStatement1, -1, &compiledStatement1, NULL) == SQLITE_OK)
        {
            // Loop through the table of questionnaires
            while (sqlite3_step(compiledStatement1) == SQLITE_ROW)
            {
                int qID = sqlite3_column_int(compiledStatement1, 0);
//                NSString *qName = GET_STRING_OBJ_FROM_COLUMN(3, compiledStatement1);
                id<IQuestionnaire> q = [[Questionnaire alloc] init];

                //TODO Jis you need to add code here that decides which type of questionnaire to load and then calls the factory method
                // see the iQuestionnaire interface

                NSString *querySQL2 = [NSString stringWithFormat:
                                       @"SELECT * FROM AnsweredQuestions WHERE QuestionnaireID=\"%d\" ORDER BY QuestionNumber ASC", qID];
                const char *sqlStatement2 = [querySQL2 UTF8String];
                sqlite3_stmt *compiledStatement2;

                // Get all questions that correspond to this questionnaire
                if (sqlite3_prepare_v2(database, sqlStatement2, -1, &compiledStatement2, NULL) == SQLITE_OK)
                {
                    while (sqlite3_step(compiledStatement2) == SQLITE_ROW)
                    {
                        //TODO Jis do we actually want to fill in the answers? Or just the questions?
                        //you also should use the factory method to create the id<IQuestion> (see interface)
                        id<IQuestion> question = GET_STRING_OBJ_FROM_COLUMN(3, compiledStatement2);
                        NSInteger answer = sqlite3_column_int(compiledStatement2, 4);
                        [q addQuestion:question];
                        [q setAnswer:[[NSNumber alloc]initWithInteger:answer] forQuestion:[question getId]];
                    }
                }
  
                // Add this questionnaire to the array
                [questionnaires addObject:q];
                // Release the compiled statement from memory
                sqlite3_finalize(compiledStatement2);
            }
        }
        // Release the compiled statement from memory
		sqlite3_finalize(compiledStatement1);
    }
    // Close the database connection
    sqlite3_close(database);
    // Return the array of patients
    return questionnaires;
}

-(int) addPatientToDatabaseWithName:(NSString *)name DOB:(NSString *)dob Email:(NSString *)email Address:(NSString *)addr PhoneNumber:(NSString *)phone
{
    // Setup the database object
    sqlite3 *database;
    int patientID = -1;
    
    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Set up the SQL query to insert a new Patient
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Patients (PatientName, DOB, EmailAddress, PhysicalAddress, PhoneNumber) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", name, dob, email, addr, phone];
        const char *insSqlStatement = [insertSQL UTF8String];
        sqlite3_stmt *insCompiledStatement;
        if (sqlite3_prepare_v2(database, insSqlStatement, -1, &insCompiledStatement, NULL) == SQLITE_OK && sqlite3_step(insCompiledStatement) == SQLITE_DONE)
        {
            // Now read the patient ID that was generated
            NSString *selectSQL = [NSString stringWithFormat:
                                   @"SELECT PatientID FROM Patients WHERE PatientName=\"%@\" AND DOB=\"%@\" AND EmailAddress=\"%@\" AND PhysicalAddress=\"%@\" AND PhoneNumber=\"%@\"", name, dob, email, addr, phone];
            const char *selSqlStatement = [selectSQL UTF8String];
            sqlite3_stmt *selCompiledStatement;
            if (sqlite3_prepare_v2(database, selSqlStatement, -1, &selCompiledStatement, NULL) == SQLITE_OK && sqlite3_step(selCompiledStatement) == SQLITE_ROW)
            {
                patientID = sqlite3_column_int(selCompiledStatement, 0);
            }
            sqlite3_finalize(selCompiledStatement);
        }
        sqlite3_finalize(insCompiledStatement);
    }
    sqlite3_close(database);
    return patientID;
}

-(int) addToDatabaseForPatientWithID:(int)pID aQuestionnaire:(id<IQuestionnaire>)q
{
    // Setup the database object
    sqlite3 *database;
    int questionnaireID = -1;
    int count = 1;
    
    // Open the database from the users filesystem (possibly Documents folder)
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO AnsweredQuestionnaires (PatientID, QuestionnaireName, DateAnswered) VALUES (\"%d\", \"%@\", \"%@\")", pID, [q getName], [q getDateAnsweredAsString]];
        const char *insSqlStatement = [insertSQL UTF8String];
        sqlite3_stmt *insCompiledStatement;
        if (sqlite3_prepare_v2(database, insSqlStatement, -1, &insCompiledStatement, NULL) == SQLITE_OK && sqlite3_step(insCompiledStatement) == SQLITE_DONE)
        {
            // Get the auto-generated ID for the questionnaire we just inserted
            NSString *selectSQL = [NSString stringWithFormat:
                                   @"SELECT QuestionnaireID FROM AnsweredQuestionnaires WHERE PatientID=\"%d\" AND QuestionnaireName=\"%@\" AND DateAnswered=\"%@\"", pID, [q getName], [q getDateAnsweredAsString]];
            const char *selSqlStatement = [selectSQL UTF8String];
            sqlite3_stmt *selCompiledStatement;
            if (sqlite3_prepare_v2(database, selSqlStatement, -1, &selCompiledStatement, NULL) == SQLITE_OK && sqlite3_step(selCompiledStatement) == SQLITE_ROW)
            {
                questionnaireID = sqlite3_column_int(selCompiledStatement, 0);
                
                // Now insert individual questions from the questionnaire into the DB
                for (id<IQuestion> question in [q getQuestions])
                {
                    NSString *qInsertSQL = [NSString stringWithFormat: @"INSERT INTO AnsweredQuestions (QuestionnaireID, QuestionNumber, Question, Answer) VALUES (\"%d\", \"%d\", \"%@\", \"%d\")", questionnaireID, count, question, [q getAnswer:[question getId]].intValue];
                    const char *qInsSqlStatement = [qInsertSQL UTF8String];
                    sqlite3_stmt *qInsCompiledStatement;
                    if (sqlite3_prepare_v2(database, qInsSqlStatement, -1, &qInsCompiledStatement, NULL) == SQLITE_OK && sqlite3_step(qInsCompiledStatement) == SQLITE_DONE)
                    {
                        count++;
                    }
                    else
                    {
                        sqlite3_finalize(qInsCompiledStatement);
                        sqlite3_finalize(selCompiledStatement);
                        sqlite3_finalize(insCompiledStatement);
                        sqlite3_close(database);
                        return (-1);
                    }
                    sqlite3_finalize(qInsCompiledStatement);
                }
            }
            sqlite3_finalize(selCompiledStatement);
        }
        sqlite3_finalize(insCompiledStatement);
    }
    sqlite3_close(database);
    return questionnaireID;
}


@end
