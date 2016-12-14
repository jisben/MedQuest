//
//  CATDetailViewController.m
//  MedQuest
//
//  Created by Leo Chan on 11/2/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "CATDetailViewController.h"

@interface CATDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *zeroText;
@property (weak, nonatomic) IBOutlet UITextView *fiveText;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderChange:(id)sender;

@end

@implementation CATDetailViewController

@synthesize Question;

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
    
    appDelegate = [[UIApplication sharedApplication] delegate];
  
    id<IQuestion> question = [[appDelegate.CATQuestionnaireInfo getQuestions] objectAtIndex:[Question integerValue]];
    
    if (question) {
        self.zeroText.text = [[question getDetails] objectAtIndex:0];
        self.fiveText.text = [[question getDetails] objectAtIndex:1];
    }

    NSNumber *answer=[question getAnswer];
    
    if (answer)  {
        self.label.text=[answer stringValue];
        self.slider.value=[answer intValue];
    }

         
    // Rotate the slider -90 degrees
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI *-0.5);
    self.slider.transform = trans;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
        
    [[appDelegate CATQuestionnaireInfo] setAnswer:[[NSNumber alloc] initWithInteger:(int)self.slider.value] forQuestion:Question];
    
}

- (IBAction)sliderChange:(id)sender {
    int slideInt = (int)self.slider.value;
    NSString * slideString = [[NSString alloc] initWithFormat: @"%i", slideInt];
    self.label.text = slideString;
}
@end
