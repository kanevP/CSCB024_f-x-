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


@interface CalculatorController : NSObject<ButtonsPadDelegate>

@property (weak, nonatomic) UILabel *inputLabel;
@property (weak, nonatomic) UILabel *outputLabel;


@end
