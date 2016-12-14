//
//  Patient.m
//  MedQuest
//
//  Created by Jis Ben on 11/4/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "Patient.h"

@implementation Patient

@synthesize ID, name, DOB, email, address, phoneNumber;

-(id)initWithName:(NSString *)aName PatientID:(int)pID DateOfBirth:(NSString *)dob Email:(NSString *)anEmail Address:(NSString *)anAddr PhoneNumber:(NSString *)aPhone
{
    self = [super init];
    if(self)
    {
        self.ID = pID;
        self.name = aName;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.DOB = [dateFormat dateFromString:dob];
        self.email = anEmail;
        self.address = anAddr;
        self.phoneNumber = aPhone;
    }
	return self;
}



@end
