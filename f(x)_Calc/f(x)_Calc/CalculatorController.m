//
//  CalculatorController.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/22/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import "CalculatorController.h"
#import "OperationsManager.h"

#define POSITIVE_MULTIPLICATOR 10
#define NEGATIVE_MULTIPLICATOR 0.1

@interface CalculatorController()

@property (strong, nonatomic) NSNumberFormatter *formatter;

@property (nonatomic) double currentNumber;
@property (nonatomic) double storedNumber;
@property (nonatomic) double outputNumber;
@property (nonatomic) double multiplicator;

@property (weak, nonatomic) UIButton *binaryOperationButton;
@property (nonatomic) BOOL lastOperationIsBinary;

@end

@implementation CalculatorController


//constructors
- (instancetype) initWithInputLabels:(UILabel *)inputL andOutPutLabel:(UILabel *)outputL
{
    if (self = [super init])
    {
        [self resetNumbers];
//        self.inputLabel = inputL;
//        self.outputLabel = outputL;
        inputL.text = outputL.text = @"";
        
        self.formatter = [NSNumberFormatter new];
        [self.formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    
    return self;
}

#pragma mark - property accessors
- (void)setBinaryOperationButton:(UIButton *)binaryOperationButton
{
    _binaryOperationButton = binaryOperationButton;
    
    if (_binaryOperationButton && self.lastOperationIsBinary) {
        [self appendStringToInputLabel:_binaryOperationButton.titleLabel.text];
    }
}

- (void)setOutputNumber:(double)outputNumber
{
    _outputNumber = outputNumber;
    NSString *formatted = [self.formatter stringFromNumber:[NSNumber numberWithFloat:_outputNumber]];
    NSString *newString = [NSString stringWithFormat:@"%@(%@) = %@", self.binaryOperationButton.titleLabel.text, [[OperationsManager sharedInstance] currentOperation], formatted];
    [[OperationsManager sharedInstance] updateLastOperation:newString];
    [[OperationsManager sharedInstance] finalizeLastOperation];
    _currentNumber = 0;
    [self nillBinaryOperationNumber];
}

- (void)setCurrentNumber:(double)currentNumber
{
    _currentNumber = currentNumber;
    
    if (self.binaryOperationButton) {
        [self constructInputLabelTextForBinaryOperation];
    }else{
        NSString *formatted = [self.formatter stringFromNumber:[NSNumber numberWithFloat:_currentNumber]];
//        NSString *newString = [NSString stringWithFormat:@"%@ = %@", [[OperationsManager sharedInstance] currentOperation], formatted];
        [[OperationsManager sharedInstance] updateLastOperation:formatted];
//        [[OperationsManager sharedInstance] finalizeLastOperation];
    }
}

- (void)setMultiplicator:(double)multiplicator
{
    _multiplicator = multiplicator;
}

#pragma mark - miscelenius
- (void)resetNumbers
{
    _currentNumber = _storedNumber = _outputNumber = 0;
    self.multiplicator = POSITIVE_MULTIPLICATOR;
}

- (void)nillBinaryOperationNumber
{
    _binaryOperationButton = [UIButton new];
}

- (void)constructInputLabelTextForBinaryOperation
{
    NSString *storedNumberFormatted = [self.formatter stringFromNumber:[NSNumber numberWithDouble:self.storedNumber]];
    NSString *currentNumberFormatted = [self.formatter stringFromNumber:[NSNumber numberWithDouble:self.currentNumber]];
    [[OperationsManager sharedInstance] updateLastOperation:[NSString stringWithFormat:@"%@ %@ %@", storedNumberFormatted, self.binaryOperationButton.titleLabel.text, currentNumberFormatted]];
//    self.inputLabel.text = [NSString stringWithFormat:@"%@ %@ %@", storedNumberFormatted, self.binaryOperationButton.titleLabel.text, currentNumberFormatted];
}

- (void)appendStringToInputLabel:(NSString *)operationOrNumber
{
    
    NSString *newtext = [[[OperationsManager sharedInstance] currentOperation] stringByAppendingString:[NSString stringWithFormat:@" %@", operationOrNumber]];
    [[OperationsManager sharedInstance] updateLastOperation:newtext];
    
}


#pragma mark #ButtonsPadDelegate

- (void)otherTypeButtonTapped:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"="]) {
        if (self.binaryOperationButton) {
            [self calculateBinaryOperation];
            [self nillBinaryOperationNumber];
            [self resetNumbers];
        }
    }
    
    if ([button.titleLabel.text isEqualToString:@"C"]) {
        [self nillBinaryOperationNumber];
        [self resetNumbers];
//        self.inputLabel.text = self.outputLabel.text = @"";
        [[OperationsManager sharedInstance] finalizeLastOperation];
    }
    
    if ([button.titleLabel.text isEqualToString:@"00"]) {
        if (self.multiplicator > 0) {
            self.currentNumber *= 100;
            return;
        }else{
            
        }
        
        self.currentNumber *= 10*self.multiplicator;
    }
    
    if ([button.titleLabel.text isEqualToString:@"."]) {
        self.multiplicator = NEGATIVE_MULTIPLICATOR;
    }
}

