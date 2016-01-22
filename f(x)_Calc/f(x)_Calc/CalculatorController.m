//
//  CalculatorController.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/22/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import "CalculatorController.h"

#define POSITIVE_MULTIPLICATOR 10
#define NEGATIVE_MULTIPLICATOR 0.1

@interface CalculatorController()

@property (nonatomic) CGFloat currentNumber;
@property (nonatomic) CGFloat storedNumber;
@property (nonatomic) CGFloat outputNumber;
@property (nonatomic) CGFloat multiplicator;

@property (weak, nonatomic) UIButton *binaryOperationButton;

@end

@implementation CalculatorController


//constructors
- (instancetype) initWithInputLabels:(UILabel *)inputL andOutPutLabel:(UILabel *)outputL
{
    if (self = [super init])
    {
        [self resetNumbers];
        self.inputLabel = inputL;
        self.outputLabel = outputL;
        inputL.text = outputL.text = @"";
    }
    
    return self;
}

#pragma mark - property accessors
- (void)setBinaryOperationButton:(UIButton *)binaryOperationButton
{
    _binaryOperationButton = binaryOperationButton;
    
    if (_binaryOperationButton) {
        [self appendStringToInputLabel:_binaryOperationButton.titleLabel.text];
    }
}

- (void)setOutputNumber:(CGFloat)outputNumber
{
    _outputNumber = outputNumber;
    self.outputLabel.text = [NSString stringWithFormat:@"%.2f", _outputNumber];
}

- (void)setCurrentNumber:(CGFloat)currentNumber
{
    _currentNumber = currentNumber;
    
    if (self.binaryOperationButton) {
        [self constructInputLabelTextForBinaryOperation];
    }else{
        self.inputLabel.text = [NSString stringWithFormat:@"%.2f", _currentNumber];
    }
}

- (void)setMultiplicator:(CGFloat)multiplicator
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
    self.inputLabel.text = [NSString stringWithFormat:@"%.2f %@ %.2f", self.storedNumber, self.binaryOperationButton.titleLabel.text, self.currentNumber];
}

- (void)appendStringToInputLabel:(NSString *)operationOrNumber
{
    self.inputLabel.text = [self.inputLabel.text stringByAppendingString:[NSString stringWithFormat:@" %@", operationOrNumber]];
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
        self.inputLabel.text = self.outputLabel.text = @"";
    }
    
    if ([button.titleLabel.text isEqualToString:@"00"]) {
        if (self.multiplicator > 0) {
            self.currentNumber *= 100;
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
    CGFloat (^operation)(CGFloat, CGFloat) = [self operationForButton:self.binaryOperationButton];
    self.outputNumber = operation(self.currentNumber, self.storedNumber);
}

- (void)unaryOperationButtonTapped:(UIButton *)button
{
    CGFloat (^operation)(CGFloat) = [self unaryOperationforButton:button];
    self.outputNumber = operation(self.currentNumber);

}

// returns a block of code that takes a single parameter to do the calculation for a pressed button
- (CGFloat (^)(CGFloat))unaryOperationforButton:(UIButton *)button
{
    CGFloat (^operation)(CGFloat);
    
    if([button.titleLabel.text isEqualToString:@"ln"]){
        operation = ^(CGFloat first){
            return log(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"cos"]){
        operation = ^(CGFloat first){
            return cos(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"Mod"]){
        operation = ^(CGFloat first){
            return first > 0 ? first : -first;
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"tan"]){
        operation = ^(CGFloat first){
            return tan(first);
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"x2"]){
        operation = ^(CGFloat first){
            return 2*first;
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"sin"]){
        operation = ^(CGFloat first){
            return sin(first);
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"√"]){
        operation = ^(CGFloat first){
            return sqrt(first);
        };
    }
    
    return operation;
}


//returns a block of code that takes 2 parameterrs to do the calculation for a button
- (CGFloat (^)(CGFloat, CGFloat))operationForButton:(UIButton*)button
{
    CGFloat (^operation)(CGFloat, CGFloat);
    
    if([button.titleLabel.text isEqualToString:@"*"]){
        operation = ^(CGFloat first, CGFloat second){
            return first * second;
        };
    }
    if([button.titleLabel.text isEqualToString:@"+"]){
        operation = ^(CGFloat first, CGFloat second){
            return first + second;
        };
    }
    if([button.titleLabel.text isEqualToString:@"-"]){
        operation = ^(CGFloat first, CGFloat second){
            return second - first;
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"/"]){
        operation = ^(CGFloat first, CGFloat second){
            return second / first;
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"%"]){
        operation = ^(CGFloat first, CGFloat second){
            return (second / 100) * first;
        };
    }
    
    
    //
    //    if([button.titleLabel.text isEqualToString:@"log"]){
    //        operation = ^(CGFloat first, CGFloat second){
    //            return log10f(first) / log10f(second);
    //        };
    //    }
    
    return operation;
}


@end
