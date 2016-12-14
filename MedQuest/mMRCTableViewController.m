//
//  mMRCTableViewController.m
//  MedQuest
//
//  Created by Leo Chan on 11/3/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "mMRCTableViewController.h"

@interface mMRCTableViewController ()

@end

@implementation mMRCTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    int i, nRows;
    NSNumber* zero=0;
    UITableViewCell *cell;
//    NSArray* Questions = [appDelegate.mMRCQuestionnaireInfo getQuestions];
    nRows = [self.tableView numberOfRowsInSection:0];
    
    for (i=0; i< nRows; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        NSNumber *qNum = [[NSNumber alloc]initWithInt:i];
        cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        NSString *Question = [Questions objectAtIndex:i];
        // set answer of unchecked question to zero.
        if (cell.accessoryType == UITableViewCellAccessoryNone)
            [appDelegate.mMRCQuestionnaireInfo setAnswer:zero forQuestion:qNum];
        // set answer of checked question to the row number
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            [appDelegate.mMRCQuestionnaireInfo setAnswer:[[NSNumber alloc] initWithInt: i] forQuestion:qNum];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
     return [appDelegate.mMRCQuestionnaireInfo getQuestions].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mMRCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell to be consistent with data
    id<IQuestion> question = [[appDelegate.mMRCQuestionnaireInfo getQuestions] objectAtIndex:indexPath.row];
    cell.textLabel.text = [question getTitle];
    
    NSNumber* AInt = [question getAnswer];
    
    
 //   NSNumber* qNum = [[NSNumber alloc]initWithInteger:indexPath.row];
    
 //   NSNumber* AInt = [appDelegate.mMRCQuestionnaireInfo getAnswer:qNum];
    
    if(AInt)
    {
        if([AInt intValue] > 0)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSIndexPath *oldIndexPath;
    
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
    if (oldCell!=newCell) {
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
            oldIndexPath=indexPath;
    }

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{   // adjust height of row based on the length of question string.
    // method could be improved... but needs research
    CGFloat heightForRow;

    id<IQuestion> question = [[appDelegate.mMRCQuestionnaireInfo getQuestions] objectAtIndex:indexPath.row];
    
    NSString* textStr = [question getTitle];
    heightForRow = 0.7*textStr.length+20;

    return heightForRow;
}

@end
