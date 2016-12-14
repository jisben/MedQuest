//
//  CATTableViewController.m
//  MedQuest
//
//  Created by Leo Chan on 10/29/12.
//  Copyright (c) 2012 TeamIota. All rights reserved.
//

#import "CATTableViewController.h"


@interface CATTableViewController ()


@end

@implementation CATTableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    /*
     if(section == 0)
     {
     return @"Detected Hardware";
     }
     else
     {
     return @"ERROR!";
     }
     */
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CATCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
   
    id<IQuestion> question = [[appDelegate.CATQuestionnaireInfo getQuestions] objectAtIndex:indexPath.row];
    cell.textLabel.text = [question getTitle];
    
    NSNumber* AInt = [question getAnswer];
    if(AInt)
    {
        cell.detailTextLabel.text = [AInt stringValue];
    }
    else
    {
        cell.detailTextLabel.text = @"-";
    }

    return cell;
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
    return [appDelegate.CATQuestionnaireInfo getQuestions].count;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showCATDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        CATDetailViewController *detailViewController = [segue destinationViewController];

        detailViewController.Question = [[NSNumber alloc]initWithInteger:indexPath.row];
    }
}

@end
