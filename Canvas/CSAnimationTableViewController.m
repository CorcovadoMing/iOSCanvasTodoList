//
//  CSAnimationTableViewController.m
//  Canvas
//
//  Created by Jamz Tang on 1/12/13.
//  Copyright (c) 2013 Canvas. All rights reserved.
//

#import "CSAnimationTableViewController.h"
#import "CSAnimationView.h"
#import "CSSectionHeaderCell.h"

@implementation CSAnimationTableViewController

- (void)loadInitialData {
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *sectionHeaderNib = [UINib nibWithNibName:@"CSSectionHeaderCell" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forCellReuseIdentifier:self.sectionHeaderCellIdentifier];
    self.toDoItems = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

#pragma mark UITableViewDelegate


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view startCanvasAnimation];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.toDoItems count];
}

- (CSSectionHeaderCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSSectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:self.sectionHeaderCellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    CSSectionHeaderCell *toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem.itemName;
    
    /*
    if (toDoItem.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CSSectionHeaderCell *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    tappedItem.completed = !tappedItem.completed;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


- (IBAction)addItems:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Add a item"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Add", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        CSSectionHeaderCell *item = [[CSSectionHeaderCell alloc] init];
        item.itemName = [[alertView textFieldAtIndex:0] text];
        [self.toDoItems addObject:item];
        [((UITableView *) self.tableView) reloadData];
    }
}

@end

#pragma mark - 

@implementation CSAnimationContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"icon-animations-active"];
    self.tabBarItem.image = [UIImage imageNamed:@"icon-animations"];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end