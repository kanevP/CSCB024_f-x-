//
//  FunctionInputView.h
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/8/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionInputView : UIView

@property (weak, nonatomic) UIViewController *owner;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UITextField *functionInputTextFiel;


- (instancetype)initWithOwner:(UIViewController *)owner;
@end
