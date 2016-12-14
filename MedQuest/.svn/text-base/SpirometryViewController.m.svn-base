//
//  SpirometryViewController.m
//  MedQuest
//
//  Created by Leo Chan on 11/4/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "SpirometryViewController.h"

@interface SpirometryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *FEV1FVCTextField;
@property (weak, nonatomic) IBOutlet UITextField *FEV1PredTextField;
@end


@implementation SpirometryViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSNumber *tempNum;
    NSString *tempStr;
    
    appDelegate = [[UIApplication sharedApplication] delegate];
//    NSArray* Questions = [appDelegate.SpiroResultsInfo getQuestions];
//    FEV1FVCStr = Questions[0];
//    FEV1PredStr = Questions[1];
    
    tempNum = [appDelegate.SpiroResultsInfo getAnswer:[[NSNumber alloc] initWithInt:0]];
    if (tempNum) {
        tempStr = [[NSString alloc]initWithFormat:@"%i", [tempNum intValue]];
        self.FEV1FVCTextField.text = tempStr;
        tempStr = nil;
    }
    
    tempNum = [appDelegate.SpiroResultsInfo getAnswer:[[NSNumber alloc] initWithInt:1]];
    if (tempNum) {
        tempStr = [[NSString alloc]initWithFormat:@"%i", [tempNum intValue]];
        self.FEV1PredTextField.text=tempStr;
        tempStr = nil;
    }
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
//    NSArray* Questions = [appDelegate.SpiroResultsInfo getQuestions];
    
    NSNumber *tempNum;
    
    // save FEV1/FVC
    tempNum = [numFormatter numberFromString: self.FEV1FVCTextField.text];
    if (tempNum)
    {
        [appDelegate.SpiroResultsInfo setAnswer:tempNum forQuestion:[[NSNumber alloc] initWithInt:0]];
    }
    
    // save FEV1 Predicted
    tempNum = [numFormatter numberFromString: self.FEV1PredTextField.text];
    if(tempNum)
    {
        [appDelegate.SpiroResultsInfo setAnswer:tempNum forQuestion:[[NSNumber alloc] initWithInt:1]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Use this code to dismiss a Number Pad when the user touches the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.FEV1FVCTextField resignFirstResponder];
    [self.FEV1PredTextField resignFirstResponder];
}

@end
