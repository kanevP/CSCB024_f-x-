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

@interface CalculatorViewController ()<ButtonsPadDelegate>

@property (strong, nonatomic) UILabel *outputLabel;
@property (strong, nonatomic) UILabel *inputLabel;
@property (strong, nonatomic) ButtonsPad *buttonsPad;

@property (strong, nonatomic) CalculatorController *calculatorController;

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.layer.contents = (id)[UIImage imageNamed:@"calcu-proj"].CGImage;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //adding subviews
    [self.view addSubview:self.buttonsPad];
    [self.view addSubview:self.outputLabel];
    [self.view addSubview:self.inputLabel];
    // Do any additional setup after loading the view, typically from a nib.
}

//layouts the subviews
- (void)updateViewConstraints
{
    [self.outputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(@80);
        make.top.equalTo(self.view.mas_top).with.offset(80);
    }];
    
    [self.inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view.mas_leading);
        make.trailing.equalTo(self.view.mas_trailing);
        make.height.equalTo(@80);
        make.top.equalTo(self.outputLabel.mas_bottom).with.offset(0);
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
- (UILabel *)inputLabel
{
    if (!_inputLabel) {
        _inputLabel = [UILabel new];
//        _inputLabel.backgroundColor = [UIColor colorWithRed:225.0/255.0 green:249.0/255.0 blue:229.0/255.0 alpha:1];
        _inputLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];

    }
    return _inputLabel;
}

- (UILabel *)outputLabel
{
    if (!_outputLabel) {
        _outputLabel = [UILabel new];
//        _outputLabel.backgroundColor = [UIColor colorWithRed:163.0/255.0 green:225.0/255.0 blue:170.0/255.0 alpha:1];
        _outputLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
    }
    return _outputLabel;
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
        _calculatorController = [[CalculatorController alloc] initWithInputLabels:self.inputLabel andOutPutLabel:self.outputLabel];
    }
    return _calculatorController;
}


#pragma mark - ButtonsPadDelegate
- (void)buttonTapped:(UIButton *)button
{
    
}

@end
