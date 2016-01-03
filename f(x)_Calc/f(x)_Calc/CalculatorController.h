//
//  CalculatorController.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/22/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ButtonsPad.h"

@protocol CalculatorControllerDelegate <NSObject>

- (void)didFinishCalculation;

@end

@interface CalculatorController : NSObject<ButtonsPadDelegate>

@property (weak, nonatomic) UILabel *inputLabel;
@property (weak, nonatomic) UILabel *outputLabel;

- (instancetype) initWithInputLabels:(UILabel *)inputL andOutPutLabel:(UILabel *)outputL;

@end
