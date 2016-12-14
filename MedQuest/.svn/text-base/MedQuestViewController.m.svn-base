//
//  MedQuestViewController.m
//  MedQuest
//
//  Created by Justin Grant on 10/27/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "MedQuestViewController.h"

@interface MedQuestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *CATScore;
@property (weak, nonatomic) IBOutlet UILabel *mMRCScore;
@property (weak, nonatomic) IBOutlet UILabel *SpiroScore;
@property (weak, nonatomic) IBOutlet UILabel *ExacLabel;
@property (weak, nonatomic) IBOutlet UIStepper *ExacStepper;
- (IBAction)ExacStepperChange:(id)sender;
- (IBAction)Classify:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ClassifyButton;
@property (weak, nonatomic) IBOutlet UILabel *Classification;
- (IBAction)NewPatient:(id)sender;

@end

@implementation MedQuestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 & indexPath.row ==3)
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section==1 & indexPath.row ==0)
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MedQuestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // update text fields with scores
    NSNumber* CATscore = [appDelegate.CATQuestionnaireInfo getScore];
    
    if(CATscore != nil)
        self.CATScore.text = [CATscore stringValue];
    else
        self.CATScore.text = @"-";

    NSNumber* mMRCscore = [appDelegate.mMRCQuestionnaireInfo getScore];
    
    if(mMRCscore != nil)
        self.mMRCScore.text = [mMRCscore stringValue];
    else
        self.mMRCScore.text = @"-";
    
    NSNumber* SpiroScore = [appDelegate.SpiroResultsInfo getScore];
    
    if(SpiroScore != nil)
        self.SpiroScore.text = [SpiroScore stringValue];
    else
        self.SpiroScore.text = @"-";
    
    NSNumber* ExacerbationsScore = [appDelegate.ExacerbationsInfo getScore];
    
    if(ExacerbationsScore != nil)
        self.ExacLabel.text = [ExacerbationsScore stringValue];
    else
        self.ExacLabel.text = @"-";
   
    
    if((SpiroScore!=nil) & ((CATscore!=nil || mMRCscore!=nil)))
        self.ClassifyButton.enabled = YES;
    else
        self.ClassifyButton.enabled = NO;
    
    self.Classification.text = @"-";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ExacStepperChange:(id)sender {
    NSNumber *tempNum = [[NSNumber alloc]initWithInteger:(int)self.ExacStepper.value];
    NSString *stepperStr = [[NSString alloc]initWithFormat:@"%i", [tempNum intValue]];
    self.ExacLabel.text= stepperStr;
    
    MedQuestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.ExacerbationsInfo setAnswer:tempNum forQuestion:[[NSNumber alloc] initWithInt:0]];
    
    self.Classification.text = @"-";
}

- (IBAction)Classify:(id)sender {

    Classification *classifier = [[Classification alloc]init];
    
    self.Classification.text = [classifier getClassification];
    
}
- (IBAction)NewPatient:(id)sender {
     MedQuestAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.CATQuestionnaireInfo clearAnswers];
    [appDelegate.mMRCQuestionnaireInfo clearAnswers];
    [appDelegate.SpiroResultsInfo clearAnswers];
    [appDelegate.ExacerbationsInfo clearAnswers];
    self.ExacStepper.value=0;
    self.ExacLabel.text= @"-";
    [self viewWillAppear:NO];
}
@end
