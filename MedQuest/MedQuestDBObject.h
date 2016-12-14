//
//  MedQuestDBObject.h
//  MedQuest
//
//  Created by Jis Ben on 11/1/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h> // Import the SQLite database framework
#import "Patient.h"
#import "IQuestionnaire.h"

@interface MedQuestDBObject : NSObject {
    
}


@property (nonatomic, assign) NSString *databaseName;
@property (nonatomic, assign) NSString *databasePath;

#define GET_STRING_OBJ_FROM_COLUMN(_idx, _sql_compiled_statement)  \
    ((char *)sqlite3_column_text(_sql_compiled_statement, _idx)) ? [NSString stringWithUTF8String:(char *)sqlite3_column_text(_sql_compiled_statement, _idx)] : nil;

// Check to the see if the database has already been copied over to
// the user's Documents directory. If not, then copy it over.
// Otherwise, we won't be able to write to the database
// ***** This may only be applicable if we run the phone on an actual phone *****
-(void) checkAndCreateDatabase;


/* General Data */

// Use this method to populate your views with new questionnaires
-(NSMutableArray *) readEmptyQuestionnairesFromDatabase;

// Use this method to add new empty questionnaires to the database
// -(void) addEmptyQuestionnaireToDatabase;



/* Patient Specific Data - Getters */

// Returns an array of all the patients stored in the database
-(NSMutableArray *) readPatientsFromDatabase;

// Returns an array of all patients in the database with the given name
-(NSMutableArray *) readPatientsFromDatabaseWithName:(NSString *)name;

// Returns all of the given patient's answered questionnaires
-(NSMutableArray *) readAnsweredQuestionnairesFromDatabaseForPatientWithID:(int)pID;

// Returns all of the given patient's test results
// -(NSMutableArray *) readTestResultsFromDatabaseForPatientWithID:(int)pID;

// Returns a history of classifications for the given patient
// -(NSMutableArray *) readClassificationsFromDatabaseForPatientWithID:(int)pID;

// Returns the most recent classification for a given patient
// -(Classification *) readLatestClassificationFromDatabaseForPatientWithID:(int)pID;



/* Patient Specific Data - Setters */

// Use this method to add a new Patient to the database
// Returns the new patient's auto-generated ID if the operation was successful
// Otherwise returns -1
-(int) addPatientToDatabaseWithName:(NSString *)name DOB:(NSString *)dob
                        Email:(NSString *)email Address:(NSString *)addr
                        PhoneNumber:(NSString *)phone;

// Use this method to add an answered questionnaire to the database
// Returns -1 if the access failed - This could be due to
// a key constraint check failure because of an invalid patientID
-(int) addToDatabaseForPatientWithID:(int)pID aQuestionnaire:(id<IQuestionnaire>)q;

// Use this method to add a test result to the database
// -(void) addToDatabaseForPatientWithID:(int)pID aTestResult:(TestResult *)t;

// Use this method to add a new classification to the database
// -(void) addToDatabaseForPatientWithID:(int)pID aClassification:(Classification *)c;


@end
