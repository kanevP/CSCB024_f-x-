//
//  ButtonsPad.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/7/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol ButtonsPadDelegate <NSObject>

- (void)numberButtonTapped:(UIButton *)button;
- (void)binaryOperationButtonTapped:(UIButton *)button;
- (void)unaryOperationButtonTapped:(UIButton *)button;
- (void)otherTypeButtonTapped:(UIButton *)button;

@end

@interface ButtonsPad : UIView

@property (strong, nonatomic) NSMutableArray *buttons;
@property (weak, nonatomic) id<ButtonsPadDelegate> delegate;

- (instancetype)initWithDelegate:(id<ButtonsPadDelegate>)delegate;

@end