- (void)numberButtonTapped:(UIButton *)button
{
    if (self.multiplicator > 1){
//        self.multiplicator *= 10;
        _currentNumber *= self.multiplicator;
        self.currentNumber += button.tag;
    }else{
        self.currentNumber += self.multiplicator*button.tag;
        self.multiplicator /= 10;
    }
}

- (void)binaryOperationButtonTapped:(UIButton *)button
{
    self.storedNumber = self.currentNumber;
    _currentNumber = 0;
    
    self.binaryOperationButton = button;
}

- (void)calculateBinaryOperation
{
    CGFloat (^operation)(double, double) = [self operationForButton:self.binaryOperationButton];
    self.outputNumber = operation(self.currentNumber, self.storedNumber);
}

- (void)unaryOperationButtonTapped:(UIButton *)button
{
    CGFloat (^operation)(double) = [self unaryOperationforButton:button];
    self.outputNumber = operation(self.currentNumber);

}

// returns a block of code that takes a single parameter to do the calculation for a pressed button
- (CGFloat (^)(double))unaryOperationforButton:(UIButton *)button
{
//    [self resetNumbers];
    self.lastOperationIsBinary = NO;
    self.binaryOperationButton = button;
    CGFloat (^operation)(double);
    
    if([button.titleLabel.text isEqualToString:@"ln"]){
        operation = ^(double first){
            return log(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"cos"]){
        operation = ^(double first){
            return cos(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"Mod"]){
        operation = ^(double first){
            return first > 0 ? first : -first;
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"tan"]){
        operation = ^(double first){
            return tan(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"x2"]){
        operation = ^(double first){
            return 2*first;
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"sin"]){
        operation = ^(double first){
            return sin(first);
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"√"]){
        operation = ^(double first){
            return sqrt(first);
        };
    }
    
    return operation;
}


//returns a block of code that takes 2 parameterrs to do the calculation for a button
- (CGFloat (^)(double, double))operationForButton:(UIButton*)button
{
    self.lastOperationIsBinary = YES;
    CGFloat (^operation)(CGFloat, CGFloat);
//    [self resetNumbers];

    if([button.titleLabel.text isEqualToString:@"*"]){
        operation = ^(double first, double second){
            return first * second;
        };
    }
    if([button.titleLabel.text isEqualToString:@"+"]){
        operation = ^(double first, double second){
            return first + second;
        };
    }
    if([button.titleLabel.text isEqualToString:@"-"]){
        operation = ^(double first, double second){
            return second - first;
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"/"]){
        operation = ^(double first, double second){
            return second / first;
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"%"]){
        operation = ^(double first, double second){
            return (second / 100) * first;
        };
    }
    
    return operation;
}


@end
