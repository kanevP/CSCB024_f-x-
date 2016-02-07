//
//  DisplayTableViewController.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 2/5/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//
#import "DisplayTableViewController.h"
@interface DisplayTableViewController()

@property (weak, nonatomic) UITableViewCell *lastCell;

@end

@implementation DisplayTableViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:238.0/255.0 blue:217.0/255.0 alpha:1];

    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX([[OperationsManager sharedInstance] totalOperations], 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = [[OperationsManager sharedInstance] operationForIndex:indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:238.0/255.0 blue:217.0/255.0 alpha:1];
//    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:38];
    
    if ([[OperationsManager sharedInstance] totalOperations] < 3) {
        if (indexPath.row == 1) {
            self.lastCell = cell;
            cell.backgroundColor = cell.backgroundColor = [UIColor colorWithRed:124.0/255.0 green:201.0/255.0 blue:150.0/255.0 alpha:1];
        }
    }else{
        if (indexPath.row == [[OperationsManager sharedInstance] totalOperations] - 1) {
            self.lastCell = cell;
            cell.backgroundColor = cell.backgroundColor = [UIColor colorWithRed:124.0/255.0 green:201.0/255.0 blue:150.0/255.0 alpha:1];
        }
        
    }
    

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.view.bounds)/2;
}

#pragma mark - <OperationsManagerProtocol>

- (void)operationManagerDidFinalizeOperation
{
    [CATransaction begin];
    
    
    [CATransaction setCompletionBlock:^{
        // animation has finished
        NSInteger row = [self tableView:self.tableView numberOfRowsInSection:1] - 1;
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
    
    NSInteger row = [[OperationsManager sharedInstance] totalOperations] - 2;
    if (row > 1) {
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
    }else{
        [self.tableView reloadData];
    }
    
    [CATransaction commit];

}

- (void)oparationManagerDidUpdateOperation
{
    
    if (self.lastCell) {
        self.lastCell.textLabel.text = [[OperationsManager sharedInstance] currentOperation];

    }
}

@end
