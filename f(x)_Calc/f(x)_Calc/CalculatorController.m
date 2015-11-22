//
//  CalculatorController.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/22/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import "CalculatorController.h"

@interface CalculatorController()

@property (nonatomic) CGFloat currentNumber;
@property (nonatomic) CGFloat storedNumber;
@property (nonatomic) CGFloat outputNumber;
@property (nonatomic) NSInteger multiplicator;


@end

@implementation CalculatorController



#pragma mark #ButtonsPadDelegate

- (void)otherTypeButtonTapped:(UIButton *)button
{
    
}

- (void)numberButtonTapped:(UIButton *)button
{
    if (self.multiplicator > 0){
        _currentNumber *= self.multiplicator;
        self.currentNumber += button.tag;
    }else{
        self.multiplicator /= 10;
        self.currentNumber += self.multiplicator*button.tag;
    }
}

-(void)binaryOperationButtonTapped:(UIButton *)button
{
    CGFloat (^operation)(CGFloat, CGFloat) = [self operationForButton:nil];
    self.outputNumber = operation(self.currentNumber, self.storedNumber);
}

- (void)unaryOperationButtonTapped:(UIButton *)button
{
    CGFloat (^operation)(CGFloat) = [self unaryOperationforButton:button];
    self.outputNumber = operation(self.currentNumber);

}

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
            return first - second;
        };
    }
    
    if([button.titleLabel.text isEqualToString:@"/"]){
        operation = ^(CGFloat first, CGFloat second){
            return first / second;
        };
    }
    
    
    if([button.titleLabel.text isEqualToString:@"%"]){
        operation = ^(CGFloat first, CGFloat second){
            return (first / second)*100;
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
