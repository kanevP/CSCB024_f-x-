//
//  ViewController.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 10/18/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import <Masonry.h>
#import "CalculatorViewController.h"
#import "ButtonsPad.h"
#import "FunctionInputView.h"
#import "CalculatorController.h"
#import "DisplayTableViewController.h"

#define TABLEVIEW_HEIGHT 200

@interface CalculatorViewController ()

@property (strong, nonatomic) UIView *tableViewContainer;
@property (strong, nonatomic) DisplayTableViewController *childViewController;

@property (strong, nonatomic) ButtonsPad *buttonsPad;
@property (strong, nonatomic) CalculatorController *calculatorController;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.layer.contents = (id)[UIImage imageNamed:@"calcu-proj"].CGImage;
    self.view.layer.contents = (id)[UIImage imageNamed:@"bgr"].CGImage;
    
    //adding subviews
    [self.view addSubview:self.buttonsPad];
    [self.view addSubview:self.tableViewContainer];

    // Do any additional setup after loading the view, typically from a nib.
}

//layouts the subviews
- (void)updateViewConstraints
{
    [self.tableViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top).with.offset(64);
        make.height.equalTo(@(TABLEVIEW_HEIGHT));
    }];
    
    [self.buttonsPad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.leading.equalTo(self.view.mas_leading).with.offset(10);
        make.trailing.equalTo(self.view.mas_trailing).with.offset(-10);
        make.height.equalTo(@330);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - Property Accessors
- (UIView *)tableViewContainer
{
    if (!_tableViewContainer) {
        _tableViewContainer = [UIView new];
        
        //adding dispalyTVC as a child VC
        [self addChildViewController:self.childViewController];
        [_tableViewContainer addSubview:self.childViewController.view];
        self.childViewController.view.frame = _tableViewContainer.bounds;
        [self.childViewController didMoveToParentViewController:self];
    }
    return _tableViewContainer;
}

- (DisplayTableViewController *)childViewController
{
    if (!_childViewController) {
        _childViewController = [DisplayTableViewController new];
        [OperationsManager sharedInstance].delegate = _childViewController;
    }
    
    return _childViewController;
}
- (ButtonsPad *)buttonsPad
{
    if (!_buttonsPad) {
        _buttonsPad = [[ButtonsPad alloc] initWithDelegate:self.calculatorController];
//        _buttonsPad.delegate = self.calculatorController;
    }
    return _buttonsPad;
}

- (CalculatorController *)calculatorController
{
    if (!_calculatorController) {
        _calculatorController = [[CalculatorController alloc] initWithInputLabels:nil
                                                                   andOutPutLabel:nil];
    }
    return _calculatorController;
}


#pragma mark - ButtonsPadDelegate
- (void)buttonTapped:(UIButton *)button
{
    
}

@end
