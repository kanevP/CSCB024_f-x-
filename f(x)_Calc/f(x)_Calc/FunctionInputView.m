//
//  FunctionInputView.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 11/8/15.
//  Copyright © 2015 Petar Kanev. All rights reserved.
//

#import "Masonry.h"
#import "FunctionInputView.h"
@interface FunctionInputView ()


@end
@implementation FunctionInputView

- (instancetype)initWithOwner:(UIViewController *)owner
{
    if (self = [super init]) {
        self.owner = owner;
        
        [self addSubview:self.button];
        [self addSubview:self.functionInputTextFiel];
        [self setNeedsUpdateConstraints];
        
//        self.backgroundColor = [UIColor colorWithRed:129.0/255.0 green:206.0/255.0 blue:120.0/255.0 alpha:1];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)updateConstraints
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.mas_leading).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.width.equalTo(@50);
    }];
    
    [self.functionInputTextFiel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.button.mas_trailing).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.trailing.equalTo(self.mas_trailing).with.offset(10);
    }];
    
    [super updateConstraints];
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton new];
        [_button addTarget:self.owner action:@selector(functionButtonTapped) forControlEvents:UIControlEventTouchUpOutside];
        [_button setTitle:@"F(x)" forState:UIControlStateNormal];
    }
    return _button;
}

- (void)functionButtonTapped{}

- (UITextField *)functionInputTextFiel
{
    if (!_functionInputTextFiel) {
        _functionInputTextFiel = [UITextField new];
        _functionInputTextFiel.layer.borderColor = [UIColor colorWithRed:145.0/255.0 green:253.0/255.0 blue:250./255.0 alpha:1].CGColor;
        _functionInputTextFiel.layer.borderWidth = 3;
    }
    return _functionInputTextFiel;
}

@end
