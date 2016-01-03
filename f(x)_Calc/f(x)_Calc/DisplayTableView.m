//
//  DisplayTableView.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 1/3/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//

#import "DisplayTableView.h"
#import "DisplayTableViewCell.h"
#import "CalculatorController.h"

@interface DisplayTableView()

@property (weak, nonatomic) CalculatorController *calculationController;

@end

@implementation DisplayTableView 

- (instancetype)initWithConroller:(CalculatorController *)controller
{
    if (self = [super init]) {
        
        self.calculationController = controller;
        self.allowsSelection = NO;
        self.bounces = NO;
        
        [self registerClass:[DisplayTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DisplayTableViewCell class])];
        
    }
    return self;
}

- (NSMutableArray *)operationStrings
{
    if (!_operationStrings) {
        _operationStrings = [NSMutableArray new];
    }
    return _operationStrings;
}

#pragma mark - <UITableViewDelelgate>

- (NSInteger)numberOfSections
{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayTableViewCell *cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass([DisplayTableViewCell class])];
    
    if ([self.operationStrings count]) {
        cell.textLabel.text = self.operationStrings[indexPath.row];
    }
    
    if (self.calculationController)
    {
        if (indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1) {
            self.calculationController.inputLabel = cell.textLabel;
        }else if (indexPath.row == [self numberOfRowsInSection:indexPath.section] - 2) {
            self.calculationController.outputLabel = cell.textLabel;
        }
    }
    
    return cell;
}

#pragma mark - <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGRectGetHeight(self.frame);
}


- (void)scrollViewDidEndDecelerating:(UITableView *)tableView
{
    CGFloat cellHeight = CGRectGetHeight(self.frame);
    
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint: CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y+cellHeight)];
    
    NSInteger contentOffset = (long)(tableView.contentOffset.y)%(long)(cellHeight);
    
    if (contentOffset > cellHeight/2 - 5) {
        indexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
    }
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
